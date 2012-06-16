class Brush {
  private BrushType bt;
  private float bSize;
  private color bColor;
  private int bInd;
  private int numOfBrushes;

  private BrushType btArr[] = new BrushType[NUM_BRUSHES];

  public Brush() {
    bInd = 0;
    numOfBrushes = 0;

    if (BRUSH_DIAG < NUM_BRUSHES) {
      btArr[BRUSH_DIAG] = new diagBrush();
      numOfBrushes++;
    }
    if (BRUSH_LINE < NUM_BRUSHES) {
      btArr[BRUSH_LINE] = new lineBrush();
      numOfBrushes++;
    }
    if (BRUSH_POINT < NUM_BRUSHES) {
      btArr[BRUSH_POINT] = new pointBrush();
      numOfBrushes++;
    }
    if (BRUSH_CROSS < NUM_BRUSHES) {
      btArr[BRUSH_CROSS] = new crossBrush();
      numOfBrushes++;
    }
    if (BRUSH_VERT < NUM_BRUSHES) {
      btArr[BRUSH_VERT] = new vertBrush();
      numOfBrushes++;
    }
    if (BRUSH_SPRAY < NUM_BRUSHES) {
      btArr[BRUSH_SPRAY] = new sprayBrush();
      numOfBrushes++;
    }
    if (BRUSH_SOLID < NUM_BRUSHES) {
      btArr[BRUSH_SOLID] = new solidBrush();
      numOfBrushes++;
    }

    bSize = 0.5;
    bColor = color(255);
    bt = btArr[bInd];
  }

  private int getNumOfBrushes() {
    return numOfBrushes;
  }

  private void draw(int x, int y, int lx, int ly, PGraphics pg) {
    bt.drawHere(x, y, lx, ly, pg, bSize, bColor);
  }

  private void setSize(float f) {
    bSize = f;
  }
  private void setColor(color c) {
    bColor = c;
  }
  private void setType(int i) {
    bInd = i%btArr.length;
    bt = btArr[bInd];
  }
}

