/*
###########################################
 P0 project - Map game
 By: group 13
 Rules for good coding
 1) Make sure to regularly comment your code
 2) Before you edit any section, make sure to talk to Lars and/or whoever is near you first.
 3) Whenever you commit, update the revision number (just add one), date and name
 4) Please compile and test your code at least once, before committing it.
 5) Please be careful to use proper indentation
 6) Clearly mark different parts of the code
 
Revision 19 notes
Speaker/Soundwave obstacle fully implemented
Animated the skill icons when a new skill is unlocked
Put the zone color codes into an array. The colors are now all grayscale. Easy to generate in a "for loop".

 ###########################################
 */

//*******************************************//
//*********// Declaring Variables //*********//
//*******************************************//  

//************ Avatar Variables *************//
int avatarSizeX, avatarSizeY, avatarCollisionBoxX, avatarCollisionBoxY, currentZone, direction, hideAvatar, showIconAtAvatar, lastUnlockedSkill;    //avatarCurrentPosX and avatarCurrentPosY represent characters coordinates, currentZone variable to determine which zone you are in 
int avatarCurrentPosX, avatarCurrentPosY, avatarStartingPosX, avatarStartingPosY, avatarReset1PosX, avatarReset1PosY, avatarReset2PosX, avatarReset2PosY;
boolean avatarSelected, avatarActivated;                        //avatarSelected to determine whether the character is being dragged
PImage below, ontop, verytop, occludingLayer;                //images for below layer used to detect zones, and ontop and verytop for graphics
PImage[] avatarImages;
float directionTimer, savedTime, iconTimer, iconTimerSaved, outlineTimer;

//************ Zone Variables *************//
int zoneTitleFontSize, zoneTextFontSize, numberOfZones;
Table zoneTextTable;
PFont zoneTextFont;
color zoneFontColor;
color[] zoneColorCodes;

//************ Skillbook Variables *************//
int skillBookPosX, skillBookPosY, numberOfSkills, skillsUnlocked, iconSize, bookFontSize, spaceBetweenSkills, skillDescrActive;
int[] skillIconPosX, skillIconPosY;
PImage skillBook, bookDrawing01, bookDrawing02;
PImage[] skillIconsActive, skillIconsNotActive;
Table skillDataTable;

//************ Animated Skill Icon Variables *************//
float bezierX1, bezierY1, bezierX2, bezierY2, bezierXC1, bezierYC1, bezierXC2, bezierYC2;
float iconAnimDuration, iconAnimPctDone, iconAnimScale;
int animSkillIconPosX, animSkillIconPosY, activationPosX, activationPosY;

//************ Game Completion Variables *************//
int time, score, countdown, confetti;        //time, score, countdown and confetti are variables used for the ending

//************ Fonts *************//
PFont fontKeepCalm;
PFont fontRoboto;
PFont fontArchitect;
PFont fontIgiari;

//************ Title *************//
PImage titleImage;

//************ Obstacle 1 **********//
boolean obsReturn;
float obs1Width, obs1Height, obs1PosX, obs1PosY, obs1PathPosX;
PImage pencil;

//************ Obstacle 2 **********//
PImage soundwaves;
float obs2Timer, obs2TimerSaved, obs2WaveDuration, obs2PauseLength, obs2Opacity, obs2Width, obs2Height, obs2CurrentPosX, obs2CurrentPosY, obs2StartingPosX, obs2StartingPosY, soundWaveScale;


