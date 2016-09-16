/*
###########################################
P0 project - Map game

Revision: 7
Date: 16/09/2016
By: group 13


Rules for good coding
1) Make sure to regularily comment your code
2) Before you edit any section, make sure to talk to Lars and/or whoever is near you first.
3) Whenever you commit, update the revision number (just add one), date and name
4) Please compile and test your code at least once, before committing it.

Revision 4 notes

Squiggletest 2 now in effect
###########################################
*/

//Below we initialize the variables and classes for the media.

int ballX = 80;
int ballY = 850;
int ballTester = 0;
int direction = 1;

PImage below;
PImage ontop;
PImage verytop;
PImage front;
PImage back;
PImage tLeft;
PImage tRight;

void setup(){
  size(1414,1000);
below = loadImage("below.png");
ontop = loadImage("ontop.png");
verytop = loadImage("verytop.png");
front = loadImage("front.png");
back = loadImage("back.png");
tLeft = loadImage("left.png");
tRight = loadImage("right.png");
}

void draw(){
   
   //shape of the path
image(below, 0,0);

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
   
if (direction == 1){
    image(front, ballX-10, ballY-20, 20,30);
}
if (direction == 2){
  image(tRight, ballX-10, ballY-20, 20,30);
}

if(direction==3){
  image(back,ballX-10, ballY-20, 20,30);
}

if(direction==4){
  image(tLeft, ballX-10, ballY-20, 20,30);
}
  if (mouseY < pmouseY && ballX == mouseX && ballY == mouseY){
  direction=3;
}
if (mouseY > pmouseY && ballX == mouseX && ballY == mouseY){
direction=1;
}
if (mouseX < pmouseX && ballX == mouseX && ballY == mouseY){
  direction=4;
}
if (mouseX > pmouseX && ballX == mouseX && ballY == mouseY){
  direction=2;
}
  //image on TOPTOP - do this LAST
  
  image(verytop,0,0);
}

//This checks if the mouse is dragging the ball. When mouse is released balltester is zeroed.

void mouseDragged(){
if (mouseX > ballX-10 & mouseX < ballX+10 & mouseY < ballY+10 & mouseY > ballY-10){
  ballTester = 1;
}
}
void mouseReleased(){
ballTester=0;
}


  //DESIRED FUNCTIONALITY
  
    //obstacles(depends on the time)
  //draw obstacles
  //animate obstacles
  
  
    //collision()
  //constantly check for location for obsctacles and progress
  //code for respawning when you fail
  
   
   //progress()
 //check if the player has gone far enough to trigger more info or end of game 
 //if he has, draw info or similiar stuff