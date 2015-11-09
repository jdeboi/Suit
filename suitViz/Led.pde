
// Class to keep track of the
// state of each LED

class LED {
  int x,y,r,g,b,bright;
  PImage img;
  boolean state;
  
  LED(int x, int y) {
    img = loadImage("images/ledglow.png");
    img.resize(7,0);
    this.x = x;
    this.y = y;
    r = 255;
    g = 255;
    b = 255;
    bright = 200;
  }
  
  void drawLED() {
    tint(r, g, b, bright);
    image(img,x,y);
  }
  
  void setLED(int r, int g, int b, int a) {
    this.r = r;
    this.g = g;
    this.b = b;
    bright = int(a*.9);
  }
  void setLED(color c, int a) {
    r = int(red(c));
    g = int(green(c));
    b = int(blue(c));
    bright = int(a*.8);
  }
  
  void setPosition(float x, float y) {
    this.x = int(x);
    this.y = int(y);
  }
}