void setup() {

    //*********// General Setup //*********//
    size(1414, 1000, P3D);
    smooth(8);
    hint(DISABLE_DEPTH_TEST);                            //Removed problems with overlapping text and images
    fontKeepCalm = loadFont("fonts/keepCalm.vlw");
    fontRoboto = loadFont("fonts/roboto.vlw");
    fontArchitect = loadFont("fonts/architect.vlw");
    fontIgiari = loadFont("fonts/igiari.vlw");


    //*********// Avatar Variables //*********//
    avatarSizeX = 35;
    avatarSizeY = 35;
    avatarCollisionBoxX = 16;
    avatarCollisionBoxY = 22;
    avatarStartingPosX = 80;    //1200
    avatarStartingPosY = 870;  //880
    avatarCurrentPosX = avatarStartingPosX;
    avatarCurrentPosY = avatarStartingPosY;
    direction=2;
    score=0;
    avatarSelected=false;


    //*********// Load in background and foreground images //*********//    
    below = loadImage("backdrops/zonesColors.png");
    ontop = loadImage("backdrops/ontop.png");
    verytop = loadImage("backdrops/verytop.png");
    occludingLayer = loadImage("backdrops/occludingLayer.png");


    //*********// Zone Setup //***********//

    //Load in the table holding the data for all zones. 
    zoneTextTable = loadTable("strings/zoneData.txt", "header, tsv");
    //Each row contains title and text for each zone, so the number of rows equals number of zones.
    numberOfZones = zoneTextTable.getRowCount();
    
    zoneColorCodes = new color[numberOfZones];
    
    //Assign the zones a color code
    for ( int i = 0; i < numberOfZones; i++) {
        zoneColorCodes[i] = color(15*(i + 1),15*(i + 1),15*(i + 1));
    }

    //Font Settings
    zoneFontColor = color(25, 25, 25, 225);
    zoneTextFont = fontArchitect;
    zoneTitleFontSize = 28;
    zoneTextFontSize = 18;

    //Turn the underscores in the string file into /n, which equals line breaks when drawin the text. Putting the \n directly into the table didn't work for some reason.
    for (int i = 0; i < numberOfZones; i++) {
        //load in the string from each row, replace the underscores with /n, then put it back into the table with setString
        String stringWithoutSpaces = zoneTextTable.getString(i, 1).replaceAll("_", "\n");
        zoneTextTable.setString(i, 1, stringWithoutSpaces);
    }


    //*********// Skill Book Setup //***********//  
    skillBook = loadImage("skillbook/skillbookImage.png");
    skillBook.resize(450, 0);
    skillBookPosX = 960;
    skillBookPosY = 10;  

    //Load in the drawings
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
        String stringWithoutSpaces = skillDataTable.getString(i, 1).replaceAll("_", "\n");
        skillDataTable.setString(i, 1, stringWithoutSpaces);
    }

    //Determine the position of the icons. We calculate and store these valules in an array, because we'll be using them several times
    for (int i = 0; i < numberOfSkills; i++) {
        skillIconPosX[i] = skillBookPosX + 45;
        skillIconPosY[i] = skillBookPosY + 56 + spaceBetweenSkills*i;
    } 



    //Load in the  icons for the skills, and put them into the array. The files are called the same as the corresponding skill, minus spaces.
    //The skill name is extracted from the skillDataTable table with getString, pulling it from row number "i", from the "Skill Names" column.
    //The spaces are removed with replaceAll(" ", "")
    //The inactive skill icons are turned grayscale using filter(GRAY)
    for (int i = 0; i < numberOfSkills; i++) {
        String imagePath = "skillbook/icons/" + skillDataTable.getString(i, "Skill Names").replaceAll(" ", "") +".png";
        skillIconsActive[i] = loadImage(imagePath);
        skillIconsNotActive[i] = loadImage(imagePath);
        skillIconsNotActive[i].filter(GRAY);
    } 

    //*********// Animated Skill Icon Settings //*********//

    iconAnimDuration = 1.5;

    //*********// Load in Avatar images //*********//
    avatarImages = new PImage[8];
    avatarImages[0] = loadImage("avatar/front.png");
    avatarImages[1] = loadImage("avatar/right.png");
    avatarImages[2] = loadImage("avatar/back.png");
    avatarImages[3] = loadImage("avatar/left.png");  
    avatarImages[4] = loadImage("avatar/frontOutline.png");
    avatarImages[5] = loadImage("avatar/rightOutline.png");
    avatarImages[6] = loadImage("avatar/backOutline.png");
    avatarImages[7] = loadImage("avatar/leftOutline.png");  

    //*********// Other Images //*********//
    titleImage = loadImage("titleImage.png");


    //*********// Obstacle 1 //*********//
    obsReturn=false;
    obs1Width = 80;
    obs1Height=20;
    obs1PosX=230;
    obs1PosY=600;
    obs1PathPosX=170;
    
    //Avatar reset coordinates
    avatarReset1PosX = 192;
    avatarReset1PosY = 810;
    
    pencil=loadImage("obstacles/pencil.png");


    //*********// Obstacle 2 //*********//
    obs2WaveDuration = 1.5;
    obs2PauseLength = 1.5;
    obs2Width=50;
    obs2Height=50;
    obs2StartingPosX = 1260; 
    obs2StartingPosY = 775;
    obs2CurrentPosX = obs2StartingPosX;
    obs2CurrentPosY = obs2StartingPosY;
    soundWaveScale = 1;
    obs2Opacity = 255;
    
    //Avatar reset coordinates
    avatarReset2PosX = 1200;
    avatarReset2PosY = 880;
    
    soundwaves = loadImage("obstacles/soundwaves.png");
}

