int ballX = 80;
int ballY = 850;
int ballTester = 0;
PImage below;
PImage ontop;

void setup(){
  size(1414,1000);
below = loadImage("below.png");
ontop = loadImage("ontop.png");
}

void draw(){
   
   //shape of the path
image(below, 0,0);


//This checks if the mouse is over the ball - this should be in a mouse dragged void so that balltester is only enabled when it is dragged
if (mouseX > ballX-10 & mouseX < ballX+10 & mouseY < ballY+10 & mouseY > ballY-10){
  ballTester = 1;
}



//checks if the "below" is black
if (get(mouseX,mouseY) != color(0,0,0)){
  println("BAD!");
  ballTester = 0;
}

//Draws the avatar over the place 
if (ballTester == 1){
  ballX=mouseX;
  ballY=mouseY;
}
   //image on top
   image(ontop,0,0);
   
   
   //avatar is drawn with the 
strokeWeight(5);
noFill();
stroke(255,0,0);
ellipse(ballX,ballY,20,20);
  
}