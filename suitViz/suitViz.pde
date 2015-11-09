
// A visualization of the Neopixel Suit
// add light/motion methods to the suit class

int angle = 0;
int inc = 1;

int moveMode = 0;
boolean windMill = false;

Suit suit;

void setup() {
  size(700, 700);
  suit = new Suit();
}


void draw() {
  background(0);
  suit.manualSeesaw();
  
  switch(getMode()) {
  case 0:
    suit.blinkLEDs(color(255, 0, 255), 100); 
    break;
  case 1:
    suit.setAllLEDs(color(255, 0, 255), 200);
    break;
  case 2: 
    suit.rainbowGravity(10);
    break;
  case 3: 
    suit.rainbowCycle();
    break;
  case 4: 
    suit.rainbow();
    break;
  case 5:
    suit.theaterChase(suit.Wheel(10),30);
    break;
  case 6:
    suit.colorWipe(suit.Wheel(150), 20);
    break;
  }
  suit.display();
}

int getMode() {
  //return millis()/1000%6;
  return 2;
}

void keyTyped() {
  if(key == 'a') moveMode = 1;
  else if (key == 's') moveMode = 2;
  else if (key == 'd') moveMode = 3;
  else if (key == 'f') moveMode = 4;
}
 
void keyReleased() {
  moveMode = 0;
}