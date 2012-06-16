// one button to rule them all
//    draws its color, then a brush, then a word...
class staticButton {
  private int x, y, w, h;
  private color bc;
  private String txt;

  private PGraphics bpg;

  private boolean needsGen;
  private boolean isSelected;

  private PShape selectedBorder;

  private boolean isSVGLoaded;
  private PGraphics svgG;

  staticButton(int x_, int y_, int w_, int h_) {
    // set some dimensions
    w = w_;
    h = h_;
    x = x_;
    y = y_;
    bc = color(#ff0000);

    txt = "";

    // start graphic
    bpg = createGraphics(w, h, JAVA2D);
    bpg.beginDraw();
    bpg.smooth();
    // transparent background
    bpg.background(255, 0);
    bpg.endDraw();

    // svg graphic
    svgG = createGraphics(w, h, JAVA2D);
    svgG.beginDraw();
    svgG.smooth();
    svgG.background(255, 0);
    svgG.endDraw();

    needsGen = true;
    isSelected = false;
    isSVGLoaded = false;

    selectedBorder = loadShape("menu_border.svg");
  }

  public PGraphics getButtonImg() {
    this.drawButton();
    return bpg;
  }

  // only draw when needed
  private void drawButton() {
    if (needsGen == true) {
      this.drawButtonH();
      needsGen = false;
    }
  }

  private void drawButtonH() {
    this.drawButtonCode();
  }


  // this draws the button, like this : 
  //   first, set bgnd to be equal to the color
  //   then, draw the svg/bmp/etc, if not null
  //   then, draw the text in the center
  private void drawButtonCode() {
    bpg.beginDraw();

    // clear button, by drawing a transparent background
    bpg.background(255, 0);

    // draw a round rectangle
    //   need to set bc externally beforehand
    int cornerRoundness = h/5;
    drawRoundRect(0, 0, w, h, cornerRoundness, bc, bpg);

    // draw the image
    if (isSVGLoaded == true) {
      bpg.copy(svgG, 0, 0, svgG.width, svgG.height, 0, 0, svgG.width, svgG.height);
      //bpg.blend(svgG, 0, 0, svgG.width, svgG.height, 0, 0, svgG.width, svgG.height,BLEND);
    }

    // draw a word...
    if(txt.equals("") == false) {
      PFont theFont = createFont("Arial", 1.3*w/(txt.length()+1));
      bpg.textFont(theFont);
      bpg.textAlign(CENTER, CENTER);
      //bpg.fill(#0061a8);
      bpg.fill(0, 255);
      bpg.text(txt, 0, 0, w, h);
    }

    // draw selection border
    if (isSelected) {
      bpg.shape(selectedBorder, 0, 0, w, h);
    }


    bpg.endDraw();
  }

  public void setColor(color c) {
    if ((c == color(0))) {
      //selectedBorder = loadShape("menu_border_w.svg");
    }
    bc = c;
    needsGen = true;
  }
  public void setGraphic(PShape ps) {
    svgG.beginDraw();
    svgG.smooth();
    svgG.shape(ps, 1, 1, w-2, h-2);

    svgG.endDraw();
    isSVGLoaded = true;
  }
  public void setGraphic(PGraphics pg) {
    svgG.beginDraw();
    svgG.smooth();
    svgG.copy(pg, 0,0, pg.width, pg.height, 1, 1, w-2, h-2);
    svgG.endDraw();
    isSVGLoaded = true;
  }
  public void setText(String t) {
    txt = t;
    needsGen = true;
  }
  public void setIsSelected(boolean b) {
    isSelected = b;
  }
  public void toggleIsSelected() {
    isSelected = !isSelected;
    needsGen = true;
  }

  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }
  public int getW() {
    return w;
  }
  public int getH() {
    return h;
  }

  public boolean wasClicked(int cx, int cy) {
    return ((cx >= x)&&(cx <= (x+w)) && (cy >= y)&&(cy <=(y+h)));
  }
}

