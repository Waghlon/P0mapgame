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
5) Please be careful to use proper indentation
6) Clearly mark different parts of the code

Revision 12 notes
Changed the method of displaying the zone text. It now imports the text as strings from a text document, and displays them as 3D text. 
Implemented Skillbook.
Made the code a bit more readable, added proper indentations

Revision 13 notes
Cleaned up a bit
Added attributes. They are set at random to begin with, and increase randomly each time the user completes a zone.
###########################################
*/

//*******************************************//
//*********// Declaring Variables //*********//
//*******************************************//  
  
//************ Avatar Variables *************//
int ballX, ballY, currentZone, direction, hideAvatar, showIconAtAvatar;    //ballX and ballY represent characters coordinates, currentZone variable to determine which zone you are in 
boolean ballTester;                          //ballTester to determine whether the character is being held
PImage below, ontop, verytop;                //images for below layer used to detect zones, and ontop and verytop for graphics
PImage[] avatarImages;
float timer, savedTime, iconTimer, iconTimerSaved;

//************ Zone Text Variables *************//
int zoneTitleFontSize, zoneTextFontSize, numberOfZones;
String[] zoneText, zoneTitle;

//************ Skillbook Variables *************//
int skillBookPosX, skillBookPosY, numberOfSkills, numberOfAttributes, skillsUnlocked, iconSize, bookFontSize;
int[] attributePoints;
PImage skillBook, bookDrawing01, bookDrawing02;
PImage[] skillIconsActive, skillIconsNotActive;
String[] skillNames, attributeNames;

//************ Button Variables *************//
boolean hide,hide2;                         //hide and hide2 used to have a properly working button
PImage placeholder3,button;                 //images for button and the text it shows

//************ Game Completion Variables *************//
int time, score, countdown, confetti;        //time, score, countdown and confetti are variables used for the ending
  
//************ Fonts *************//
PFont fontKeepCalm;

//************ Title *************//
PImage titleImage;


