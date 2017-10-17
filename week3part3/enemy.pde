class Enemy{

  float x; 
  float y;
  float rad;
  float xSpeed;
  
  Enemy(float temp) {  //creating an object
    x = random(700, 1500);
    y = random(height);
    rad = temp;
    xSpeed = random(1.0, 2.0);
  }
  
  void run(){
  display();
  move();
  reset();
  }
  
  void display() {  //creating the snow
    //float colourValue = (int) random(150, 255);
    //stroke(colourValue);
    fill(255);
    ellipse(x, y, rad, rad);
  }
  
    void move() {  //speed for the snow falling
    x -= xSpeed;
    y = y + random (-2, 2);
  }
  
  void reset() {  //looping the arrays using an if statement
    if (x < -200) {
      x = width + 300;
    }
  }
}