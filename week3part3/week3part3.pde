import oscP5.*;
import netP5.*;

Enemy[] enemy= new Enemy[10];
OscP5 oscP5;
NetAddress dest;
PFont f;

//Adam's input
float x;
float y;
int rad = 20;
int gameState = 0;

//Rebecca's box
boolean overBox = false;
boolean locked = false;

void setup() {
  f = createFont("Courier", 15);
  textFont(f);

  size(640, 480, P2D);
  smooth();

  x = width/2.0;
  y = height/2.0;
  ellipseMode(RADIUS);  

  for (int i=0; i< 10; i++) {
    enemy[i] = new Enemy(20);
  }

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 9000);
  dest = new NetAddress("127.0.0.1", 6448);
}

void draw() {
  background(0);
  if (gameState == 0) {
    menu();
  }
  if (gameState == 1) {
    gameStart();
  }

  //Send the OSC message with box current position
  sendOsc();
}

void mousePressed() {
  if (overBox) { 
    locked = true; 
    fill(0, 255, 0);
  } else {
    locked = false;
  }
}

void mouseDragged() {
  if (locked) {
    x = mouseX;
    y = mouseY;
  }
}

void mouseReleased() {
  locked = false;
}

void keyPressed() {
  if (gameState == 0)
    if (key == 's' || key == 'S') {
      gameState = 1;
    }
}

void menu() {
  fill(255);

  text("Continuously sends box x and y position (2 inputs) to Wekinator\nUsing message /wek/inputs, to port 6448", 10, 30);
  text("x=" + x + ", y=" + y, 10, 80);

  player();
}

void gameStart() {
  player();
  enemies();
}

void player() {
  fill(0, 200, 0);

  // Test if the cursor is over the box 
  if (mouseX > x-rad && mouseX < x+rad && 
    mouseY > y-rad && mouseY < y+rad) {
    overBox = true;  
    if (!locked) { 
      stroke(0, 255, 0); 
      fill(0, 255, 0);
    }
  } else {
    stroke(0, 255, 0);
    fill(0, 255, 0);
    overBox = false;
  }
  // Draw the box
  ellipse(x, y, rad, rad);
}

void enemies() {
  for (int i=0; i< 10; i++) {
    enemy[i].run();
  }
}


void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add((float)x); 
  msg.add((float)y);
  oscP5.send(msg, dest);
}