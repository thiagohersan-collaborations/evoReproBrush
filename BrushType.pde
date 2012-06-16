class diagBrush extends BrushType {
  public void drawHere(int x, int y, int lx, int ly, PGraphics pg, float s, color c) {
    pg.noFill();
    pg.stroke(c, COLOR_BRUSH_ALPHA);
    int r = (int)map(s, 0, 1, 5, 20);
    int t = (int)map(s, 0, 1, 1, 3);
    pg.strokeWeight(t);
    pg.line(x-r, y-r, x+r, y+r);
  }
}

class lineBrush extends BrushType {
  public void drawHere(int x, int y, int lx, int ly, PGraphics pg, float s, color c) {
    pg.noFill();
    pg.stroke(c, COLOR_BRUSH_ALPHA);
    int r = (int)map(s, 0, 1, 5, 20);
    int t = (int)map(s, 0, 1, 10, 30);
    pg.strokeWeight(t);
    pg.strokeCap(SQUARE);
    pg.line(lx, ly, x, y);
  }
}


class vertBrush extends BrushType {
  public void drawHere(int x, int y, int lx, int ly, PGraphics pg, float s, color c) {
    pg.noFill();
    pg.stroke(c, COLOR_BRUSH_ALPHA);
    int r = (int)map(s, 0, 1, 5, 20);
    int t = (int)map(s, 0, 1, 1, 3);
    pg.strokeWeight(t);
    pg.line(x, y-r, x, y+r);
  }
}


class crossBrush extends BrushType {
  crossBrush() {
    periodUpdate = 60;
    nextUpdate = millis() + periodUpdate;
  }

  public void drawHere(int x, int y, int lx, int ly, PGraphics pg, float s, color c) {
    if (millis() > nextUpdate) {
      drawHereH(x, y, lx, ly, pg, s, c);
      nextUpdate = millis()+periodUpdate;
    }
  }

  // actual function that actually draws
  public void drawHereH(int x, int y, int lx, int ly, PGraphics pg, float s, color c) {
    // draw code goes here....
    color cj;
    int cjvar = 30;

    pg.noFill();

    if (c == #000000) {
      cj = color(random(cjvar*3));
    }
    else if (c == #FFFFFF) {
      cj = 255 - (int)random(cjvar);
    }
    else {
      colorMode(HSB);
      cj = color(constrain(hue(c)+random(-cjvar, cjvar), 0, 255), saturation(c), brightness(c));
      colorMode(RGB);
    }
    pg.stroke(cj, COLOR_BRUSH_ALPHA);

    // randomness for radius, size, and strokeWeight
    int rr = (int)map(s, 0, 1, 10, 40)+(int)random(10);
    int rs = (int)map(s, 0, 1, 3, 8)+(int)random(5);
    int rt = (int)map(s, 0, 1, 3, 7)+(int)random(1);

    pg.strokeCap(SQUARE);
    pg.strokeWeight(rt);

    int xx = int(x+random(-rr, rr));
    int yy = int(y+random(-rr, rr));

    // rotates around 0,0, so put drawing location there, then rotate
    pg.pushMatrix();
    pg.translate(xx, yy);
    pg.rotate(random(0, 3));

    pg.line(-rs, -rs, rs,  rs);
    pg.line(-rs,  rs, rs, -rs);

    pg.popMatrix();
  }
}


class sprayBrush extends BrushType {
  sprayBrush() {
    periodUpdate = 0;
    nextUpdate = millis() + periodUpdate;
  }

  public void drawHere(int x, int y, int lx, int ly, PGraphics pg, float s, color c) {
    if (millis() > nextUpdate) {
      drawHereH(x, y, lx, ly, pg, s, c);
      nextUpdate = millis()+periodUpdate;
    }
  }

