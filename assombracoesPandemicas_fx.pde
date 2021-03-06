import gab.opencv.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.*;
import toxi.geom.*;
import toxi.math.*;

VerletPhysics2D physics;

Blanket resist;
Blanket op;
Blanket b, b2, b3, b4;

OpenCV opencv; 
OpenCV opencv2; 
OpenCV opencv3;
OpenCV opencv4;

ArrayList<Contour> contours = new ArrayList<Contour>();
ArrayList<Contour> contours2 = new ArrayList<Contour>();
ArrayList<Contour> contours3 = new ArrayList<Contour>();
ArrayList<Contour> contours4 = new ArrayList<Contour>();

PImage telai;
PImage onca;
PImage amazonia;
PImage caborja;
PImage jacare;
PImage bbleta;
PImage arvore;
PImage peixe;

Table tabela1;
int c;

int count;
float t;

int[] mortesD = new int[2000];
int[] casesD = new int[2000];

boolean botaoO;
boolean botaoC;
boolean b_caborja;
boolean b_onca;
boolean b_jacare;
boolean b_bbleta;

boolean left, right, up, down;

boolean resistencia;

boolean link1;
boolean link2;

float posx[] = new float[1208];
float posy[] = new float[720];

float posX = 0;
float posY = 0;
float posZ = 0;
float ZZ;

float conX, conY;

boolean bt2, bt3;

//tamanho máximo dos graficos
int maxgcaborja;

PFont font1, font2;

float alpha1 = 0;
float alphaCaborja = 0;
float alphaJacare = 0;
float alphaBbleta = 0;

int etnomidia;
int et_y = 235;
int velet_y = 2;

color c_artes;

PGraphics pg;

float ry = 0;

void setup() {
  size(1280, 720, P3D);

  pg = createGraphics(width, height, P3D);

  physics = new VerletPhysics2D();
  //physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.01)));
  physics.setWorldBounds(new Rect(0, 0, width, height));

  resist = new Blanket(40, 40, 200, 0.1, 60, 100);

  b = new Blanket(20, 20, 150, 0.05, 300, 100);
  b2 = new Blanket(60, 60, 150, 0.01, 300, 100);
  b3 = new Blanket(30, 30, 150, 0.01, 300, 200);


  //tabela1 = loadTable("owid-covid-data.csv", "header");
  //println(tabela1.getColumnCount());

  //for (TableRow tr : tabela1.rows()) {

  //  String pais = tr.getString("location");
  //  int nMortes = tr.getInt("new_deaths");
  //  int nCases = tr.getInt("new_cases");

  //  if (pais.equals("Brazil") == true) {
  //    c++;
  //    mortesD[c++] = nMortes;
  //    casesD[c++] = nCases;
  //  }
  //}

  telai = loadImage("tela_inicial.jpg");

  amazonia = loadImage("2-a-amazonia-representa-mais-da-metade-das-florestas-do-planeta-1484665376333_956x500.jpg");
  amazonia.resize(1280, 720*2);

  onca = loadImage("baniwa2.png");
  onca.resize(720, 400);

  caborja = loadImage("023-532x1024.jpg");
  caborja.resize(270, 600);

  jacare = loadImage("jacare_harrypinedo_recorte.png");
  jacare.resize(720, 400);

  bbleta = loadImage("borboleta_harrypinedo_recorte.png");
  bbleta.resize(400, 260);

  arvore = loadImage("arvore.jpeg");
  //arvore.resize(400, 720);

  peixe = loadImage("image5.png");

  opencv = new OpenCV(this, telai);
  opencv.gray();
  opencv.threshold(240);
  opencv.blur(2);
  contours = opencv.findContours();

  opencv2 = new OpenCV(this, caborja);
  opencv2.gray();
  opencv2.threshold(120);
  opencv2.blur(2);
  contours2 = opencv2.findContours();

  opencv3 = new OpenCV(this, arvore);
  opencv3.gray();
  opencv3.threshold(120);
  opencv3.blur(2);
  contours3 = opencv3.findContours();

  opencv4 = new OpenCV(this, peixe);
  opencv4.gray();
  opencv4.threshold(120);
  opencv4.blur(2);
  contours4 = opencv4.findContours();

  font1 = createFont("Barlow Bold", 200);
  textFont(font1);

  font2 = createFont("Barlow", 200);

  //printArray(font.list());

  pg.smooth(8);
}


