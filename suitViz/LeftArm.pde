
// a few methods specific to left arm

class LeftArm extends Arm {
  
  LeftArm(int x, int y, float angle1, float angle2) {
    super(x,y,angle1,angle2);
  }
  
  void setLED(int i, color c, int a) {
    int val = numArmLEDs-1 - i;
    if(val >=0 && val < LEDs.length) LEDs[val].setLED(c,a);
  }
  
  void drawArmImage() {
    // bicep
    pushMatrix();
    translate(xShoulder, yShoulder);
    rotate(radians(angleShoulder));
    tint(130,130,130);
    image(biImg,0,0);
    popMatrix();
    
    // forearm
    pushMatrix();
    float xElbow = xShoulder - sin(radians(angleShoulder))*95;
    float yElbow = yShoulder + cos(radians(angleShoulder))*95;
    translate(xElbow, yElbow);
    rotate(radians(angleElbow));
    tint(130,130,130);
    image(foreImg, 0, 0);
    popMatrix();
  }
  
  void setLEDPositions() {
    int spacing = 10;
    int biLength = spacing*numBicepLEDs;
    
    // set LED positions on Bicep
    int start = numArmLEDs -1;
    int end = start - numBicepLEDs;
    int j = 0;
    for(int i = start; i > end; i--) {
      LEDs[i].setPosition(xShoulder - sin(radians(angleShoulder))*(spacing*j), 
          yShoulder + cos(radians(angleShoulder))*(spacing*j));
      j++;
    }
    
    // set LED positions on Forearm
    float xElbow = xShoulder - sin(radians(angleShoulder))*biLength;
    float yElbow = yShoulder + cos(radians(angleShoulder))*biLength;
    float angleE = angleElbow;
    angleE-=5;
    start = end;
    end = 0;
    j = 0;
    for(int i = start; i >= end; i--) {
      LEDs[i].setPosition(xElbow - sin(radians(angleE))*(spacing*j), 
          yElbow + cos(radians(angleE))*(spacing*j));
      j++;
    }
  }
  
  void setArmImagePositions(int x, int y, float angle1, float angle2) {
    xShoulder = x;
    yShoulder = y;
    
    angleShoulder = angle1;
    if(angleShoulder > maxAngle) angleShoulder = maxAngle;
    else if(angleShoulder < minAngle) angleShoulder = minAngle;
    
    angleElbow = angle2;
    if(angleElbow > angleShoulder) angleElbow = angleShoulder;
    else if(angleElbow < angleShoulder - 160) angleElbow = angleShoulder - 160;
    if(angleElbow < minAngle) angleElbow = minAngle;
    else if(angleElbow > maxAngle) angleElbow = maxAngle;
  }
}