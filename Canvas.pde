class Canvas {
  private Menu myMenu;
  private Brush b;
  private PGraphics pg;
  private String fName;

  private boolean drawStuff;

  private float brushSize;
  private color brushColor;
  private int brushInd;

  private int xOffset;

  int lastX, lastY;

  public Canvas() {
    fName = null;

    /* the drawing canvas */
    pg = createGraphics(width, height, JAVA2D);
    pg.beginDraw();
    pg.smooth();
    pg.colorMode(RGB);
    pg.background(COLOR_CANVAS, 255);
    pg.endDraw();

    // menus and stuff
    b = new Brush();
    myMenu = new Menu(10, 10, width-20, height-20);

    drawStuff = false;

    lastX = -1;
    lastY = -1;

    brushSize = 0.5;
    brushColor = myMenu.getColor();
    brushInd = 0;

    b.setColor(brushColor);
    b.setType(brushInd);
  }

  public void setBrushSize(float f) {
    b.setSize(f);
  }

  public void draw(int mx, int my) {
    if (lastX == -1) {
      lastX = mx;
    }
    if (lastY == -1) {
      lastY = my;
    }

    if (drawStuff) {
      pg.beginDraw();
      b.draw(mx-xOffset, my, lastX-xOffset, lastY, pg);
      pg.endDraw();
    }
    // draw drawing
    image(pg, xOffset, 0);
    // draw menu
    image(myMenu.getMenuImg(), myMenu.getX(), myMenu.getY());

    lastX = mx;
    lastY = my;
  }

  // 
  private void saveImage(String pathname) {
    pathname = trim(pathname);
    String p[] = split(pathname, ',');
    String n = p[0]+p[1] + "/" + p[1] + ".jpg";

    save(n);
    println("Saved : "+ n);
  }


  public void forceClear() {
    pg.beginDraw();
    pg.background(COLOR_CANVAS, 255);
    pg.smooth();

    pg.endDraw();
    this.fName = null;
  }

  public color getBrushColor() {
    return brushColor;
  }

  public void toggleDraw() {
    drawStuff = !drawStuff;
  }
  public void setDraw(boolean b) {
    drawStuff = b;
  }

  public void mouseReleased(int mx, int my) {
    // clicked on menu... update stufff...
    if (myMenu.wasClicked(mx, my)) {
      myMenu.menuMouseReleased(mx, my);

      // update brush stuff...
      brushInd = myMenu.getBrushInd();
      brushColor = myMenu.getColor();

      // update color stufff....
      b.setColor(brushColor);
      b.setType(brushInd);

      // if new menu item was picked, turn off draw
      this.setDraw(false);
    }
    // if not on menu item, just toggle draw mode
    else {
      this.toggleDraw();
    }
  }
  //
}

