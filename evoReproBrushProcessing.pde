// how many brushes
final static int NUM_BRUSHES = 4;

// order of brushes...
final static int BRUSH_LINE  = 0;
final static int BRUSH_POINT = 1;
final static int BRUSH_SPRAY = 2;
final static int BRUSH_CROSS = 3;

final static int BRUSH_SOLID = 4;
final static int BRUSH_DIAG  = 5;
final static int BRUSH_VERT  = 6;

// some color constants
final static int COLOR_CANVAS = 255;
final static int COLOR_BRUSH_ALPHA = 128;

private Canvas c;

void setup() {
  size(800, 600);
  smooth();
  frameRate(60);

  c = new Canvas();
}

void draw() {
  // sempre chamar essa função com as coordenadas da mao
  //    se nao tiver mao, chama usando as ultimas coordenadas detectadas
  c.draw(mouseX, mouseY);
  //println(frameRate);
}

void mouseReleased() {
  // no evento de "push", mandar o x,y pro canvas....
  c.mouseReleased(mouseX, mouseY);
}


// draw rectangles with rounded corners
//    such a hack...
//    create a pgraphic with solid rects and ellipses
//    then copy it onto p with a tint...
void drawRoundRect(int x, int y, int w, int h, int r, color f, PGraphics p) {
  float ta = alpha(f);

  PGraphics tpg;
  tpg = createGraphics(w, h, JAVA2D);
  tpg.beginDraw();
  tpg.background(0, 0);

  // since the circles and rectangles here overlap
  //   we use the color without the alpha, 
  //   and set the alpha later on the resulting image
  tpg.fill(color(red(f), green(f), blue(f), 255));
  tpg.noStroke();

  tpg.ellipse(r, r, 2*r, 2*r);
  tpg.ellipse(w-r, r, 2*r, 2*r);
  tpg.ellipse(w-r, h-r, 2*r, 2*r);
  tpg.ellipse(r, h-r, 2*r, 2*r);

  tpg.rect(0, r, w, h-2*r);
  tpg.rect(r, y, w-2*r, h);

  tpg.endDraw();

  p.beginDraw();
  p.tint(255, ta);
  p.image(tpg, x, y);
  p.endDraw();
}