  // draws lots of circles on top of each other
  //   and interpolate posiions
  private void drawHereH(int x, int y, int lx, int ly, PGraphics pg, float s, color c) {
    // draw code goes here....
    pg.noStroke();
    pg.fill(c, COLOR_BRUSH_ALPHA/8);

    //  set up biggest circle radius, step granularity and smallest circle radius
    int rs = (int)map(s, 0, 1, 15, 30);
    int rr = (int)map(s, 0, 1, 4, 6);
    int rt = (int)map(s, 0, 1, 3, 6);

    // if mouse moved...
    if ((abs(x-lx)>1)||(abs(y-ly)>1)) {
      // number of steps depends on size of brush
      int nSteps = (int)max(abs(x-lx), abs(y-ly));
      nSteps /= rr;

      // always draw something... 
      // this takes care of the case when nSteps was originally < rr
      if (nSteps < 1) {
        nSteps = 1;
      }

      // interpolate
      for (int ii=0;ii<nSteps;ii++) {
        float pc = float(ii)/float(nSteps);
        float xx = lerp(lx, x, pc);
        float yy = lerp(ly, y, pc);

        // draw many alpha circles...
        while (rs > rt) {
          pg.ellipse(xx, yy, rs, rs);
          rs -= rt;
        }
        rs = (int)map(s, 0, 1, 15, 30);
      }
    }
  }
}

class pointBrush extends BrushType {
  pointBrush() {
    periodUpdate = 60;
    nextUpdate = millis() + periodUpdate;
  }

  public void drawHere(int x, int y, int lx, int ly, PGraphics pg, float s, color c) {
    if (millis() > nextUpdate) {
      drawHereH(x, y, lx, ly, pg, s, c);
      nextUpdate = millis()+periodUpdate;
    }
  }

  private void drawHereH(int x, int y, int lx, int ly, PGraphics pg, float s, color c) {
    // draw code goes here....
    pg.stroke(0, COLOR_BRUSH_ALPHA);
    pg.noStroke();
    pg.fill(c, COLOR_BRUSH_ALPHA);

    // randomness for radius, size, and strokeWeight
    int rr = (int)map(s, 0, 1, 10, 30)+(int)random(10);
    int rs = (int)map(s, 0, 1, 5, 15)+(int)random(5);
    int rt = (int)map(s, 0, 1, 2, 5)+(int)random(1);

    pg.strokeWeight(rt);

    int xx = x+(int)random(-rr, rr);
    int yy = y+(int)random(-rr, rr);

    pg.ellipse(xx, yy, rs, rs);
  }
}

/////
class solidBrush extends BrushType {
  solidBrush() {
    periodUpdate = 0;
    nextUpdate = millis() + periodUpdate;
  }

  public void drawHere(int x, int y, int lx, int ly, PGraphics pg, float s, color c) {
    if (millis() > nextUpdate) {
      drawHereH(x, y, lx, ly, pg, s, c);
      nextUpdate = millis()+periodUpdate;
    }
  }

  private void drawHereH(int x, int y, int lx, int ly, PGraphics pg, float s, color c) {
    // draw code goes here....
    pg.noStroke();
    pg.fill(c, COLOR_BRUSH_ALPHA/5);

    // figure out line width...
    int rr = (int)map(s, 0, 1, 8, 20);

    // interpolation code
    int nSteps = (int)max(abs(x-lx), abs(y-ly));

    // always draw something... 
    // this takes care of the case when nSteps was originally < rr
    if (nSteps < 1) {
      nSteps = 0;
    }

    // interpolate
    for (int ii=0;ii<nSteps;ii++) {
      float pc = float(ii)/float(nSteps);
      float xx = lerp(lx, x, pc);
      float yy = lerp(ly, y, pc);

      // draw circle...
      pg.ellipse(xx, yy, rr, rr);
    }
  }
}

/////


abstract class BrushType {
  protected int nextUpdate;
  protected int periodUpdate;

  BrushType() {
    periodUpdate = 50;
    nextUpdate = millis() + periodUpdate;
  }

  abstract public void drawHere(int x, int y, int lx, int ly, PGraphics pg, float s, color c);
}

