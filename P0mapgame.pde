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

Revision 16 notes
Skillbook is now interactive and describes the various skills.
###########################################
*/

//*******************************************//
//*********// Declaring Variables //*********//
//*******************************************//  
  
//************ Avatar Variables *************//
int avatarPosX, avatarPosY, currentZone, direction, hideAvatar, showIconAtAvatar;    //avatarPosX and avatarPosY represent characters coordinates, currentZone variable to determine which zone you are in 
boolean ballTester;                          //ballTester to determine whether the character is being held
PImage below, ontop, verytop;                //images for below layer used to detect zones, and ontop and verytop for graphics
PImage[] avatarImages;
float timer, savedTime, iconTimer, iconTimerSaved;

//************ Zone Text Variables *************//
int zoneTitleFontSize, zoneTextFontSize, numberOfZones;
Table zoneTextTable;

//************ Skillbook Variables *************//
int skillBookPosX, skillBookPosY, numberOfSkills, skillsUnlocked, iconSize, bookFontSize, spaceBetweenSkills, skillDescrActive;
int[] skillIconPosX, skillIconPosY;
PImage skillBook, bookDrawing01, bookDrawing02;
PImage[] skillIconsActive, skillIconsNotActive;
Table skillDataTable;

//************ Button Variables *************//
boolean hide,hide2;                         //hide and hide2 used to have a properly working button
PImage placeholder3,button;                 //images for button and the text it shows

//************ Game Completion Variables *************//
int time, score, countdown, confetti;        //time, score, countdown and confetti are variables used for the ending
  
//************ Fonts *************//
PFont fontKeepCalm;
PFont fontRoboto;

//************ Title *************//
PImage titleImage;


