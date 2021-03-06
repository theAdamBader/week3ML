/*
REFERENCE:
Rebecca's Simple_Mouse_DraggedObject_2Inputs
Adapated from https://processing.org/examples/mousefunctions.html by Rebecca Fiebrink
*/

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;
Background bckgrnd;
Enemy[] enemy= new Enemy[10];//(Adam) array of enemies

//Adam's input
float xPos;
float yPos;
int rad = 20;
int gameState = 0;
int score= 0;//using a score system starting at 0 and a highscore to keep track of your highscore
int highScore= 0;

//Rebecca's inputs
boolean overBox = false;
boolean locked = false;

void setup() {
  size(640, 480, P2D);
  smooth();

  //Rebecca's input
  xPos = width/2.0;
  yPos = height/2.0;
  ellipseMode(RADIUS);  

  for (int i=0; i< 10; i++) {
    enemy[i] = new Enemy(20);//creating enemies with a radius size 20
  }
  
  bckgrnd = new Background();

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 9000);
  dest = new NetAddress("127.0.0.1", 6448);
}

void draw() {
  background(0);
    
  if (gameState == 0) {//gameState 0
    menu();
    score = 0;
  }
  if (gameState == 1) {//Starts the game
     bckgrnd.display();
     gameStart();
  }
  
  //Send the OSC message with box current position
  sendOsc();
}

void mousePressed() {//Rebecca's inputs
  if (overBox) { 
    locked = true; 
    fill(0, 255, 0);
  } else {
    locked = false;
  }
}

void mouseDragged() {//Rebecca's inputs
  if (locked) {
    xPos = mouseX;
    yPos = mouseY;
  }
}

void mouseReleased() {//Rebecca's inputs
  locked = false;
}

void keyPressed() {//Adam's inputs
  if (gameState == 0)
    if (key == 's' || key == 'S') {//Press S to start game
      gameState = 1;
    }
}

void menu() {//Adam (menu function)
  fill(255);

  text("Continuously sends box x and y position (2 inputs) to Wekinator\nUsing message /wek/inputs, to port 6448", 10, 30);
  text("Ensure to have 3 outputs before you start the game\nx=" + xPos + ", y=" + yPos, 10, 80);
  text("Highscore: "+highScore, 20, 200);//this tracks your highscore for whenever you go back to your main menu

  player();
}

void gameStart() {//Adam (game start function)
  player();
  enemies();

  if (gameState == 1) {
    score++;//when the game is playing it tracks your score for how far you have reached
    highScore= max (score, highScore);//adds the max value of that score into your highscore
  }
  fill(255);
  textSize(12);
  text("Score: " + score, 30, 30);
}

void player() {//Adam (player function)
  fill(0, 200, 255);

  // Test if the cursor is over the player 
  if (mouseX > xPos-rad && mouseX < xPos+rad && 
    mouseY > yPos-rad && mouseY < yPos+rad) {
    overBox = true;  //if true then drag
    if (!locked) { //if not locked the colour is 0, 200, 255
      fill(0, 255, 255);
    }
  }
  else {
    fill(0, 255, 255);
    overBox = false;
  }
  // Draw the ellipse
  ellipse(xPos, yPos, rad, rad);
}

void enemies() {//Adam (enemy function)
  for (int i=0; i< 10; i++) {
    enemy[i].run();
  }
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add((float)xPos); 
  msg.add((float)yPos);
  oscP5.send(msg, dest);
}