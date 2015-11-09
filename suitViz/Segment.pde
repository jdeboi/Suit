
// a super class that can be used for arms
// or legs (TODO)

class Segment {
  LED [] LEDs;

  Segment(int n) {
    LEDs = new LED[n];
    loadLEDs();
    setColor(color(255, 255, 255), 60);
  }

  void display() {}
  
  void drawLEDs() { 
    for (int i = 0; i < LEDs.length; i++) {
      LEDs[i].drawLED();
    }
  }

  void setColor(color c, int a) {
    for (int i = 0; i < LEDs.length; i++) {
      LEDs[i].setLED(c, a);
    }
  }
  
  void resetLEDs() {
    setColor(color(255,255,255), 60);
  }

  int getNumLEDs() {
    return LEDs.length;
  }
  
  void setLED(int i, color c, int a) {
    if(i >=0 && i < LEDs.length) LEDs[i].setLED(c,a);
  }

  void loadLEDs() {
    for (int i = 0; i < LEDs.length; i++) {
      LEDs[i] = new LED(0, 0);
    }
    setLEDPositions();
  }
  
  void setPosition(int x, int y, float angle1, float angle2) { }
  void setPosition(float angle1, float angle2) {} 

  void setLEDPositions() {
  }
  
  float getXGravity(){
    return 0;
  }
  float getYGravity(){
    return 0;
  }
  float getZGravity(){
    return 0;
  }
}