void draw() {


    //shape of the path
    image(below, 0, 0);

    //************************************************************//
    //*************// Check the Avatar Positioning //*************//
    //************************************************************//

    //if the below is white then it resets the ball
    if (avatarSelected==true) {
        
        if (get(mouseX, mouseY) == color(255, 255, 255)) {
            println("BAD!");
            avatarSelected = false;
        }

         //Check which color is under the mouse cursor, and what zones that corresponds to
        for ( int i = 0; i < numberOfZones; i++) {
            if (get(mouseX, mouseY) == zoneColorCodes[i]) {
                currentZone = i;
                println("User is in area #" + i);
            }
        }
    }
            

    //Unlock the next skill if you've entered a zone you haven't been in yet
    if (skillsUnlocked < currentZone - 1 && skillsUnlocked < numberOfSkills && showIconAtAvatar == 0) {
        int skillsSoonUnlocked = skillsUnlocked + 1;
        lastUnlockedSkill  = constrain(skillsSoonUnlocked - 1, 0, numberOfSkills - 1);
        showIconAtAvatar = 1;
        activationPosX = avatarCurrentPosX;
        activationPosY = avatarCurrentPosY;
        iconTimerSaved = millis();
    }

    //************************************************************//
    //************// Check if the Avatar is being Occluded  //************//
    //************************************************************//

    //Draw occluding testing layer
    image(occludingLayer, 0, 0);

    //Test if then avatar is being occluded
    if (get(avatarCurrentPosX, avatarCurrentPosY-10) == color(175, 25, 175)) {
        outlineTimer+= 0.02;
        outlineTimer=constrain(outlineTimer, 0, 0.5);
    } else {
        outlineTimer-= 0.02;   
        outlineTimer=constrain(outlineTimer, 0, 0.5);
    }
    
    //************************************************************//
    //************// Draw the main background image //************//
    //************************************************************//
    image(ontop, 0, 0);


    //****************************************************************//
    //************// Draw the text for the current zone //************//
    //****************************************************************//
    
    pushMatrix();

        rotateX(0.3);  //Rotate it in 3D space. Cool!
        fill(zoneFontColor);
        textFont(zoneTextFont, zoneTitleFontSize);
    
        if (avatarActivated == false) { 
            text(zoneTextTable.getString(numberOfZones-1, 0), 450, 300, 475, 500);
            textFont(zoneTextFont, zoneTextFontSize);
            text(zoneTextTable.getString(numberOfZones-1, 1), 450, 340, 475, 500);
        } else {
            text(zoneTextTable.getString(currentZone, 0), 450, 300, 475, 500);
            textFont(zoneTextFont, zoneTextFontSize);
            text(zoneTextTable.getString(currentZone, 1), 450, 340, 475, 500);
        }
    popMatrix();

    //*****************************************************//
    //****************// Draw the Avatar //****************//
    //*****************************************************//

    //Set the position of the avatar
    if (avatarSelected == true) {
        avatarCurrentPosX = mouseX;
        avatarCurrentPosY = mouseY;
    }

    directionTimer = (millis() - savedTime)/1000;

    if (hideAvatar != 1) {

        //Determine the direction the avatar should be facing, but only once every 1/10th of a second
        if (directionTimer > 0.1) {  
            if (mouseY < pmouseY && avatarCurrentPosX == mouseX && avatarCurrentPosY == mouseY) {
                direction=2;
            } else if (mouseY > pmouseY && avatarCurrentPosX == mouseX && avatarCurrentPosY == mouseY) {
                direction=0;
            } else if (mouseX < pmouseX && avatarCurrentPosX == mouseX && avatarCurrentPosY == mouseY) {
                direction=3;
            } else if (mouseX > pmouseX && avatarCurrentPosX == mouseX && avatarCurrentPosY == mouseY) {
                direction=1;
            }      
            //Reset the timer
            savedTime = millis();
        }

        //Draw the Avatar
        imageMode(CENTER);
        image(avatarImages[direction], avatarCurrentPosX, avatarCurrentPosY, avatarSizeX, avatarSizeX);
        imageMode(CORNER);

        
    }



    //****************// Obstacle 1 //*****************************//

    pencil.resize(int(obs1Width), int(obs1Height));
    image(pencil, obs1PosX, obs1PosY);

    obs1PosX=obs1PathPosX+sin(radians(millis())/5)*90; 


    if (avatarCurrentPosX >= obs1PosX - avatarCollisionBoxX/2 && avatarCurrentPosX <= obs1PosX + obs1Width + avatarCollisionBoxX/2 && avatarCurrentPosY + avatarCollisionBoxY/2 >= obs1PosY && avatarCurrentPosY - avatarCollisionBoxY/2 <= obs1PosY + obs1Height) {
        avatarSelected=false;
        avatarCurrentPosX = avatarReset1PosX;
        avatarCurrentPosY = avatarReset1PosY;
        println("hit");
    }

    //****************// Obstacle 2 //*****************************//

    pushMatrix();
    
        obs2Timer = (millis() - obs2TimerSaved)/1000;
        translate(obs2CurrentPosX, obs2CurrentPosY);
        rotate(radians(45));
        translate(-obs2CurrentPosX, -obs2CurrentPosY);
    
        if (obs2Timer > obs2PauseLength/2 && obs2Timer < obs2WaveDuration + obs2PauseLength/2) {
            
            //Draw the sound wave, and use the obs2WaveDuration to control how fast the wave animated
            tint(255, obs2Opacity);
            image(soundwaves, obs2CurrentPosX, obs2CurrentPosY, obs2Width*soundWaveScale, obs2Height*soundWaveScale);
            noTint();
            obs2Opacity -= 4.5/obs2WaveDuration;
            obs2CurrentPosX += 1.8/obs2WaveDuration;
            obs2CurrentPosY += 0.5/obs2WaveDuration;
            soundWaveScale += 0.03/obs2WaveDuration;
            
            //Check for collision
            //Holy shit that's a long "if". Basically check to see if the avatar is within a box, that roughly corresponds to the sound wave, at a certain time.
            if ( avatarCurrentPosX >= obs2StartingPosX + 10 && avatarCurrentPosX <= obs2StartingPosX + 120 && avatarCurrentPosY <= obs2StartingPosY + 200 && avatarCurrentPosY >= obs2StartingPosY + 40 && obs2Timer < obs2WaveDuration*0.75 + obs2PauseLength/2 && obs2Timer > obs2WaveDuration*0.15 + obs2PauseLength/2) {
            avatarSelected=false;
            avatarCurrentPosX = avatarReset2PosX;
            avatarCurrentPosY = avatarReset2PosY;
            }
            
          //Reset the wave
        } else if (obs2Timer > obs2PauseLength/2 + obs2WaveDuration) {
            obs2TimerSaved = millis();
            soundWaveScale=1;
            obs2CurrentPosX = obs2StartingPosX;
            obs2CurrentPosY = obs2StartingPosY;
            obs2Opacity = 255;
        }

    popMatrix();

    //****************// Draw the Skillbook //********************//

    //Draw the book itself
    image(skillBook, skillBookPosX, skillBookPosY);

    //Draw the "Skills" headline
    textFont(fontRoboto, 32);
    fill(0, 0, 0);
    text("Skills", skillBookPosX + 45, skillBookPosY + 50);

    //Draw the shape that shows which skills is being described on the right page
    fill(0, 0, 0, 125);
    stroke(0, 150);
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
            fill(255, 255, 255, 235);
        } else { 
            fill(35, 35, 35, 200);
        }

        tint(255, 195);
        image(skillIconsNotActive[i], skillIconPosX[i], skillIconPosY[i], iconSize, iconSize);
        text(skillDataTable.getString(i, "Skill Names"), skillIconPosX[i] + 25, skillIconPosY[i] + 16);
        noTint();
    } 

    //Draw the icons and text for the active skills
    for (int i = 0; i < skillsUnlocked; i++) {

        //If the skill is the one being described right now, make the text white. If not make it black.
        if (i == skillDescrActive) {
            fill(255, 255, 255, 255);
        } else { 
            fill(0, 0, 0, 255);
        }

        image(skillIconsActive[i], skillIconPosX[i], skillIconPosY[i], iconSize, iconSize);
        text(skillDataTable.getString(i, "Skill Names"), skillIconPosX[i] + 25, skillIconPosY[i] + 16);
    } 


    //Draw the Skill Description
    fill(255, 255, 255, 255);
    textFont(fontRoboto, 15);
    text(skillDataTable.getString(skillDescrActive, "Skill Description"), skillBookPosX + 247, skillIconPosY[0], 183, 300);

    //Draw the drawings, lol
    tint(255, 220);
    image(bookDrawing01, skillBookPosX + 30, skillBookPosY + 215);
    //image(bookDrawing02, skillBookPosX + 240, skillBookPosY + 225);
    noTint();

    iconTimer = (millis() - iconTimerSaved)/1000;
    
  
    //****************// Draw the top most BG layer //****************//

    image(verytop, 0, 0);


    //***********************************************************************************//
    //****************// Draw the icon of the skill recently acquired //****************//
    //***********************************************************************************//
    
    if (showIconAtAvatar == 1 && iconTimer <= iconAnimDuration) {
        
        //Calculate the coordinates of the bezier curved used for animating the icon
        bezierX1 = activationPosX;
        bezierY1 = activationPosY;
        bezierX2 = skillIconPosX[lastUnlockedSkill];
        bezierY2 = skillIconPosY[lastUnlockedSkill];
        bezierXC1 = activationPosX;
        bezierYC1 = activationPosY - 400;
        bezierXC2 = skillIconPosX[lastUnlockedSkill];
        bezierYC2 = skillIconPosY[lastUnlockedSkill] - 125;
        
        //Draw bezier that will be used for animating the skill icon
        noFill();
        noStroke();
        bezierDetail(60);
        bezier(bezierX1, bezierY1, bezierXC1, bezierYC1, bezierXC2, bezierYC2, bezierX2, bezierY2);


        //Calculate the position on the bezier curve this frame
        iconAnimPctDone = 1/iconAnimDuration*iconTimer;
        iconAnimScale = 2 - 2*abs(0.5 - iconAnimPctDone);
        animSkillIconPosX = int(bezierPoint(bezierX1, bezierXC1, bezierXC2, bezierX2, iconAnimPctDone));
        animSkillIconPosY = int(bezierPoint(bezierY1, bezierYC1, bezierYC2, bezierY2, iconAnimPctDone));
        
        //Draw the icon at the position
        image(skillIconsActive[lastUnlockedSkill], animSkillIconPosX, animSkillIconPosY, iconSize*iconAnimScale, iconSize*iconAnimScale);
        
        
        int fadeIn = 255;

        //if (iconTimer < iconAnimDuration*0.25) {
        //    fadeIn = int(255*(1/iconAnimDuration*iconTimer*0.25));
        //} else if (iconTimer > iconAnimDuration*0.75) {
        //    fadeIn = int(255*(1/iconAnimDuration*iconTimer*0.25));
        //}

        tint(255,fadeIn);
        fill(0, 0, 0, 145);
        stroke(0, 200);
        rect(avatarCurrentPosX + 20, avatarCurrentPosY, 80, 27);
        textFont(fontRoboto, 18);
        fill(255, 255, 255, fadeIn);
        text("+1 Skill", avatarCurrentPosX + 30, avatarCurrentPosY + 20);
        noTint();
        
    } else if (showIconAtAvatar == 1 && iconTimer > iconAnimDuration) {
        showIconAtAvatar = 0;
        skillsUnlocked++;
        skillDescrActive = lastUnlockedSkill;
    }



    //***************// Draw the title of the damn game! //******************//

    //textFont(fontKeepCalm, 48);
    //fill(220,70,46, 210);
    //1text("Journey of Medialogy", 85, 170);
    titleImage.resize(650, 0);
    image(titleImage, 70, 120);


    //***************// Draw the Avatar Outline //******************//
    imageMode(CENTER);
    tint(255, 255*outlineTimer*2);
    image(avatarImages[direction + 4], avatarCurrentPosX, avatarCurrentPosY, avatarSizeX, avatarSizeY);
    imageMode(CORNER);
    noTint();


    //***************// End of Game Stuff //******************//

    //Wins the game ... change mouseX to avatarCurrentPosX!!!!!!!
    if (avatarCurrentPosX > 1358) { 

        hideAvatar = 1;

        direction=1;
        if (score==0) {
            confetti=1;
            score=(millis()-time)/50;
            countdown=millis();
        }



        fill(0, 0, 0, 100);
        rect(0, 0, width, height);


        //CONFETTI - should maybe be deleted?!
        if (confetti>0) {
            noStroke();

            int linespace=1;
            for (int i = 1; i < confetti; i = i+15) {
                linespace++;
                for (int j = 0; j < 1400; j = j+15) {
                    fill(255, 0, 0);
                    rect((linespace*20)+j, 20+i, 10, 10);
                }
                if (linespace>1)
                    linespace=0;
            }
        }
        confetti++;
        //You won text!
        textAlign(CENTER);
        textSize(40);
        fill(255, 255, 255);
        text("CONGRATULATIONS!", width/2, height/2); 
        textSize(20);
        text("You have succesfully navigated Medialogy and completed with a score of "+score, width/2, height/2+40);
        textAlign(LEFT);
        if (millis()-countdown > 5000) {
            //Reset
            //resetting all the variables to the beginning ones
            avatarCurrentPosX = avatarStartingPosX;
            avatarCurrentPosY = avatarStartingPosY;
            direction=2;
            score=0;
            avatarSelected=false;
            currentZone=0;
            skillsUnlocked = 0;
            skillDescrActive = 0;
            hideAvatar = 0;
        }
    }
}

