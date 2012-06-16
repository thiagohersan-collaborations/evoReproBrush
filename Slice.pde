// vertical collection of buttons
class verticalSlice {
  private int x, y, w, h;

  private PGraphics spg;

  private int numButtons;
  private ArrayList<staticButton> buttons;

  boolean needsGen;

  verticalSlice(int x_, int y_, int w_, int h_, int nb) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    numButtons = nb;

    buttons = null;
    spg = null;

    // can't draw yet
    needsGen = false;
  }

  // initializes slice with empty buttons of the right size
  public void initButtons() {
    // button x,y-offset
    int bxo = 0;
    int byo = 5;

    // calc button width and height...
    int bh = (h-byo*numButtons-byo)/numButtons;
    int bw = bh;

    // init buttons
    buttons = (buttons == null)?(new ArrayList<staticButton>()):buttons;
    for (int i=0;i<numButtons;i++) {
      // button x,y offset
      int bx = bxo;
      int by = i*(bh+byo);
      buttons.add(new staticButton(x+bx, y+by, bw, bh));
    }

    // calc w
    w = bw+2*bxo;

    // init graphic
    spg = createGraphics(w, h, JAVA2D);
    spg.beginDraw();
    spg.smooth();
    // draw a completely transparent slice initially
    spg.background(255, 0);
    spg.endDraw();

    // now we can draw
    needsGen = true;
  }

  // set color on all buttons of slice using an array
  public void setButtonColor(color[] cArr) {
    for (int i=0; (i<numButtons)&&(i<cArr.length); i++) {
      buttons.get(i).setColor(cArr[i]);
    }
    // need to update graphic
    needsGen = true;
  }
  // set color on all buttons of slice using same color
  public void setButtonColor(color c) {
    for (int i=0; (i<numButtons); i++) {
      buttons.get(i).setColor(c);
    }
    // need to update graphic
    needsGen = true;
  }

  // set text on all buttons of slice using an array
  public void setButtonText(String[] tArr) {
    for (int i=0; (i<numButtons)&&(i<tArr.length); i++) {
      buttons.get(i).setText(tArr[i]);
    }
    // need to update graphic
    needsGen = true;
  }
  // set text on all buttons of slice using same color
  public void setButtonText(String t) {
    for (int i=0; (i<numButtons); i++) {
      buttons.get(i).setText(t);
    }
    // need to update graphic
    needsGen = true;
  }

  // set image on all buttons of slice using an array
  public void setButtonGraphic(String[] fnArr) {
    for (int i=0; (i<numButtons)&&(i<fnArr.length); i++) {
      // for now only loads png ... could be smarter...
      PImage tpi = loadImage(fnArr[i]);
      PGraphics tpg = createGraphics(tpi.width,tpi.height,JAVA2D);
      tpg.beginDraw();
      tpg.smooth();
      tpg.image(tpi,0,0);
      tpg.endDraw();
      buttons.get(i).setGraphic(tpg);
    }
    // need to update graphic
    needsGen = true;
  }
  // set image on all buttons of slice using same color
  public void setButtonGraphic(String fn) {
    for (int i=0; (i<numButtons); i++) {
      buttons.get(i).setText(fn);
    }
    // need to update graphic
    needsGen = true;
  }


  public void toggleButton(int i) {
    buttons.get(i).toggleIsSelected();
    needsGen = true;
  }

  // only draw when needed
  private void drawSlice() {
    if (needsGen == true) {
      this.drawSliceH();
      needsGen = false;
    }
  }

  private void drawSliceH() {
    spg.beginDraw();
    spg.smooth();
    spg.background(255, 0);

    for (int i=0;i<numButtons;i++) {
      staticButton b = buttons.get(i);
      spg.blend(b.getButtonImg(), 0, 0, b.getW(), b.getH(), b.getX()-x, b.getY()-y, b.getW(), b.getH(), BLEND);
    }
    spg.endDraw();
  }

  public PGraphics getSliceImg() {
    if (buttons != null) {
      this.drawSlice();
    }
    else {
      println("ohhh no: buttons is null. need to init this slice");
    }
    return spg;
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

  // figure out if slice was clicked
  private boolean wasClicked(int mx, int my) {
    return ((mx>=x)&&(mx<=(x+w)) && (my>=y)&&(my<=(y+h)));
  }

  // return number of the first button that was clicked in this slice
  public int getButtonClicked(int mx, int my) {
    for (int i=0; i<buttons.size(); i++) {
      if (buttons.get(i).wasClicked(mx, my)) {
        return i;
      }
    }
    return -1;
  }
}

