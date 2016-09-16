/*
###########################################
P0 project - Map game

Revision: 6
Date: 16/09/2016
By: Niklas/Lars


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
PImage below;
PImage ontop;
PImage verytop;

void setup(){
  size(1414,1000);
below = loadImage("below.png");
ontop = loadImage("ontop.png");
verytop = loadImage("verytop.png");
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
strokeWeight(5);
noFill();
stroke(255,0,0);
ellipse(ballX,ballY,20,20);
 
 //Layer that's ontop of everything that the ball travels behind
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