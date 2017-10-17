class Background {

  PImage bg;//calling an image, background
  int xBackground= -100;

  Background() {
    bg= loadImage("darkforest.jpg");
  }

  void display() //background functions
  {
    image (bg, xBackground, 0);//calling two images, one to start with xBackground= -100 and the other adds the background image where x=0 
    image (bg, xBackground+bg.width, 0);
    xBackground -= 5; //this looks as if the image is moving by 4px every frame
    if (xBackground < -bg.width) //using if statement to call the image back when its met the condition giving the illusions that the image is looping
    {
      xBackground = 0;
    }
  }
}