void draw() {
  pg.beginDraw();
  pg.background(0);



  //directionalLight(240, 240, 240, -1, cos(0.1+t)*2, -1);

  pg.textFont(font1);
  //tela inicial --------------------------------
  pg.push();
  if (frameCount > 0 && frameCount < 2*30) {
    pg.textSize(40);
    pg.fill(240, 240);
    pg.text("assombrações pandêmicas", 100, height/2-250);

    pg.push();
    pg.translate(100, height/2-230);
    for (Contour contour : contours) {

      pg.strokeWeight(0.6);

      pg.beginShape();
      for (PVector point : contour.getPolygonApproximation().getPoints()) {
        c = telai.get((int)point.x, (int)point.y);

        pg.stroke(240, 200);
        pg.noFill();
        pg.curveVertex(point.x*1.3, point.y);
      }
      pg.endShape();
    }
    pg.pop();
  }
  pg.pop();

  t += 0.01;

  posX = constrain(posX, -600, 600);
  posY = constrain(posY, 0, 600);


  //println(conX, " ", conY);
  pg.push();
  pg.translate(posX, posY, posZ);

  physics.update();
  pg.textFont(font2);
  if (frameCount > 3*30) {

    conX = mouseX - posX;
    conY = mouseY - posY;

    pg.beginShape();
    pg.noFill();
    for (int i = 0; i < 16; i ++) {
      pg.stroke(240, 0, 0, 150);
      b.springs.get(i).out();
      b.springs.get(i).inter = true;
      if (ZZ > -300 && ZZ < 300) {
        b.springs.get(i).inter = true;
      } else {
        b.springs.get(i).inter = false;
      }

      pg.curveVertex(b.springs.get(i).ax, b.springs.get(i).ay);
      //pg.vertex(b.springs.get(i).bx, b.springs.get(i).by);
    }
    for (int i = 0; i < 28; i ++) {
      pg.stroke(50, 100, 0, 150);
      b2.springs.get(i).out();
      b2.springs.get(i).inter = true;
      if (ZZ > 300 && ZZ < 900) {
        b2.springs.get(i).inter = true;
      } else {
        b2.springs.get(i).inter = false;
      }
      //pg.vertex(b2.springs.get(i).ax, b2.springs.get(i).ay, -600);
      pg.curveVertex(b2.springs.get(i).bx, b2.springs.get(i).by, -600);
    }
    for (int i = 0; i < 18; i ++) {
      pg.stroke(50, 10, 200, 150);
      b3.springs.get(i).out();
      b3.springs.get(i).inter = true;
      if (ZZ > 900 && ZZ < 1500) {
        b3.springs.get(i).inter = true;
      } else {
        b3.springs.get(i).inter = false;
      }
      //pg.vertex(b3.springs.get(i).ax, b3.springs.get(i).ay, -1200);
      pg.curveVertex(b3.springs.get(i).bx, b3.springs.get(i).by, -1200);
    }
    pg.endShape();

    //LIDERANÇAS-------------------------------------------------------------------
    for (int i = 0; i < 16; i ++) {
      b.springs.get(i).out();

      pg.noStroke();
      pg.ellipse(b.springs.get(i).ax, b.springs.get(i).ay, 8, 8);

      //pg.fill(240);
      //pg.textSize(20);
      //pg.text("LIDERANÇAS", b.springs.get(0).ax, b.springs.get(0).ay);
      pg.textSize(10);

      pg.textAlign(LEFT, BOTTOM);
      //println("ax ", b.springs.get(3).ax, "ay ", b.springs.get(3).ay);
      if (dist(b.springs.get(3).ax, b.springs.get(3).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(200, 100, 15);
      }
      pg.text("Sonia Guajajara", b.springs.get(3).ax, b.springs.get(3).ay);

      float bx1 = pg.screenX(b.springs.get(5).ax, b.springs.get(5).ay);
      float by1 = pg.screenY(b.springs.get(5).ax, b.springs.get(5).ay);

      if (dist(bx1, by1, mouseX, mouseY) < 80) {
        pg.fill(240);
      } else {
        pg.fill(200, 100, 15);
      }
      pg.text("Ailton Krenak", b.springs.get(5).ax, b.springs.get(5).ay);

      if (dist(b.springs.get(7).ax, b.springs.get(7).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(200, 100, 15);
      }
      text("Celia Xakriabá", b.springs.get(7).ax, b.springs.get(7).ay);

      if (dist(b.springs.get(9).ax, b.springs.get(9).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(200, 100, 15);
      }
      pg.text("Denilson Baniwa", b.springs.get(9).ax, b.springs.get(9).ay);

      if (dist(b.springs.get(11).ax, b.springs.get(11).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(200, 100, 15);
      }
      pg.text("Jaider Esbell", b.springs.get(11).ax, b.springs.get(11).ay);

      if (dist(b.springs.get(13).ax, b.springs.get(13).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(200, 100, 15);
      }
      pg.text("Cacique Babau Tupinamba", b.springs.get(13).ax, b.springs.get(13).ay);

      if (dist(b.springs.get(15).ax, b.springs.get(15).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(200, 100, 15);
      }
      pg.text("Daiara Tukano", b.springs.get(15).ax, b.springs.get(15).ay);
      pg.fill(200, 100, 15);
    }


    //ETNOMÍDIA-------------------------------------------------------------------
    for (int i = 0; i < 28; i ++) {
      b2.springs.get(i).out();

      pg.push();
      pg.translate(0, 0, -600);
      pg.noStroke();
      pg.fill(255, 0, 100);
      pg.ellipse(b2.springs.get(i).ax, b2.springs.get(i).ay, 8, 8);
      //pg.textSize(20);
      //pg.fill(240);
      //pg.text("ETNOMÍDIA", b2.springs.get(0).ax, b2.springs.get(0).ay);
      pg.textSize(10);

      pg.textAlign(LEFT, BOTTOM);
      //println("ax ", b.springs.get(3).ax, "ay ", b.springs.get(3).ay);
      if (dist(b2.springs.get(3).ax, b2.springs.get(3).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Midia India", b2.springs.get(3).ax, b2.springs.get(3).ay);

      if (dist(b2.springs.get(5).ax, b2.springs.get(5).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Radio Yande", b2.springs.get(5).ax, b2.springs.get(5).ay);

      if (dist(b2.springs.get(7).ax, b2.springs.get(7).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Video nas Aldeias", b2.springs.get(7).ax, b2.springs.get(7).ay);

      if (dist(b2.springs.get(9).ax, b2.springs.get(9).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Tingui Filmes", b2.springs.get(9).ax, b2.springs.get(9).ay);

      if (dist(b2.springs.get(11).ax, b2.springs.get(11).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Selvagem Ciclo", b2.springs.get(11).ax, b2.springs.get(11).ay);

      if (dist(b2.springs.get(13).ax, b2.springs.get(13).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Cristin Wariu", b2.springs.get(13).ax, b2.springs.get(13).ay);

      if (dist(b2.springs.get(15).ax, b2.springs.get(15).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("APIB", b2.springs.get(15).ax, b2.springs.get(15).ay);

      if (dist(b2.springs.get(17).ax, b2.springs.get(17).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Alice Pataxó", b2.springs.get(17).ax, b2.springs.get(17).ay);

      if (dist(b2.springs.get(19).ax, b2.springs.get(19).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Takumã Pataxó", b2.springs.get(19).ax, b2.springs.get(19).ay);

      if (dist(b2.springs.get(21).ax, b2.springs.get(21).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Weena Tikuna", b2.springs.get(21).ax, b2.springs.get(21).ay);

      if (dist(b2.springs.get(23).ax, b2.springs.get(23).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Mi Mawai", b2.springs.get(23).ax, b2.springs.get(23).ay);

      if (dist(b2.springs.get(25).ax, b2.springs.get(25).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Cunumi MC", b2.springs.get(25).ax, b2.springs.get(25).ay);

      if (dist(b2.springs.get(27).ax, b2.springs.get(27).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(129, 49, 128);
      }
      pg.text("Tingui Botó", b2.springs.get(27).ax, b2.springs.get(27).ay);

      pg.pop();
    }

    //ARTES-------------------------------------------------------------------
    for (int i = 0; i < 18; i ++) {
      b3.springs.get(i).out();

      pg.push();
      pg.translate(0, 0, -1200);
      pg.fill(100, 255, 255);
      pg.ellipse(b3.springs.get(i).ax, b3.springs.get(i).ay, 8, 8);
      //pg.textSize(20);
      //pg.fill(240);
      //pg.text("CIRCUITO DAS ARTES", b3.springs.get(0).ax, b3.springs.get(0).ay);
      pg.textSize(10);


      if (dist(b3.springs.get(2).ax, b3.springs.get(2).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(80, 200, 80);
      }
      pg.text("Projeto um Outro Céu", b3.springs.get(2).ax, b3.springs.get(2).ay);

      if (dist(b3.springs.get(4).ax, b3.springs.get(4).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(80, 200, 80);
      }
      pg.text("A cidade precisa de você", b3.springs.get(4).ax, b3.springs.get(4).ay);

      if (dist(b3.springs.get(6).ax, b3.springs.get(6).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(80, 200, 80);
      }
      pg.text("Exposição Vexoá: Nós sabemos", b3.springs.get(6).ax, b3.springs.get(6).ay);

      if (dist(b3.springs.get(8).ax, b3.springs.get(8).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(80, 200, 80);
      }
      pg.text("Exposição Mundos Indígenas", b3.springs.get(8).ax, b3.springs.get(8).ay);

      if (dist(b3.springs.get(10).ax, b3.springs.get(10).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(80, 200, 80);
      }
      pg.text("Denilson Baniwa", b3.springs.get(10).ax, b3.springs.get(10).ay);

      if (dist(b3.springs.get(12).ax, b3.springs.get(12).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(80, 200, 80);
      }
      pg.text("Exposição Netos de Macunaimi", b3.springs.get(12).ax, b3.springs.get(12).ay);

      if (dist(b3.springs.get(14).ax, b3.springs.get(14).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(80, 200, 80);
      }
      pg.text("34° Bienal de São Paulo", b3.springs.get(14).ax, b3.springs.get(14).ay);

      if (dist(b3.springs.get(16).ax, b3.springs.get(16).ay, conX, conY) < 50) {
        pg.fill(240);
      } else {
        pg.fill(80, 200, 80);
      }
      pg.text("Prêmio PIPA", b3.springs.get(16).ax, b3.springs.get(16).ay);

      pg.pop();
    }


    //ellipse(b.springs.get(0).bx, b.springs.get(0).by, 40, 40);
    //ellipse(b2.springs.get(0).bx, b2.springs.get(0).by, 40, 40);
    //ellipse(b3.springs.get(0).bx, b3.springs.get(0).by, 40, 40);

    //----------------- arvore
    pg.push();
    pg.translate(width/2-(arvore.width/2), -200, -1000);
    for (Contour contour : contours3) {

      pg.strokeWeight(0.8);

      pg.beginShape(QUAD_STRIP);
      for (PVector point : contour.getPoints()) {
        color c = arvore.get((int)point.x, (int)point.y);

        float s = saturation(c);

        pg.stroke(c, 127+cos(s*0.01+t)*127);
        pg.noFill();
        if (point.x > 10 && point.x < arvore.width-10 && point.y > 10 && point.y < arvore.height-10) {
          //vertex(point.x, point.y,-30);
          pg.vertex(point.x+cos(point.x*0.01+t), point.y);
        }
      }
      pg.endShape();
    }
    pg.pop();


    //----------- cobra
    pg.push();
    pg.translate(width/2-(peixe.width/2), 600, -1000);
    for (Contour contour : contours4) {
      pg.strokeWeight(0.8);

      pg.beginShape(QUAD_STRIP);
      for (PVector point : contour.getPoints()) {
        color c = peixe.get((int)point.x, (int)point.y);

        float s = saturation(c);

        pg.stroke(c, 127+cos(s*0.01+t)*127);
        pg.noFill();

        //vertex(point.x, point.y,-30);
        pg.vertex(point.x-tan(0.001+t)*80, point.y+sin(point.y*0.01+t*10)*20);
      }
      pg.endShape();
    }
    pg.pop();
  }

  //for (int i = 0; i < 26; i ++) {
  //  push();
  //  translate(0, 0, -600);
  //  noStroke();
  //  ellipse(b2.springs.get(i).ax, b2.springs.get(i).ay, 8, 8);
  //  pop();
  //}


  //amazonia --------------------------------
  pg.push();
  pg.translate(-1400, height-200, -1200+posZ);
  pg.scale(3, 1);
  pg.rotateX(radians(448));
  pg.beginShape(POINTS);
  for (int x = 0; x < width; x+= 6) {
    for (int y = 0; y < height*4; y+= 6) {
      color c = amazonia.get(x, y);

      float d = dist(x, y, mouseX+cos(x*0.1)*2, mouseY+sin(y*0.1)*2);
      float mD = dist(0, 0, width/2, height/2);
      float mapD = map(d, 0, mD, 0, 20);

      pg.strokeWeight(0.9);

      float s = saturation(c);

      float z = map(brightness(c), 0, 255, -120, 0);
      pg.noFill();
      pg.stroke(c, 127+sin(s*0.01+t)*127);
      pg.vertex(x+cos(x*0.01+t)*50+mapD, y+sin(y*0.05+t)*50+mapD, z);
    }
  }
  pg.endShape();
  pg.pop();


  //caborja----------------------------------------
  if (mouseX > 600 && mouseX < 600+caborja.width && mouseY > 200 && mouseY < 200+caborja.height && posZ > 100 && posZ < 300) {
    b_caborja = true;
    alphaCaborja+=4;
  } else {
    alphaCaborja-=4;
    if (alphaCaborja <= 0 ) {
      b_caborja = false;
    }
  }

  alphaCaborja = constrain(alphaCaborja, 0, 255);

  if (b_caborja) {
    pg.push();
    pg.translate(600, 50, 0);
    for (Contour contour : contours2) {

      pg.strokeWeight(0.8);

      pg.beginShape(QUAD_STRIP);
      for (PVector point : contour.getPoints()) {
        //color c = caborja.get((int)point.x, (int)point.y);

        pg.stroke(240, alphaCaborja);
        pg.noFill();
        if (point.x > 10 && point.x < caborja.width-10 && point.y > 10 && point.y < caborja.height-10) {
          //vertex(point.x, point.y,-30);
          pg.vertex(point.x+cos(point.x*0.01+t)*50, point.y);
        }
      }
      pg.endShape();
    }
    pg.pop();
  }

  //jacare----------------------------------------
  if (mouseX > 200 && mouseX < 200+jacare.width && mouseY > 200 && mouseY < 200+jacare.height && posZ > 200 && posZ < 400) {
    b_jacare = true;
    alphaJacare+=4;
  } else {
    alphaJacare-=4;
    if (alphaJacare <= 0 ) {
      b_jacare = false;
    }
  }

  alphaJacare = constrain(alphaJacare, 0, 255);

  if (b_jacare) {
    pg.push();
    pg.translate(200, 200, -100);
    pg.beginShape(POINTS);
    for (int x = 0; x < jacare.width; x+= 3) {
      for (int y = 0; y < jacare.height; y+= 3) {
        color c = jacare.get(x, y);

        pg.strokeWeight(1.5);

        float z = map(saturation(c), 0, 255, -120, 0);
        pg.noFill();
        pg.stroke(c, alphaJacare);
        pg.vertex(x, y+sin(y*0.01+t)*40, z);
      }
    }
    pg.endShape();
    pg.pop();
  }

  //borboleta----------------------------------------
  if (mouseX > 800 && mouseX < 800+bbleta.width && mouseY > 100 && mouseY < 100+bbleta.height && posZ > 200 && posZ < 400) {
    b_bbleta = true;
    alphaBbleta+=4;
  } else {
    alphaBbleta-=4;
    if (alphaBbleta <= 0 ) {
      b_bbleta = false;
    }
  }

  alphaBbleta = constrain(alphaBbleta, 0, 255);

  if (b_bbleta) {
    pg.push();
    pg.translate(800, 100, -100);
    pg.beginShape(QUAD_STRIP);
    for (int x = 0; x < bbleta.width; x+= 3) {
      for (int y = 0; y < bbleta.height; y+= 3) {
        color c = bbleta.get(x, y);

        pg.strokeWeight(0.8);

        float z = map(saturation(c), 0, 255, -80, 0);
        pg.noFill();
        pg.stroke(c, alphaBbleta);
        pg.vertex(x, y+sin(y*0.01+t)*40, z);
      }
    }
    pg.endShape();
    pg.pop();
  }


  ////onça-------------------------------------------
  if (mouseX > -200 && mouseX < -200+onca.width && mouseY > 0 && mouseY < onca.height && posZ > 300) {
    b_onca = true;
    alpha1+=4;
  } else {
    alpha1-=4;
    if (alpha1 <=0) {
      b_onca = false;
    }
  }

  alpha1 = constrain(alpha1, 0, 255);

  if (b_onca) {
    pg.push();
    pg.translate(-200, 0, -300);
    pg.beginShape(QUAD_STRIP);
    for (int x = 0; x < onca.width; x+= 4) {
      for (int y = 0; y < onca.height; y+= 4) {
        color c = onca.get(x, y);

        float d = dist(x, y, mouseX+cos(x*0.1)*2, mouseY+sin(y*0.1)*2);
        float mD = dist(0, 0, width/2, height/2);
        float mapD = map(d, 0, mD, 0, 20);

        pg.strokeWeight(0.5);

        float z = map(brightness(c), 0, 255, -50, 0);
        pg.noFill();

        pg.stroke(c, alpha1);

        pg.vertex(x+cos(x*0.01+t)*50+mapD, y, z);
      }
    }
    pg.endShape();
    pg.pop();
  }

  pg.pop();

  if (up) {
    posY += 50;
  }
  if (down) {
    posY -= 50;
  }
  if (left) {
    posX += 10;
  }
  if (right) {
    posX -= 10;
  }

  pg.endDraw();
  image(pg, 0, 0);



  //saveFrame("frames/f_#####.png");
}


void keyPressed() {
  if (keyCode == BACKSPACE) {
    resistencia = false;
  }
  setMove(keyCode, true);
}

void keyReleased() {
  setMove(keyCode, false);
}

//void mouseClicked(MouseEvent evt) {
//  if (dist(b.springs.get(3).ax,b.springs.get(3).ay, conX, conY) < 50) {
//    if (evt.getCount() == 2) {
//      link("https://www.instagram.com/guajajarasonia/");
//    };
//  }
//  if (dist(b.springs.get(7).ax,b.springs.get(7).ay, conX, conY) < 50) {
//    if (evt.getCount() == 2) {
//      link("https://www.instagram.com/celia.xakriaba/");
//    };
//  }
//}

void mousePressed() {
  //LIDERANÇAS
  //if (dist(b.springs.get(3).ax, b.springs.get(3).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/guajajarasonia/");
  //}
  //if (dist(b.springs.get(5).ax, b.springs.get(5).ay, conX, conY) < 50) {
  //  link("https://pt.wikipedia.org/wiki/Ailton_Krenak");
  //}
  //if (dist(b.springs.get(7).ax, b.springs.get(7).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/celia.xakriaba/");
  //}
  //if (dist(b.springs.get(9).ax, b.springs.get(9).ay, conX, conY) < 50) {
  //  link("https://www.behance.net/denilsonbaniwa");
  //}
  //if (dist(b.springs.get(11).ax, b.springs.get(11).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/jaider_esbell/");
  //}
  //if (dist(b.springs.get(13).ax, b.springs.get(13).ay, conX, conY) < 50) {
  //  link("https://pt.wikipedia.org/wiki/Babau_Tupinamb%C3%A1");
  //}
  //if (dist(b.springs.get(15).ax, b.springs.get(15).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/daiaratukano/");
  //}

  ////ETNOMIDIA
  //if (dist(b2.springs.get(3).ax, b2.springs.get(3).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/midiaindiaoficial/");
  //}
  //if (dist(b2.springs.get(5).ax, b2.springs.get(5).ay, conX, conY) < 50) {
  //  link("https://radioyande.com/");
  //}
  //if (dist(b2.springs.get(7).ax, b2.springs.get(7).ay, conX, conY) < 50) {
  //  link("http://www.videonasaldeias.org.br/2009/");
  //}
  //if (dist(b2.springs.get(9).ax, b2.springs.get(9).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/tingui.filmes/");
  //}
  //if (dist(b2.springs.get(11).ax, b2.springs.get(11).ay, conX, conY) < 50) {
  //  link("selvagemciclo.com.br");
  //}
  //if (dist(b2.springs.get(13).ax, b2.springs.get(13).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/cristianwariu/");
  //}
  //if (dist(b2.springs.get(15).ax, b2.springs.get(15).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/apiboficial/");
  //}
  //if (dist(b2.springs.get(17).ax, b2.springs.get(17).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/alice_pataxo/");
  //}
  //if (dist(b2.springs.get(19).ax, b2.springs.get(19).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/tukuma_pataxo/");
  //}
  //if (dist(b2.springs.get(21).ax, b2.springs.get(21).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/weena_tikuna/");
  //}
  //if (dist(b2.springs.get(23).ax, b2.springs.get(23).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/mimawai/");
  //}
  //if (dist(b2.springs.get(25).ax, b2.springs.get(25).ay, conX, conY) < 50) {
  //  link("https://www.instagram.com/kunumi.mc/");
  //}
  //if (dist(b2.springs.get(27).ax, b2.springs.get(27).ay, conX, conY) < 50) {
  //  link("https://jairantinguiboto.com/");
  //}

  ////CIRCUITO DAS ARTES
  //if (dist(b3.springs.get(2).ax, b3.springs.get(2).ay, conX, conY) < 50) {
  //  link("https://umoutroceu.ufba.br");
  //}
  //if (dist(b3.springs.get(4).ax, b3.springs.get(4).ay, conX, conY) < 50) {
  //  link("https://festivalacidadeprecisa.org/denilson-baniwa/");
  //}
  //if (dist(b3.springs.get(6).ax, b3.springs.get(6).ay, conX, conY) < 50) {
  //  link("https://pinacoteca.org.br/programacao/vexoa-nos-sabemos/");
  //}
  //if (dist(b3.springs.get(8).ax, b3.springs.get(8).ay, conX, conY) < 50) {
  //  link("https://youtu.be/XjQ64Wv6WGE");
  //}
  //if (dist(b3.springs.get(10).ax, b3.springs.get(10).ay, conX, conY) < 50) {
  //  link("https://www.behance.net/denilsonbaniwa");
  //}
  //if (dist(b3.springs.get(12).ax, b3.springs.get(12).ay, conX, conY) < 50) {
  //  link("http://www.musa.ufpr.br/links/exposicoes/2019/2019_Makunaimi.html");
  //}
  //if (dist(b3.springs.get(14).ax, b3.springs.get(14).ay, conX, conY) < 50) {
  //  link("http://34.bienal.org.br/exposicoes/8462#:~:text=A%20mostra%20reunir%C3%A1%20trabalhos%20de,%2C%20Xirixana%2C%20Wapichana%20e%20Yanomami");
  //}
  //if (dist(b3.springs.get(16).ax, b3.springs.get(14).ay, conX, conY) < 50) {
  //  link("https://www.premiopipa.com/");
  //}


  if (mouseX > 0 && mouseX < onca.width && mouseY > 0 && mouseY < onca.height && posZ > 700) {
    botaoO =! botaoO;
    botaoC = false;
  };

  //if (mouseX > 600 && mouseX < 600+caborja.width && mouseY > 200 && mouseY < 200+caborja.height && posZ > 200 && posZ < 400) {
  //  botaoC =! botaoC;
  //  botaoO = false;
  //}

  // if (mouseX > 600 && mouseX < 600+caborja.width && mouseY > 200 && mouseY < 200+caborja.height && posZ > 200 && posZ < 400) {
  //  botaoC =! botaoC;
  //  botaoO = false;
  //}
}

void mouseWheel(MouseEvent me) {
  final int inc = keyPressed & keyCode == CONTROL ? -50 : 50;
  posZ = constrain(posZ + me.getCount()*inc, 0, 600);

  //println(posZ+ me.getCount()*inc);

  ZZ = posZ + me.getCount()*inc;
}

boolean setMove(int k, boolean b) {
  switch (k) {
  case UP:
    return up = b;

  case DOWN:
    return down = b;

  case LEFT:
    return left = b;

  case RIGHT:
    return right = b;

  default:
    return b;
  }
}
