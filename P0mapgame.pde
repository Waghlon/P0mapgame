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
PImage areaTextStart;
PImage areaText1;
PImage areaText2;
PImage areaText3;
PImage areaText4;
PImage areaText5;
PImage areaText6;
PImage areaText7;
PImage areaTextEnd;
int zone=0;

void setup(){
  size(1414,1000);
below = loadImage("below1.png");
ontop = loadImage("ontop.png");
verytop = loadImage("verytop.png");
areaTextStart=loadImage("placeholder.png");//needs to be replaced with pictures of text that will be made in the close future. 
areaText1=loadImage("placeholder2.png");//Couldve been done with a single PImage but that hinders the performance as it loads the image every frame.
areaText2=loadImage("placeholder.png");
areaText3=loadImage("placeholder2.png");
areaText4=loadImage("placeholder.png");
areaText5=loadImage("placeholder2.png");
areaText6=loadImage("placeholder.png");
areaText7=loadImage("placeholder2.png");
areaTextEnd=loadImage("placeholder.png");

}

void draw(){
   
   //shape of the path
image(below, 0,0);

//if the below is white then it resets the ball
if(ballTester==true){
if (get(mouseX,mouseY) == color(255,255,255)){
  println("BAD!");
  ballTester = false;
}
//Zones
//put all the zone related codes within the specific area.
//being in the zone triggers integer zone in to a certain number, so that the Text images can be drawn later
//if you just put the images within these {} they would just disappear once you let go of the mouse, which doesnt work for us
if (get(mouseX,mouseY) == color(100,0,0)){
  println("User is in start area");
  zone=0;
}
if (get(mouseX,mouseY) == color(150,0,0)){
  println("User is in area #1");
  zone=1;
}
if (get(mouseX,mouseY) == color(0,150,0)){
  println("User is in area #2");
 zone=2;
}
if (get(mouseX,mouseY) == color(0,0,150)){
  println("User is in area #3");
zone=3;
}
if (get(mouseX,mouseY) == color(0,150,150)){
println("User is in area #4");
zone=4;
}
if (get(mouseX,mouseY) == color(150,150,0)){
  println("User is in area #5");
zone=5;
}
if (get(mouseX,mouseY) == color(150,0,150)){
  println("User is in area #6");
zone=6;
}
if (get(mouseX,mouseY) == color(150,150,150)){
  println("User is in area #7");
zone=7;
}
if (get(mouseX,mouseY) == color(0,0,100)){
  println("User is in the end area");
zone=8;
}
}
//Draws the avatar over the place 
if (ballTester == true){
  ballX=mouseX;
  ballY=mouseY;
}
   //image on top
   image(ontop,0,0);
   //Text images for each zone that appear once the zone is entered
if(zone==0){
image(areaTextStart,width/2-100,height/2-150);
}
if(zone==1){
image(areaText1,width/2-100,height/2-150);
}
if(zone==2){
image(areaText2,width/2-100,height/2-150);
}
if(zone==3){
image(areaText3,width/2-100,height/2-150);
}
if(zone==4){
image(areaText4,width/2-100,height/2-150);
}
if(zone==5){
image(areaText5,width/2-100,height/2-150);
}
if(zone==6){
image(areaText6,width/2-100,height/2-150);
}
if(zone==7){
image(areaText7,width/2-100,height/2-150);
}
if(zone==8){
image(areaTextEnd,width/2-100,height/2-150);
}
   
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