void setup(){
    
  //*********// General Setup //*********//
  size(1414, 1000, P3D);
  smooth(8);
  fontKeepCalm = loadFont("fonts/keepCalm.vlw");
  fontRoboto = loadFont("fonts/roboto.vlw");
  
  
  //*********// Avatar Variables //*********//
  avatarPosX = 70;
  avatarPosY = 870;
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
  
  //Load in the table holding the data for all zones. 
  zoneTextTable = loadTable("strings/zoneData.txt", "header, tsv");
  //Each row contains title and text for each zone, so the number of rows equals number of zones.
  numberOfZones = zoneTextTable.getRowCount();

  //Text Size
  zoneTitleFontSize = 26;
  zoneTextFontSize = 20;
  
  //Turn the underscores in the string file into /n, which equals line breaks when drawin the text. Putting the \n directly into the table didn't work for some reason.
  for (int i = 0; i < numberOfZones; i++) {
    //load in the string from each row, replace the underscores with /n, put it back into the table
    String stringWithoutSpaces = zoneTextTable.getString(i,1).replaceAll("_", "\n");
    zoneTextTable.setString(i,1,stringWithoutSpaces); 
  }
  
  
  //*********// Skill Book Setup //***********//  
  skillBook = loadImage("skillbook/skillbookImage.png");
  skillBook.resize(450,0);
  skillBookPosX = 960;
  skillBookPosY = 10;  
  
  //Load in the images
  bookDrawing01 = loadImage("skillbook/bookDrawing01.png");
  bookDrawing02 = loadImage("skillbook/bookDrawing02.png");
  
  //Load in the Skill text strings
  skillDataTable = loadTable("strings/skillData.txt", "header, tsv");
  numberOfSkills = skillDataTable.getRowCount();
  skillIconPosX = new int[numberOfSkills];
  skillIconPosY = new int[numberOfSkills];
  skillIconsActive = new PImage[numberOfSkills];
  skillIconsNotActive = new PImage[numberOfSkills];
  iconSize = 20;
  spaceBetweenSkills = 25;
  bookFontSize = 18;  
  
   //Turn the underscores in the string file into /n, which equals line breaks when drawin the text. Putting the \n directly into the table didn't work for some reason.
  for (int i = 0; i < numberOfSkills; i++) {
    //load in the string from each row, replace the underscores with /n, put it back into the table
    String stringWithoutSpaces = skillDataTable.getString(i,1).replaceAll("_", "\n");
    skillDataTable.setString(i,1,stringWithoutSpaces); 
  }
  
  //Determine the position of the icons. We store these valules in an array, both for optimization, but also so that we can monitor if the mouse is on top of one of them
  for (int i = 0; i < numberOfSkills; i++) {
    skillIconPosX[i] = skillBookPosX + 45;
    skillIconPosY[i] = skillBookPosY + 56 + spaceBetweenSkills*i;
  } 

  
    
  //Load in the  icons for the skills, and put them into the array. The files are called the same as the corresponding skill, minus spaces.
  //The skill name is extracted from the skillDataTable table with getString, pulling it from row number "i", from the "Skill Names" column.
  //The spaces are removed with replaceAll(" ", "")
  //The inactive skill icons are turned grayscale using filter(GRAY)
  for (int i = 0; i < numberOfSkills; i++) {
    String imagePath = "skillbook/icons/" + skillDataTable.getString(i,"Skill Names").replaceAll(" ", "") +".png";
    skillIconsActive[i] = loadImage(imagePath);
    skillIconsNotActive[i] = loadImage(imagePath);
    skillIconsNotActive[i].filter(GRAY);
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
    skillDescrActive = constrain(skillsUnlocked - 1, 0, numberOfSkills);
    showIconAtAvatar = 1;
    iconTimerSaved = millis();
 
  }
  
 
   //image on top
   image(ontop,0,0);

  //************// Draw the text for the current zone //************//
  pushMatrix();
    rotateX(0.3);  //Rotate it in 3D space. Cool!
    fill(0,0,0);
    textFont(fontKeepCalm, zoneTitleFontSize);
    text(zoneTextTable.getString(currentZone,0), 450, 300, 475, 500);
    textFont(fontKeepCalm, zoneTextFontSize);
    text(zoneTextTable.getString(currentZone,1), 450, 340, 475, 500);
  popMatrix();


   //****************// Draw the Avatar //****************//
   
  //Draws the avatar over the place 
  if (ballTester == true){
    avatarPosX=mouseX;
    avatarPosY=mouseY;
  }
  
  timer = (millis() - savedTime)/1000;
  
  if (hideAvatar != 1) {
    
  //Determine the direction the avatar should be facing, but only once every 1/10th of a second
  if (timer > 0.1) {  
    if (mouseY < pmouseY && avatarPosX == mouseX && avatarPosY == mouseY){
      direction=2;
    } else if (mouseY > pmouseY && avatarPosX == mouseX && avatarPosY == mouseY){
    direction=0;
    } else if (mouseX < pmouseX && avatarPosX == mouseX && avatarPosY == mouseY){
      direction=3;
    } else if (mouseX > pmouseX && avatarPosX == mouseX && avatarPosY == mouseY){
      direction=1;
    }      
    //Reset the timer
    savedTime = millis();    
  }
         
  //Draw the Avatar
  image(avatarImages[direction], avatarPosX-10, avatarPosY-20, 20,30);
  
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
    rect(avatarPosX - 25, avatarPosY - 55, 160, 30);
    image(skillIconsActive[skillsUnlocked - 1], avatarPosX - 15, avatarPosY - 50, iconSize, iconSize);
    textFont(fontRoboto, 18);
    fill(0,0,0,255*fadeIn);
    text("Skill Acquired", avatarPosX + 15, avatarPosY - 34);
    noTint();
    } else if (showIconAtAvatar == 1 && iconTimer > 2){
    showIconAtAvatar = 0;
    }
    
  }
  
  //****************// Draw the Skillbook //********************//

  image(skillBook, skillBookPosX, skillBookPosY);
  
  //Draw the "Skills" headline
  textFont(fontRoboto, 32);
  fill(0,0,0);
  text("Skills", skillBookPosX + 45, skillBookPosY + 50);
  
  //Draw the shape that shows which skills is being described on the right page
  fill(0,0,0,125);
  stroke(0,150);
  beginShape();
  vertex(skillIconPosX[skillDescrActive] - 5, skillIconPosY[skillDescrActive] - 3);
  vertex(skillIconPosX[skillDescrActive] - 5, skillIconPosY[skillDescrActive] + iconSize + 3);
  vertex(skillIconPosX[skillDescrActive] + 195, skillIconPosY[skillDescrActive] + iconSize + 3);
  vertex(skillIconPosX[skillDescrActive] + 195, skillIconPosY[0] + 270);
  vertex(skillIconPosX[skillDescrActive] + 385, skillIconPosY[0] + 270);
  vertex(skillIconPosX[skillDescrActive] + 385, skillIconPosY[0] - 35);
  vertex(skillIconPosX[skillDescrActive] + 195, skillIconPosY[0] - 35);
  vertex(skillIconPosX[skillDescrActive] + 195, skillIconPosY[skillDescrActive] - 3);
  vertex(skillIconPosX[skillDescrActive] - 5, skillIconPosY[skillDescrActive] - 3);
  endShape();
  
  //Get ready for drawing the skills
  textFont(fontRoboto, bookFontSize);
  
  //Draw the icons and text for the inactive skills. "i" starts at skillsUnlocked. That way, it doesnt draw the skills that have been activated, and will be drawn by the next for loop.
  for (int i = skillsUnlocked; i < numberOfSkills; i++) {
    
    //If the skill is the one being described right now, make the text white. If not make it black.
    if (i == skillDescrActive) {
      fill(255,255,255,235);
    } else { 
      fill(35,35,35,200);
    }
    
    tint(255, 195);
    image(skillIconsNotActive[i], skillIconPosX[i], skillIconPosY[i], iconSize, iconSize);
    text(skillDataTable.getString(i,"Skill Names"), skillIconPosX[i] + 25, skillIconPosY[i] + 16);
    noTint();
  } 
  
  //Draw the icons and text for the active skills
  for (int i = 0; i < skillsUnlocked; i++) {
    
    //If the skill is the one being described right now, make the text white. If not make it black.
    if (i == skillDescrActive) {
      fill(255,255,255,255);
    } else { 
      fill(0,0,0,255);
    }
    
    image(skillIconsActive[i], skillIconPosX[i], skillIconPosY[i], iconSize, iconSize);
    text(skillDataTable.getString(i,"Skill Names"), skillIconPosX[i] + 25, skillIconPosY[i] + 16);
  } 
  
  
  //Draw the Skill Description
  fill(255,255,255,255);
  textFont(fontRoboto, 15);
  text(skillDataTable.getString(skillDescrActive,"Skill Description"), skillBookPosX + 247, skillIconPosY[0], 183, 300);
  
  //Draw the drawings, lol
  tint(255, 220);
  image(bookDrawing01, skillBookPosX + 30, skillBookPosY + 215);
  //image(bookDrawing02, skillBookPosX + 240, skillBookPosY + 225);
  noTint();
  
  //***************// Draw the title of the damn game! //******************//
  
  //textFont(fontKeepCalm, 48);
  //fill(220,70,46, 210);
  //1text("Journey of Medialogy", 85, 170);
  titleImage.resize(650,0);
  image(titleImage, 70, 120);

  //***************// End of Game Stuff //******************//

   //Wins the game ... change mouseX to avatarPosX!!!!!!!
  if(avatarPosX > 1358){ 
    
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
    avatarPosX = 70;
    avatarPosY = 870;
    
    hide=true;
    hide2=true;
    direction=2;
    score=0;
    ballTester=false;
    currentZone=0;
    skillsUnlocked = 0;
    hideAvatar = 0;

  }
  }
}

//This checks if the mouse is dragging the ball. When mouse is released balltester is zeroed.

void mouseDragged(){
  if (mouseX > avatarPosX-10 & mouseX < avatarPosX+10 & mouseY < avatarPosY+10 & mouseY > avatarPosY-10){
    ballTester = true;
  }
}

void mouseReleased(){
  ballTester=false;
}


void mouseClicked(){
  
  
  //Check if one of the skills is clicked on
  for (int i = 0; i < numberOfSkills; i++) {
     
    //If the mouse is within the bounds of skill number "i", that should be set as the active skill description
    if (mouseX > skillIconPosX[i] && mouseX < skillIconPosX[i] + 160 && mouseY > skillIconPosY[i] && mouseY < skillIconPosY[i] + iconSize) {
      skillDescrActive = i;
    }   
     
  } 
  

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