void setup(){
  
  size(1414, 1000, P3D);
  smooth(8);
  
  //*********// Avatar Variables //*********//
  ballX = 70;
  ballY = 870;
  hide=true;
  hide2=true;
  direction=2;
  score=0;
  ballTester=false;


  //*********// Load in background and foreground images //*********//
  below = loadImage("backdrops/below1.png");
  ontop = loadImage("backdrops/ontop.png");
  verytop = loadImage("backdrops/verytop.png");


  //*********// Zone Text Setup //***********//
  zoneText = loadStrings("strings/zoneTextStrings.txt");
  zoneTitle = loadStrings("strings/zoneTitleStrings.txt");
  zoneTitleFontSize = 26;
  zoneTextFontSize = 20;
  
  //Turn the underscores in the string file into line breaks. Putting the \n directly into the string file didn't work for some reason.
  for (int i = 0; i < zoneText.length; i++) {
    zoneText[i] = zoneText[i].replaceAll("_", "\n"); 
  }
  
  
  //*********// Skill Book Setup //***********//  
  skillBook = loadImage("skillbook/skillbookImage.png");
  skillBook.resize(450,0);
  skillBookPosX = 960;
  skillBookPosY = 10;  
  
  bookDrawing01 = loadImage("skillbook/bookDrawing01.png");
  bookDrawing02 = loadImage("skillbook/bookDrawing02.png");
  skillNames = loadStrings("strings/skillNameStrings.txt");
  attributeNames = loadStrings("strings/attributeNames.txt");
  numberOfSkills = skillNames.length;
  numberOfAttributes = attributeNames.length;
  skillIconsActive = new PImage[numberOfSkills];
  skillIconsNotActive = new PImage[numberOfSkills];
  fontKeepCalm = loadFont("fonts/keepCalm.vlw");
  iconSize = 20;
  bookFontSize = 14;  
  
  attributePoints = new int[numberOfAttributes];
    
  //Load in the  icons for the skills, and put them into the array. The files are called the same as the corresponding skill, minus spaces
  //The spaces are removed with replaceAll(" ", "")
  //The inactive skill icons are turned grayscale using filter(GRAY)
  for (int i = 0; i < numberOfSkills; i++) {
    skillIconsActive[i] = loadImage("skillbook/icons/" + skillNames[i].replaceAll(" ", "") +".png");
    skillIconsNotActive[i] = loadImage("skillbook/icons/" + skillNames[i].replaceAll(" ", "") +".png");
    skillIconsNotActive[i].filter(GRAY);
  } 
  
  //Assign random attribute levels
  for (int i = 0; i < numberOfAttributes; i++) {
    attributePoints[i] = int(random(1,7));
  } 



  //*********// Button and its text //*********//
  button=loadImage("button.png");
  button.resize(50,50);
  placeholder3=loadImage("placeholder3.png");
  
  
  
  //*********// Load in Avatar images //*********//
  avatarImages = new PImage[4];
  avatarImages[0] = loadImage("avatar/front.png");
  avatarImages[1] = loadImage("avatar/right.png");
  avatarImages[2] = loadImage("avatar/back.png");
  avatarImages[3] = loadImage("avatar/left.png");  
 
 
  titleImage = loadImage("titleImage.png");

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
      currentZone=2;
    }
    if (get(mouseX,mouseY) == color(0,0,150)){
      println("User is in area #3");
      currentZone=3;
    }
    if (get(mouseX,mouseY) == color(0,150,150)){
      println("User is in area #4");
      currentZone=4;
    }
    if (get(mouseX,mouseY) == color(150,150,0)){
      println("User is in area #5");
      currentZone=5;
    }
    if (get(mouseX,mouseY) == color(150,0,150)){
      println("User is in area #6");
      currentZone=6;
    }
    if (get(mouseX,mouseY) == color(150,150,150)){
      println("User is in area #7");
      currentZone=7;
    }
    if (get(mouseX,mouseY) == color(50,50,0)){
      println("User is on the job path");
      currentZone=8;
    }
    if (get(mouseX,mouseY) == color(50,0,0)){
      println("User is in the first job area");
      currentZone=9;
    }
      if (get(mouseX,mouseY) == color(0,50,0)){
      println("User is in the second job area");
      currentZone=10;
    }
    if (get(mouseX,mouseY) == color(0,0,50)){
      println("User is in the third job area");
      currentZone=11;
    }
    if (get(mouseX,mouseY) == color(50,50,50)){
      println("User is in the fourth job area");
      currentZone=12;
    }
  }
  
  //Unlock the next skill if you've entered a zone you haven't been in yet
  if (skillsUnlocked < currentZone - 1 && skillsUnlocked < numberOfSkills) {
    skillsUnlocked++;
    showIconAtAvatar = 1;
    iconTimerSaved = millis();
    
     //Add a random number of attribute points
     for (int i = 0; i < numberOfAttributes; i++) {
       attributePoints[i] += int(random(0,4));
       attributePoints[i] = constrain(attributePoints[i], 0,11);
     } 
  
  }
  
 
   //image on top
   image(ontop,0,0);

  //************// Draw the text for the current zone //************//
  pushMatrix();
    rotateX(0.3);  //Rotate it in 3D space. Cool!
    fill(0,0,0);
    textFont(fontKeepCalm, zoneTitleFontSize);
    text(zoneTitle[currentZone], 450, 300, 475, 500);
    textFont(fontKeepCalm, zoneTextFontSize);
    text(zoneText[currentZone], 450, 340, 475, 500);
  popMatrix();


   //****************// Draw the Avatar //****************//
   
  //Draws the avatar over the place 
  if (ballTester == true){
    ballX=mouseX;
    ballY=mouseY;
  }
  
  timer = (millis() - savedTime)/1000;
  
  if (hideAvatar != 1) {
    
  //Determine the direction the avatar should be facing, but only once every 1/10th of a second
  if (timer > 0.1) {  
    if (mouseY < pmouseY && ballX == mouseX && ballY == mouseY){
      direction=2;
    } else if (mouseY > pmouseY && ballX == mouseX && ballY == mouseY){
    direction=0;
    } else if (mouseX < pmouseX && ballX == mouseX && ballY == mouseY){
      direction=3;
    } else if (mouseX > pmouseX && ballX == mouseX && ballY == mouseY){
      direction=1;
    }      
    //Reset the timer
    savedTime = millis();    
  }
         
  //Draw the Avatar
  image(avatarImages[direction], ballX-10, ballY-20, 20,30);
  
  iconTimer = (millis() - iconTimerSaved)/1000;
  
 

  //****************// Draw the top most layers //****************//

  //Layer that's ontop of everything that the ball travels behind
  image(verytop,0,0);
  
  //draws a button(can be deleted if we implement buttons into ontop image
  /*image(button,70,550);
  if(hide==false){
    image(placeholder3,width/2-335,height/2-250);
    hide2=false;
  }
*/

  //****************// Draw the icon of the skill recently acquired //****************//
  if (showIconAtAvatar == 1 && iconTimer <= 2.5) {
    
    float fadeIn;
    
    if (iconTimer < 1) {
      fadeIn = constrain(iconTimer*4, 0, 1);
    } else {
      fadeIn = constrain((2.5 - iconTimer)*4, 0, 1);
    }
    
    tint(255,255*fadeIn);
    fill(230,230,230,255*fadeIn);
    stroke(0, 255*fadeIn);
    rect(ballX - 25, ballY - 55, 210, 35);
    image(skillIconsActive[skillsUnlocked - 1], ballX - 15, ballY - 50, iconSize, iconSize);
    textFont(fontKeepCalm, 22);
    fill(0,0,0,255*fadeIn);
    text("Skill Aqcuired", ballX + 15, ballY - 30);
    noTint();
    } else if (showIconAtAvatar == 1 && iconTimer > 2){
    showIconAtAvatar = 0;
    }
    
  }
  
  //****************// Draw the Skillbook //********************//

  image(skillBook, skillBookPosX, skillBookPosY);
  textFont(fontKeepCalm, 26);
  fill(0,0,0);
  text("Skills", skillBookPosX + 40, skillBookPosY + 50);
  
  //Get ready for drawing the skills
  textFont(fontKeepCalm, bookFontSize);
  int spaceBetweenSkills = 25;
  
  //Draw the icons and text for the inactive skills. "i" starts at skillsUnlocked. That way, it doesnt draw the skills that have been activated, and will be drawn by the next for loop.
  for (int i = skillsUnlocked; i < numberOfSkills; i++) {
    fill(75,75,75,175);
    tint(255, 165);
    image(skillIconsNotActive[i], skillBookPosX + 45, skillBookPosY + 64 +  + spaceBetweenSkills*i, iconSize, iconSize);
    text(skillNames[i], skillBookPosX + 70, skillBookPosY + 80 +  + spaceBetweenSkills*i);
    noTint();
  } 
  
  //Draw the icons and text for the active skills
  for (int i = 0; i < skillsUnlocked; i++) {
    fill(0,0,0,255);
    image(skillIconsActive[i], skillBookPosX + 45, skillBookPosY + 64 +  + spaceBetweenSkills*i, iconSize, iconSize);
    text(skillNames[i], skillBookPosX + 70, skillBookPosY + 80 +  + spaceBetweenSkills*i);
  } 
  
  //Draw the attributes
  for (int i = 0; i < numberOfAttributes; i++) {
    fill(0,0,0);
    text(attributeNames[i] + ": " + attributePoints[i], skillBookPosX + 255, skillBookPosY + 80 +  + spaceBetweenSkills*i);
  } 
  
  //Draw the drawings, lol
  tint(255, 200);
  image(bookDrawing01, skillBookPosX + 20, skillBookPosY + 215);
  image(bookDrawing02, skillBookPosX + 240, skillBookPosY + 225);
  noTint();
  
  //***************// Draw the title of the damn game! //******************//
  
  //textFont(fontKeepCalm, 48);
  //fill(220,70,46, 210);
  //1text("Journey of Medialogy", 85, 170);
  titleImage.resize(650,0);
  image(titleImage, 70, 120);

  //***************// End of Game Stuff //******************//

   //Wins the game ... change mouseX to ballX!!!!!!!
  if(ballX > 1358){ 
    
    hideAvatar = 1;
  
      direction=1;
    if (score==0){
        confetti=1;
    score=(millis()-time)/50;
    countdown=millis();
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
    textAlign(LEFT);
    if (millis()-countdown > 5000){
      //Reset
      //resetting all the variables to the beginning ones
    ballX = 70;
    ballY = 870;
    
    hide=true;
    hide2=true;
    direction=2;
    score=0;
    ballTester=false;
    currentZone=0;
    skillsUnlocked = 0;
    hideAvatar = 0;
    
      //Assign random attribute levels
    for (int i = 0; i < numberOfAttributes; i++) {
      attributePoints[i] = int(random(1,9));
    } 
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

// start of the code added by robert
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



  //DESIRED EXTRAS
  
    //obstacles(depends on the time)
  //draw obstacles
  //animate obstacles