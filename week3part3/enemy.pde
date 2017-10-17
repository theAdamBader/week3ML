//Adam's Class

class Enemy{

  float x; 
  float y;
  float rad;
  float xSpeed;
  
  Enemy(float temp) {  //creating an object
    x = random(700, 1500);//random range between 700 to 1500
    y = random(height);
    rad = temp;
    xSpeed = random(1.0, 3.0);//random speed between 1 - 3
  }
  
  void run(){//runs all function
  display();
  update();
  reset();
  }
  
  void display() {  //creating the enemy
    //float colourValue = (int) random(150, 255);
    //stroke(colourValue);
    noStroke();
    fill(255, 100, 0);
    ellipse(x, y, rad, rad);
  }
  
    void update() {  //speed for the snow faslling
    x -= xSpeed;
    y = y + random (-2, 2);
    
    if (dist(x, y, mouseX, mouseY)<=25) {//calls the distance between two points the x and y axis
      gameState = 0;//when there is less or equal than 25 px between the player and enemy then game state 2 activates
    }
  }
  
  void reset() {  //looping the arrays using an if statement
    if (x < -200) {
      x = width + 300;
      y = random (height);
    }
  }
}