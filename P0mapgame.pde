/*
###########################################
P0 project - Map game

Revision: 9
Date: 16/09/2016
By: group 13


Rules for good coding
1) Make sure to regularily comment your code
2) Before you edit any section, make sure to talk to Lars and/or whoever is near you first.
3) Whenever you commit, update the revision number (just add one), date and name
4) Please compile and test your code at least once, before committing it.

Revision 8 notes

Preliminary text graphics in. Textbox location updated on all images.
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

int direction = 1;
PImage front;
PImage back;
PImage tLeft;
PImage tRight;

void setup(){
  size(1414,1000);
  //background images
below = loadImage("below1.png");
ontop = loadImage("ontop.png");
verytop = loadImage("verytop.png");

//area and text images
areaTextStart=loadImage("areaTextStart.png");//needs to be replaced with pictures of text that will be made in the close future. 
areaText1=loadImage("placeholder2.png");//Couldve been done with a single PImage but that hinders the performance as it loads the image every frame.
areaText2=loadImage("placeholder.png");
areaText3=loadImage("placeholder2.png");
areaText4=loadImage("placeholder.png");
areaText5=loadImage("placeholder2.png");
areaText6=loadImage("placeholder.png");
areaText7=loadImage("placeholder2.png");
areaTextEnd=loadImage("placeholder.png");

//avatar images
front = loadImage("front.png");
back = loadImage("back.png");
tLeft = loadImage("left.png");
tRight = loadImage("right.png");

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
image(areaTextStart,width/2-335,height/2-250);
}
if(zone==1){
image(areaText1,width/2-335,height/2-250);
}
if(zone==2){
image(areaText2,width/2-335,height/2-250);
}
if(zone==3){
image(areaText3,width/2-335,height/2-250);
}
if(zone==4){
image(areaText4,width/2-335,height/2-250);
}
if(zone==5){
image(areaText5,width/2-335,height/2-250);
}
if(zone==6){
image(areaText6,width/2-335,height/2-250);
}
if(zone==7){
image(areaText7,width/2-335,height/2-250);
}
if(zone==8){
image(areaTextEnd,width/2-335,height/2-250);
}
   

   
   
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


  //DESIRED EXTRAS
  
    //obstacles(depends on the time)
  //draw obstacles
  //animate obstacles