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
//************INTEGERS*************
int ballX, ballY, currentZone, direction, numberOfZones, time, score, countdown, confetti;
  //ballX and ballY represent characters coordinates
  //currentZone variable to determine which zone you are in  
  //direction variable to detect which direction the character is going in
  //numberOfZones is used for the picture array
  //time, score, countdown and confetti are variables used for the ending
//************PIMAGES*************
PImage[] areaTextArray;
//This array will hold all the text images for the different zones
PImage below, ontop, verytop;//images for below layer used to detect zones, and ontop and verytop for graphics
PImage skill1a,skill2a,skill3a,skill4a,skill5a,skill6a,skill7a;//images of active skills
PImage skill1i,skill2i,skill3i,skill4i,skill5i,skill6i,skill7i;//images of inactive skills
PImage placeholder3,button;//images for button and the text it shows
PImage front,back,tLeft,tRight;//character direction images
//************BOOLEANS*************
boolean skill1act, skill2act, skill3act, skill4act, skill5act, skill6act, skill7act,hide,hide2,ballTester;
  //skill activation booleans, hide and hide2 used to have a properly working button, ballTester to determine whether the character is being held
//************OTHERS*************
String imageName;//used for an array

void setup(){
  size(1414,1000);
  //defining the variables
ballX = 70;
ballY = 870;
skill1act=false;
skill2act=false;
skill3act=false;
skill4act=false;
skill5act=false;
skill6act=false;
skill7act=false;
hide=true;
hide2=true;
direction=2;
score=0;
numberOfZones=9;
areaTextArray = new PImage[numberOfZones];
ballTester=false;
imageName = "areaTextImage";
  //background images
below = loadImage("below1.png");
ontop = loadImage("ontop.png");
verytop = loadImage("verytop.png");
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
  //avatar images
front = loadImage("front.png");
back = loadImage("back.png");
tLeft = loadImage("left.png");
tRight = loadImage("right.png");  

  
//Load in the images of the text for the different areas, and put them into an array
for (int i = 0; i < numberOfZones; i++) {
areaTextArray[i] = loadImage(imageName + i +".png");
} 
  
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
if (get(mouseX,mouseY) == color(50,50,0)){
  println("User is on the job path");
  currentZone=8;
skill7act=true;
}
if (get(mouseX,mouseY) == color(50,0,0)){
  println("User is in the first job area");
  currentZone=9;
}
if (get(mouseX,mouseY) == color(0,50,0)){
  println("User is in the second job area");
  currentZone=9;
}
if (get(mouseX,mouseY) == color(0,0,50)){
  println("User is in the third job area");
  currentZone=10;
}
if (get(mouseX,mouseY) == color(50,50,50)){
  println("User is in the fourth job area");
  currentZone=11;
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

 //Wins the game ... change mouseX to ballX!!!!!!!
if(ballX > 1358){ 

    direction=5;
  if (score==0){
      confetti=1;
  score=(millis()-time)/50;
  countdown=second();
  }
  

 
  fill(0,0,0,100);
  rect(0,0,width,height);
  
  
  //CONFETTI - should maybe be deleted?!
   if (confetti>0){
   noStroke();

     int linespace=1;
for (int i = 1; i < confetti; i = i+15) {
linespace++;
  for (int j = 0; j < 1400; j = j+15) {
       fill(255,0,0);
    rect((linespace*20)+j, 20+i, 10,10);
  }
  if(linespace>1)
  linespace=0;
}
 }
 confetti++;
  //You won text!
  textAlign(CENTER);
  textSize(40);
  fill(255,255,255);
text("CONGRATULATIONS!", width/2, height/2); 
textSize(20);
text("You have succesfully navigated Medialogy and completed with a score of "+score, width/2, height/2+40); 
if (second()-countdown>3){
  //Reset
  //resetting all the variables to the beginning ones
ballX = 70;
ballY = 870;
skill1act=false;
skill2act=false;
skill3act=false;
skill4act=false;
skill5act=false;
skill6act=false;
skill7act=false;
hide=true;
hide2=true;
direction=2;
score=0;
numberOfZones=9;
areaTextArray = new PImage[numberOfZones];
ballTester=false;
}
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