
// a sub class for the arms

class Arm extends Segment {

  int numArmLEDs = 20;
  int numBicepLEDs = 8;
  int biLength = 30;
  int xShoulder, yShoulder, minAngle, maxAngle;
  float angleShoulder, angleElbow;
  PImage biImg, foreImg;

  Arm(int x, int y, float angle1, float angle2) {
    //numArmLEDs = 20;
    super(20);
    minAngle = -220;
    maxAngle = 220;
    setPosition(x, y, angle1, angle2);
    biImg = loadImage("images/arm0.png");
    foreImg = loadImage("images/arm1.png");
  }

  void display() {
    drawArmImage();
    drawLEDs();
  }

  void drawArmImage() {
  }

  void setPosition(int x, int y, float angle1, float angle2) {    
    setArmImagePositions(x, y, angle1, angle2);
    setLEDPositions();
  }

  void setArmImagePositions(int x, int y, float angle1, float angle2) {
  }

  void setPosition(float angle1, float angle2) {
    setPosition(xShoulder, yShoulder, angle1, angle2);
  }

  void incArm(float amtSh, float amtElb) {
    setPosition(xShoulder, yShoulder, angleShoulder+amtSh, angleElbow+amtElb);
  }

  void moveToSmoothly(int angle, int speed) {
  }

  void setAngleMinMax(int min, int max) {
    minAngle = min;
    maxAngle = max;
  }

  float getZGravity() {
    return -cos(radians(angleElbow));
  }
}