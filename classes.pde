
class Blanket {

  ArrayList<Particle> particles;
  ArrayList<Connection> springs;

  Blanket(int ww, int hh, float l, float s, int posx, int posy) {
    particles = new ArrayList<Particle>();
    springs = new ArrayList<Connection>();

    int w = ww;
    int h = hh;

    float len = l;
    float strength = s;

    for (int y=0; y< h; y++) {
      for (int x=0; x < w; x++) {

        Particle p = new Particle(new Vec2D(x*len-w*len/2, posy+y*len));
        physics.addParticle(p);
        particles.add(p);

        if (x > 0) {
          Particle previous = particles.get(particles.size()-2);
          Connection c = new Connection(p, previous, len, strength);
          physics.addSpring(c);
          springs.add(c);
        }

        if (y > 0) {
          Particle above = particles.get(particles.size()-w-1);
          Connection c=new Connection(p, above, len, strength);
          physics.addSpring(c);
          springs.add(c);
        }
      }
    }

    Particle topleft = particles.get(posx);
    topleft.unlock();

    Particle topright = particles.get(w-2);
    topright.lock();
  }

  void display() {
    pg.strokeWeight(1);
    pg.beginShape(TRIANGLE_STRIP);
    pg.noFill();
    for (int i = 0; i < 8; i ++) {
      springs.get(i).out();
      //springs.get(i);  

      pg.vertex(springs.get(i).ax, springs.get(i).ay);
      pg.vertex(springs.get(i).bx, springs.get(i).by);
    }

    pg.endShape();
  }

  void out() {
  }
}

class Connection extends VerletSpring2D {

  float ax;
  float ay;
  float bx;
  float by;
  
  boolean inter;

  Connection(Particle p1, Particle p2, float len, float strength) {
    super(p1, p2, len, strength);
  }


  void out() {

    if (inter) {
      if (mousePressed) {
        if (dist(a.x, a.y, mouseX+cos(a.x*0.1)*2, mouseY+sin(a.y*0.1)*2) < 50) {
          if (a.x - mouseX > 10) {
            a.x = a.x+10;
          } else {
            a.x = a.x-10;
          }
          if (a.y - mouseY > 20) {
            a.y = a.y+10;
          } else {
            a.y = a.y-10;
          }
        }
      }
    }

    ax = a.x;
    ay = a.y;
    bx = b.x;
    by = b.y;
  }
}


class Particle extends VerletParticle2D {

  Particle(Vec2D loc) {
    super(loc);
  }
}