//This checks if the mouse is dragging the ball. When mouse is released avatarSelected is zeroed.

void mouseDragged() {

    //If the mouse is within the bounding box of the avatar, while mousebutton is held down, the avatar is selected, and can be dragged
    if (mouseX > avatarCurrentPosX - avatarSizeX/2 && mouseX < avatarCurrentPosX + avatarSizeX/2 && mouseY > avatarCurrentPosY - avatarSizeX/2 && mouseY < avatarCurrentPosY + avatarSizeX/2) {
        avatarSelected = true;
    }
}

void mouseReleased() {

    //The avatar is no longer selected
    avatarSelected=false;
}


void mouseClicked() {


    //Check if one of the skills is clicked on
    for (int i = 0; i < numberOfSkills; i++) {

        //If the mouse is within the bounds of skill number "i", that should be set as the active skill description
        if (mouseX > skillIconPosX[i] && mouseX < skillIconPosX[i] + 160 && mouseY > skillIconPosY[i] && mouseY < skillIconPosY[i] + iconSize) {
            skillDescrActive = i;
        }
    } 

    if (avatarActivated == false) {
        if (mouseX > avatarCurrentPosX - avatarSizeX/2 && mouseX < avatarCurrentPosX + avatarSizeX/2 && mouseY > avatarCurrentPosY - avatarSizeX/2 && mouseY < avatarCurrentPosY + avatarSizeX/2) {
            avatarActivated = true;
        }
    }
}



//DESIRED EXTRAS

//obstacles(depends on the time)
//draw obstacles
//animate obstacles