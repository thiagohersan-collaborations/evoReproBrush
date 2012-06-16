class Menu {
  private int x, y, w, h;
  private verticalSlice brushS, colorS;

  private boolean needsGen;
  private PGraphics mpg;

  private int drawBrushInd;
  private int drawColorInd;

  final color[]  theColors  = {
    color(#00A663), color(#8DC744), color(#F3EA00), color(#F58220), 
    color(#ED1C24), color(#F173AC), color(#8490C8), color(#3E56A6), 
    color(#0091D0), color(#44C8F5), color(#FFFFFF), color(#000000)
  };

  final String[]  theBrushes  = {
    "menu_brush0.png", "menu_brush1.png", "menu_brush2.png", "menu_brush3.png"
  };

  Menu(int x_, int y_, int w_, int h_) {
    w = w_;
    h = h_;
    x = x_;
    y = y_;

    drawBrushInd = 0;
    drawColorInd = 0;

    // calc offsets
    int xo = 5;
    int yo = xo;

    // init the color slice
    colorS = new verticalSlice(x+xo, y+yo, 0, h, theColors.length);
    colorS.initButtons();
    colorS.toggleButton(drawColorInd);
    // set the colors on the buttons of the slice
    colorS.setButtonColor(theColors);
    colorS.setButtonText("test");

    // init the brushes slice
    brushS = new verticalSlice((int)(w*0.8), y+yo, 0, h, theBrushes.length);
    brushS.initButtons();
    brushS.toggleButton(drawBrushInd);
    // set the colors on the buttons of the slice
    brushS.setButtonColor(color(255, 255));
    brushS.setButtonText(theBrushes);
    brushS.setButtonGraphic(theBrushes);

    // init graphics
    mpg = createGraphics(w, h, JAVA2D);
    mpg.beginDraw();
    mpg.smooth();
    mpg.background(255, 0);
    mpg.endDraw();

    needsGen = true;
  }

  public void menuMouseReleased(int mx, int my) {
    // button index
    int bi = -1;

    // check brush slice clicks
    if (brushS.wasClicked(mx, my)) {
      bi = brushS.getButtonClicked(mx, my);
      if (bi > -1) {
        brushS.toggleButton(drawBrushInd);
        drawBrushInd = bi;
        brushS.toggleButton(drawBrushInd);
      }
      //println("brush: "+bi+" was clicked");
    }

    // check color slice clicks
    else if (colorS.wasClicked(mx, my)) {
      bi = colorS.getButtonClicked(mx, my);
      if (bi > -1) {
        colorS.toggleButton(drawColorInd);
        drawColorInd = bi;
        colorS.toggleButton(drawColorInd);
      }
      //println("color: "+bi+" was clicked");
    }

    // if something was clicked, redraw menu...
    if (bi > -1) {
      needsGen = true;
    }
  }

  public color getColor() {
    return theColors[drawColorInd];
  }

  public int getBrushInd() {
    return drawBrushInd;
  }

  private void drawMenuH() {
    mpg.beginDraw();
    mpg.smooth();
    mpg.background(255, 0);
    mpg.blend(brushS.getSliceImg(), 0, 0, brushS.getW(), brushS.getH(), brushS.getX()-x, brushS.getY()-y, brushS.getW(), brushS.getH(), BLEND);
    mpg.blend(colorS.getSliceImg(), 0, 0, colorS.getW(), colorS.getH(), colorS.getX()-x, colorS.getY()-y, colorS.getW(), colorS.getH(), BLEND);
    mpg.endDraw();
  }

  private void drawMenu() {
    if (needsGen == true) {
      this.drawMenuH();
      needsGen = false;
    }
  }

  public PGraphics getMenuImg() {
    this.drawMenu();
    return mpg;
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
  
    // figure out if menu was clicked
  private boolean wasClicked(int mx, int my) {
    return (brushS.wasClicked(mx,my) || colorS.wasClicked(mx,my));
  }

}

