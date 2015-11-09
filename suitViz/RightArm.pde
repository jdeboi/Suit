
// a few methods specific to right arm

class RightArm extends Arm {

  RightArm(int x, int y, float angle1, float angle2) {
    super(x, y, angle1, angle2);
  }

  void drawArmImage() {
    // bicep
    pushMatrix();
    translate(xShoulder, yShoulder);
    rotate(radians(angleShoulder));
    scale(-1.0, 1.0);
    tint(130, 130, 130);
    image(biImg, -biImg.width+25, 0);
    popMatrix();

    // forearm
    pushMatrix();
    float xElbow = xShoulder - sin(radians(angleShoulder))*95;
    float yElbow = yShoulder + cos(radians(angleShoulder))*95;
    translate(xElbow, yElbow);
    rotate(radians(angleElbow));
    scale(-1.0, 1.0);
    tint(130, 130, 130);
    image(foreImg, -foreImg.width+37, 0);
    popMatrix();
  }

  void setArmImagePositions(int x, int y, float angle1, float angle2) {
    xShoulder = x;
    yShoulder = y;

    angleShoulder = angle1;
    if (angleShoulder > maxAngle) angleShoulder = maxAngle;
    else if (angleShoulder < minAngle) angleShoulder = minAngle;

    angleElbow = angle2;
    if (angleElbow < angleShoulder) angleElbow = angleShoulder;
    if (angleElbow > angleShoulder + 160) angleElbow = angleShoulder + 160;
    if (angleElbow < minAngle) angleElbow = minAngle;
    else if (angleElbow > maxAngle) angleElbow = maxAngle;
  }

  void setLEDPositions() {
    int spacing = 10;
    int biLength = spacing*numBicepLEDs;

    // set LED positions on Bicep
    int start = numArmLEDs -1;
    int end = start - numBicepLEDs;
    int j = 0;
    for (int i = start; i > end; i--) {
      LEDs[i].setPosition(xShoulder + sin(radians(-angleShoulder))*(spacing*j), 
        yShoulder + cos(radians(-angleShoulder))*(spacing*j));
      j++;
    }

    // set LED positions on Forearm
    float xElbow = xShoulder + sin(radians(-angleShoulder))*biLength;
    float yElbow = yShoulder + cos(radians(-angleShoulder))*biLength;
    float angleE = angleElbow;
    angleE+=5;
    start = end;
    end = 0;
    j = 0;
    for (int i = start; i >= end; i--) {
      LEDs[i].setPosition(xElbow + sin(radians(-angleE))*(spacing*j), 
        yElbow + cos(radians(-angleE))*(spacing*j));
      j++;
    }
  }
}