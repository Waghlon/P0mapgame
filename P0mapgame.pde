/*
###########################################
P0 project - Map game

Revision: 10
Date: 19/09/2016
By: group 13


Rules for good coding
1) Make sure to regularily comment your code
2) Before you edit any section, make sure to talk to Lars and/or whoever is near you first.
3) Whenever you commit, update the revision number (just add one), date and name
4) Please compile and test your code at least once, before committing it.

Revision 10 notes

Changed the method of loading in an drawing the zone text images to using an array.
###########################################
*/

//Below we initialize the variables and classes for the media.

int ballX;
int ballY;
boolean ballTester = false;
PImage below;
PImage ontop;
PImage verytop;
int currentZone;
String imageName = "areaTextImage";
//                                                                          Start of code added by Robert
//booleans for acquiring each skill
boolean skill1act=false;
boolean skill2act=false;
boolean skill3act=false;
boolean skill4act=false;
boolean skill5act=false;
boolean skill6act=false;
boolean skill7act=false;
//images for active skills
PImage skill1a;
PImage skill2a;
PImage skill3a;
PImage skill4a;
PImage skill5a;
PImage skill6a;
PImage skill7a;
//images for inactive skills
PImage skill1i;
PImage skill2i;
PImage skill3i;
PImage skill4i;
PImage skill5i;
PImage skill6i;
PImage skill7i;
PImage button;
//buttons and inactive skills can be implemented into ontop image
PImage placeholder3;
//check whether it is the second time the user has clicked the thing to close the information
boolean hide=true;
boolean hide2=true;
//                                                                                            end of code added by robert
int zone=0;//zone variable to determine which zone you are in
int direction = 1;//direction variable to detect which direction the character is going in
PImage front;
PImage back;
PImage tLeft;
PImage tRight;

//This array will hold all the text images for the different zones
int numberOfZones = 9;
PImage[] areaTextArray = new PImage[numberOfZones];

void setup(){
  
  size(1414,1000);
  //background images
  below = loadImage("below1.png");
  ontop = loadImage("ontop.png");
  verytop = loadImage("verytop.png");
  
  //Load in the images of the text for the different areas, and put them into an array
  for (int i = 0; i < numberOfZones; i++) {
    areaTextArray[i] = loadImage(imageName + i +".png");
  }
  
  //area and text images
//                                                            start of the code added by robert
//inactive skills(need replacements)
skill1i=loadImage("skilli.png");
skill2i=loadImage("skilli.png");
skill3i=loadImage("skilli.png");
skill4i=loadImage("skilli.png");
skill5i=loadImage("skilli.png");
skill6i=loadImage("skilli.png");
skill7i=loadImage("skilli.png");
//active skills(need replacements)
skill1a=loadImage("skilla.png");
skill2a=loadImage("skilla.png");
skill3a=loadImage("skilla.png");
skill4a=loadImage("skilla.png");
skill5a=loadImage("skilla.png");
skill6a=loadImage("skilla.png");
skill7a=loadImage("skilla.png");
//button and its text
button=loadImage("button.png");
button.resize(50,50);
placeholder3=loadImage("placeholder3.png");
//                                                            end of the code added by robert
  
  //avatar images
  front = loadImage("front.png");
  back = loadImage("back.png");
  tLeft = loadImage("left.png");
  tRight = loadImage("right.png");
  
  ballX = 130;
  ballY = 630;
  
  
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
  currentZone=0;
}
if (get(mouseX,mouseY) == color(150,0,0)){
  println("User is in area #1");
  currentZone = 1;
}
if (get(mouseX,mouseY) == color(0,150,0)){
  println("User is in area #2");
  skill1act=true;
  currentZone=2;
}
if (get(mouseX,mouseY) == color(0,0,150)){
  println("User is in area #3");
  currentZone=3;
  skill2act=true;
}
if (get(mouseX,mouseY) == color(0,150,150)){
  println("User is in area #4");
  currentZone=4;
  skill3act=true;
}
if (get(mouseX,mouseY) == color(150,150,0)){
  println("User is in area #5");
  currentZone=5;
  skill4act=true;
}
if (get(mouseX,mouseY) == color(150,0,150)){
  println("User is in area #6");
  currentZone=6;
skill5act=true;
}
if (get(mouseX,mouseY) == color(150,150,150)){
  println("User is in area #7");
  currentZone=7;
skill6act=true;
}
if (get(mouseX,mouseY) == color(0,0,100)){
  println("User is in the end area");
  currentZone=8;
skill7act=true;
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
//                                                          start of the code added by robert
//displaying inactive skills first
if(skill1act==false){
image(skill1i,width-100, 30);
}
if(skill2act==false){
image(skill2i,width-100, 50);
}
if(skill3act==false){
image(skill3i,width-100, 70);
}
if(skill4act==false){
image(skill4i,width-100, 90);
}
if(skill5act==false){
image(skill5i,width-100, 110);
}
if(skill6act==false){
image(skill6i,width-100, 130);
}
if(skill7act==false){
image(skill7i,width-100, 150);
}
//displaying active skills now
if(skill1act==true){
image(skill1a,width-100, 30);
}
if(skill2act==true){
image(skill2a,width-100, 50);
}
if(skill3act==true){
image(skill3a,width-100, 70);
}
if(skill4act==true){
image(skill4a,width-100, 90);
}
if(skill5act==true){
image(skill5a,width-100, 110);
}
if(skill6act==true){
image(skill6a,width-100, 130);
}
if(skill7act==true){
image(skill7a,width-100, 150);
}
//                                                              end of the code added by robert

//Draw the text for the current zone
image(areaTextArray[currentZone],width/2-335,height/2-250);

   
   
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
 //draws a button(can be deleted if we implement buttons into ontop image
image(button,70,550);
if(hide==false){
image(placeholder3,width/2-335,height/2-250);
hide2=false;
}
  
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
//                                                      start of the code added by robert
void mouseClicked(){
if(mouseX>70&mouseX<70+50&mouseY>550&mouseY<600){
  if(hide==true){
    hide=false;
}
   if(hide2==false){ 
hide=true;
hide2=true;
}
}
}
//                                                    end of the code added by robert


  //DESIRED EXTRAS
  
    //obstacles(depends on the time)
  //draw obstacles
  //animate obstacles