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

int ballX = 70;
int ballY = 870;
boolean ballTester = false;
PImage below;
PImage ontop;
PImage verytop;

void setup(){
  size(1414,1000);
below = loadImage("below1.png");
ontop = loadImage("ontop.png");
verytop = loadImage("verytop.png");
}

void draw(){
   
   //shape of the path
image(below, 0,0);

//if the below is white then it resets the thing
if(ballTester==true){
if (get(mouseX,mouseY) == color(255,255,255)){
  println("BAD!");
  ballTester = false;
}
//Zones
//put all the zone related codes within the specific area.
if (get(mouseX,mouseY) == color(100,0,0)){
println("User is in start area");
}
if (get(mouseX,mouseY) == color(150,0,0)){
  println("User is in area #1");
}
if (get(mouseX,mouseY) == color(0,150,0)){
  println("User is in area #2");
}
if (get(mouseX,mouseY) == color(0,0,150)){
  println("User is in area #3");
}
if (get(mouseX,mouseY) == color(0,150,150)){
println("User is in area #4");
}
if (get(mouseX,mouseY) == color(150,150,0)){
  println("User is in area #5");
}
if (get(mouseX,mouseY) == color(150,0,150)){
  println("User is in area #6");
}
if (get(mouseX,mouseY) == color(150,150,150)){
  println("User is in area #7");
}
if (get(mouseX,mouseY) == color(0,0,100)){
  println("User is in the end area");
}
}
//Draws the avatar over the place 
if (ballTester == true){
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
  ballTester = true;
}
}
void mouseReleased(){
ballTester=false;
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
  //START(100,0,0)
 //first zone(150,0,0)
 //2ND(0,150,0)
 //3RD(0,0,150)
 //4TH(0,150,150)
 //5TH(150,150,0)
 //6TH(150,0,150)
 //7TH(150,150,150)
 //END(0,0,100)