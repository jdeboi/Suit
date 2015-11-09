
// The most important class
// contains Neopixel visualizations
// and controls for moving body

class Suit {

  long lastTime = 0;
  PImage suitImg;
  ArrayList <Segment> suit;
  int numLEDs;
  int rIndex = 0;
  boolean blinkOn = false;
  boolean seesawOn = false;

  Suit() {
    suitImg = loadImage("images/torso.png");
    suitImg.resize(700, 0);
    loadSuit();
  }

  void display() {
    tint(130, 130, 130);
    image(suitImg, 0, 0);
    for (int i = 0; i < suit.size(); i++) {
      suit.get(i).display();
    }
  }

  void loadSuit() {
    suit = new ArrayList<Segment>();
    suit.add(new RightArm(420, 140, -140, -140));
    suit.add(new LeftArm(275, 140, 90, 90));
    for (int i = 0; i < suit.size(); i++) {
      numLEDs+=suit.get(i).getNumLEDs();
    }
  }

  void setLED(int i, color c, int alpha) {
    int num0 = suit.get(0).getNumLEDs();
    int num1 = suit.get(1).getNumLEDs();
    if (i < num0) suit.get(0).setLED(i, c, alpha);
    else if (i < num0+num1) suit.get(1).setLED(i-num0, c, alpha);
  }

  void resetLEDs() {
    for (int i = 0; i < suit.size(); i++) {
      suit.get(i).resetLEDs();
    }
  }

  void rainbowGravity(int delayTime) {
    if (timerUp(delayTime)) {
      setTimer();
      resetLEDs();

      if (suit.get(0).getZGravity() > .1) {
        if (rIndex < numLEDs -6) rIndex++;
      } else if (suit.get(0).getZGravity() < -.1 && rIndex > 0) rIndex--;
      setLED(rIndex, Wheel(240), 255);
      setLED(rIndex+1, Wheel(200), 255);
      setLED(rIndex+2, Wheel(150), 255);
      setLED(rIndex+3, Wheel(100), 255);
      setLED(rIndex+4, Wheel(50), 255);
      setLED(rIndex+5, Wheel(0), 255);
    }
  }

  void setTimer() {
    lastTime = millis();
  }

  boolean timerUp(int timerTime) {
    if ( millis() - lastTime > timerTime) {
      return true;
    }
    return false;
  }

  void blinkLEDs(color c, int delayTime) {
    if (timerUp(delayTime)) {
      setTimer();
      blinkOn = !blinkOn;
    }
    if (blinkOn) setAllLEDs(c, 255);
    else resetLEDs();
  }

  void setAllLEDs(color c, int a) {
    for (int i = 0; i < suit.size(); i++) {
      suit.get(i).setColor(c, a);
    }
  }

  void colorWipe(color c, int delayTime) {
    setLED(0, c, 255);
    if (timerUp(delayTime)) {
      setTimer();
      rIndex++;
      if (rIndex >= numLEDs) rIndex = 0;
      setLED(rIndex, c, 255);
    }
  }

  void fadeIn(color c, int delayTime) {
    if (timerUp(delayTime)) {
      setTimer();
      rIndex++;
      // TODO work this out; should fade in from gray
      if (rIndex >= 256 || rIndex < 0) rIndex = 0;
      setAllLEDs(c, rIndex);
    }
  }

  void fadeOut(color c, int delayTime) {
    if (timerUp(delayTime)) {
      setTimer();
      rIndex--;
      // TODO work this out; should fade to gray
      if (rIndex >= 256) rIndex = 255;
      else if (rIndex < 60) rIndex = 60;
      setAllLEDs(c, rIndex);
    }
  }

  void theaterChase(color c, int delayTime) {
    if (timerUp(delayTime)) {
      rIndex++;
      if (rIndex >= 3)rIndex = 0;
      setTimer();
      blinkOn = !blinkOn;
    }
    if (blinkOn) theaterChaseOn(c);
    else theaterChaseOff(c);
  }

  //Theatre-style crawling lights.
  void theaterChaseOn(color c) {
    for (int i=0; i < numLEDs; i=i+3) {
      setLED(i+rIndex, c, 255);    //turn every third pixel on
    }
    display();
  }

  //Theatre-style crawling lights.
  void theaterChaseOff(color c) {
    for (int i=0; i < numLEDs; i=i+3) {
      setLED(i+rIndex, c, 0);    //turn every third pixel on
    }
    display();
  }

  // Slightly different, this makes the rainbow equally distributed throughout
  void rainbowCycle() {
    rIndex++;
    if (rIndex >= 256*5) rIndex = 0;
    for (int i=0; i< numLEDs; i++) {
      setLED(i, Wheel(((i * 256 / numLEDs) + rIndex) & 255), 255);
    }
  }

  void rainbow() {
    rIndex++;
    if (rIndex >= 256) rIndex = 0;
    for (int i=0; i< numLEDs; i++) {
      setLED(i, Wheel((i+rIndex) & 255), 255);
    }
  }

  color Wheel(int WheelPos) {
    WheelPos = 255 - WheelPos;
    if (WheelPos < 85) {
      return color(255 - WheelPos * 3, 0, WheelPos * 3);
    } else if (WheelPos < 170) {
      WheelPos -= 85;
      return color(0, WheelPos * 3, 255 - WheelPos * 3);
    } else {
      WheelPos -= 170;
      return color(WheelPos * 3, 255 - WheelPos * 3, 0);
    }
  }


  void manualSeesaw() {
    if(!seesawOn) {
      seesawOn = true;
      ((LeftArm)suit.get(1)).setPosition(90, 90);
      ((LeftArm)suit.get(1)).setAngleMinMax(0, 180);
      ((RightArm)suit.get(0)).setPosition(-90, -90);
      ((RightArm)suit.get(0)).setAngleMinMax(-180, 0);
    }
    if (mouseY > 700/2) {
      float incAmount = (mouseY-350)/350.0*10;
      ((LeftArm)suit.get(1)).incArm(incAmount, incAmount);
      ((RightArm)suit.get(0)).incArm(incAmount, incAmount);
    } 
    else {
      // at 350 0
      // at 0 1
      float incAmount = (350-mouseY)/350.0*10;
      ((LeftArm)suit.get(1)).incArm(-incAmount, -incAmount);
      ((RightArm)suit.get(0)).incArm(-incAmount, -incAmount);
    }
  }
  
  // TODO - finish
  void armFlap() {
    angle+=inc*2;
    if (angle > 130) inc = -1;
    else if (angle < 20) inc = 1;
    suit.get(0).setPosition(-angle, -angle);
    suit.get(1).setPosition(angle, angle);
  }
}