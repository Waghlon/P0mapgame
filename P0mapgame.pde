/*
###########################################
 P0 project - Map game
 Revision: 21
 Date: 22/09/2016
 By: group 13
 Rules for good coding
 1) Make sure to regularly comment your code
 2) Before you edit any section, make sure to talk to Lars and/or whoever is near you first.
 3) Whenever you commit, update the revision number (just add one), date and name
 4) Please compile and test your code at least once, before committing it.
 5) Please be careful to use proper indentation
 6) Clearly mark different parts of the code
 
Revision 21 notes
Arrows on the start screen implemented
 
 ###########################################
 */

//*******************************************//
//*********// Declaring Variables //*********//
//*******************************************//  

//************ Game State Variables *************//
int gameState;    //0 = Black Screen, 1 = Black Screen -> Splash Screen, 2 = Splash Screen, 3 = Splash Screen - > Game, 4 = Game is running, 5 = End of Game Screen, 6 = Game -> Black, 7 = Game over man, game over! What the fuck are we gonna do now? 
float gameStateTimer, gameStateTimerSaved;
float blackToSplashDuration, splashToGameDuration, finishScreenDuration, finishToBlackDuration, endBlackScreenDuration;

//************ Lock Screen Variables *************//
PImage lockScreenBG, boatMan, boatManColorCode, unlockArrowImage;
float boatManPosX, boatManPosY, boatManStartPosX, boatManStartPosY, splashFader;
boolean boatManUnderMouse, boatManSelected;
float arrowAnimTimer, arrowAnimTimerSavedr, arrowAnimCycle;
int numberOfArrows, arrowStartPosX, arrowEndPosX, arrowTravelLength;
int[] arrowPosX;
float[] arrowOpacity;

//************ Avatar Variables *************//
int avatarSizeX, avatarSizeY, avatarCollisionBoxX, avatarCollisionBoxY, currentZone, direction, hideAvatar, showIconAtAvatar, lastUnlockedSkill;    //avatarCurrentPosX and avatarCurrentPosY represent characters coordinates, currentZone variable to determine which zone you are in 
int avatarCurrentPosX, avatarCurrentPosY, avatarStartingPosX, avatarStartingPosY, avatarReset1PosX, avatarReset1PosY, avatarReset2PosX, avatarReset2PosY;
boolean avatarSelected, avatarActivated;                        //avatarSelected to determine whether the character is being dragged
PImage below, ontop, verytop, occludingLayer;                //images for below layer used to detect zones, and ontop and verytop for graphics
PImage[] avatarImages;
float directionTimer, directionTimerSaved, iconTimer, iconTimerSaved, outlineTimer;

//************ Zone Variables *************//
int zoneTitleFontSize, zoneTextFontSize, numberOfZones;
Table zoneTextTable;
PFont zoneTextFont;
PImage[] zoneImages;
color zoneFontColor;
color[] zoneColorCodes;

//************ Skillbook Variables *************//
int skillBookPosX, skillBookPosY, numberOfSkills, skillsUnlocked, iconSize, bookFontSize, spaceBetweenSkills, skillDescrActive;
int[] skillIconPosX, skillIconPosY;
PImage skillBook, skillTitleBg;
PImage[] skillIconsActive, skillIconsNotActive, skillSketches;
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
    smooth(4);
    //frameRate(240);
    hint(DISABLE_DEPTH_TEST);                            //Removed problems with overlapping text and images
    fontKeepCalm = loadFont("fonts/keepCalm.vlw");
    fontRoboto = loadFont("fonts/roboto.vlw");
    fontArchitect = loadFont("fonts/architect.vlw");
    fontIgiari = loadFont("fonts/igiari.vlw");


    //*********// Game State Setup //*********//
    blackToSplashDuration = 1;
    splashToGameDuration = 1;
    finishScreenDuration = 4;
    finishToBlackDuration = 2;
    endBlackScreenDuration = 2;
    
    gameState = 0;
    //gameStateTimerSaved = millis();
    //gameStateTimer = 0;


    //*********// Lock Screen Setup //*********//
    lockScreenBG = loadImage("lockscreen/lockScreenBG.png");
    boatMan = loadImage("lockscreen/boatMan.png");
    boatManColorCode = loadImage("lockscreen/boatManColorCode.png");
    unlockArrowImage = loadImage("lockscreen/arrow.png");

    boatManStartPosX = 25;
    boatManStartPosY = 450;
    boatManPosX = boatManStartPosX;
    boatManPosY = boatManStartPosY;
    
    arrowAnimCycle = 10;
    numberOfArrows = 8;
    arrowStartPosX = 500;
    arrowTravelLength = numberOfArrows*75;
    arrowEndPosX = arrowStartPosX + arrowTravelLength;
    arrowTravelLength = arrowEndPosX - arrowStartPosX;
    arrowPosX = new int[numberOfArrows];
    arrowOpacity = new float[numberOfArrows];
    
    //Set up the initial position and opacity of all the arrows
    for ( int i = 0; i < numberOfArrows; i++) {
        arrowPosX[i] = arrowStartPosX + 75*i;
        
        if ( arrowPosX[i] < arrowStartPosX + arrowTravelLength/2 ) { 
            arrowOpacity[i] = constrain(2*(arrowPosX[i] - arrowStartPosX), 0, 255);
        } else {
            arrowOpacity[i] = constrain(2*(arrowEndPosX - arrowPosX[i]), 0, 255);
        }
    }
    
    //Set up the initial opacity of all the arrows
    for ( int i = 0; i < numberOfArrows; i++) {
        arrowOpacity[i] = constrain((arrowPosX[i] - arrowStartPosX), 0, 255);
    }


    //*********// Avatar Variables //*********//
    avatarSizeX = 35;
    avatarSizeY = 35;
    avatarCollisionBoxX = 16;
    avatarCollisionBoxY = 22;
    avatarStartingPosX = 80;
    avatarStartingPosY = 870;
    avatarCurrentPosX = avatarStartingPosX;
    avatarCurrentPosY = avatarStartingPosY;
    direction=2;
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
    zoneImages = new PImage[numberOfZones];

    //Load in zone images
    for ( int i = 0; i < numberOfZones; i++) {
        zoneImages[i] = loadImage("photos/zoneImage" + i + ".png");
    }

    //Assign the zones a color code
    for ( int i = 0; i < numberOfZones; i++) {
        zoneColorCodes[i] = color(15*(i + 1), 15*(i + 1), 15*(i + 1));
    }

    //Font Settings
    zoneFontColor = color(25, 25, 25, 225);
    zoneTextFont = fontRoboto;  //fontArchitect;
    zoneTitleFontSize = 26;
    zoneTextFontSize = 20;

    //Turn the underscores in the string file into /n, which equals line breaks when drawin the text. Putting the \n directly into the table didn't work for some reason.
    for (int i = 0; i < numberOfZones; i++) {
        //load in the string from each row, replace the underscores with /n, then put it back into the table with setString
        String string1WithoutSpaces = zoneTextTable.getString(i, 1).replaceAll("_", "\n");
        zoneTextTable.setString(i, 1, string1WithoutSpaces);
        String string2WithoutSpaces = zoneTextTable.getString(i, 2).replaceAll("_", "\n");
        zoneTextTable.setString(i, 2, string2WithoutSpaces);
    }


    //*********// Skill Book Setup //***********//  
    skillBook = loadImage("skillbook/skillbookImage.png");
    skillBook.resize(450, 0);
    skillBookPosX = 960;
    skillBookPosY = 10;  
    skillTitleBg = loadImage("bar.png");

    //Load in the Skill text strings
    skillDataTable = loadTable("strings/skillData.txt", "header, tsv");
    numberOfSkills = skillDataTable.getRowCount();
    skillIconPosX = new int[numberOfSkills];
    skillIconPosY = new int[numberOfSkills];
    skillIconsActive = new PImage[numberOfSkills];
    skillIconsNotActive = new PImage[numberOfSkills];
    iconSize = 24;
    spaceBetweenSkills = 32;
    bookFontSize = 19;  

    //Turn the underscores in the string file into /n, which equals line breaks when drawin the text. Putting the \n directly into the table didn't work for some reason.
    for (int i = 0; i < numberOfSkills; i++) {
        //load in the string from each row, replace the underscores with /n, put it back into the table
        String stringWithoutSpaces = skillDataTable.getString(i, 1).replaceAll("_", "\n");
        skillDataTable.setString(i, 1, stringWithoutSpaces);
    }

    //Determine the position of the icons. We calculate and store these valules in an array, because we'll be using them several times
    for (int i = 0; i < numberOfSkills; i++) {
        skillIconPosX[i] = skillBookPosX + 52;
        skillIconPosY[i] = skillBookPosY + 75 + spaceBetweenSkills*i;
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

    //Load in the sketches for each skill
    skillSketches = new PImage[numberOfSkills];
    for (int i = 0; i < numberOfSkills; i++) {
        skillSketches[i] = loadImage("skillbook/sketches/" + skillDataTable.getString(i, "Skill Names").replaceAll(" ", "") +".png");
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
    obs2StartingPosX = 1240; 
    obs2StartingPosY = 790;
    obs2CurrentPosX = obs2StartingPosX;
    obs2CurrentPosY = obs2StartingPosY;
    soundWaveScale = 0.25;
    obs2Opacity = 255;

    //Avatar reset coordinates
    avatarReset2PosX = 1200;
    avatarReset2PosY = 880;

    soundwaves = loadImage("obstacles/soundwaves.png");



    println("Done with setup");
}


//*********************************************************************************//
//*******************************// Start Drawing //*******************************//
//*********************************************************************************//


void draw() {

    //************************************************************//
    //*************// Keep track of the game state //*************//
    //************************************************************//   


    gameStateTimer = (millis() - gameStateTimerSaved)/1000;

    if (gameState == 0 && gameStateTimer > 2) {
        gameState = 1;
        gameStateTimerSaved = millis();
        gameStateTimer = 0;
        println("Do Transition");
    } else if (gameState == 1 && gameStateTimer > blackToSplashDuration) {
        gameState = 2;
        gameStateTimerSaved = millis();
        gameStateTimer = 0;
        println("Transition Done");
    } else if (gameState == 2 && boatManPosX > 700) {
        gameState = 3;
        boatManSelected = false;
        println("time to unlock bitch");
        gameStateTimerSaved = millis();
        gameStateTimer = 0;
    } else if (gameState == 3 && gameStateTimer > splashToGameDuration) {
        gameState = 4;
        println("game fully unlocked bitch");
        gameStateTimerSaved = millis();
        gameStateTimer = 0;
    } else if (gameState == 4 && avatarCurrentPosX > 1365) {
        gameState = 5;
        hideAvatar = 1;
        println("You have finished the game");
        score=millis()/50;
        gameStateTimerSaved = millis();
        gameStateTimer = 0;
    } else if (gameState == 5 && gameStateTimer > finishScreenDuration ) {
        gameState = 6;
        println("game is shutting down");
        gameStateTimerSaved = millis();
        gameStateTimer = 0;
    } else if (gameState == 6 && gameStateTimer > finishToBlackDuration) {
        gameState = 7;
        println("game is about to reset");
        gameStateTimerSaved = millis();
        gameStateTimer = 0;
    } else if (gameState == 7 && gameStateTimer > endBlackScreenDuration) {
        avatarCurrentPosX = avatarStartingPosX;
        avatarCurrentPosY = avatarStartingPosY;
        direction=2;
        score=0;
        avatarSelected=false;
        currentZone=0;
        skillsUnlocked = 0;
        skillDescrActive = 0;
        hideAvatar = 0;
        boatManPosX = boatManStartPosX;
        boatManPosY = boatManStartPosY;
        println("game has reset");
        gameState = 0;                            //The final reset switch
    }

    //************************************************************//
    //***********************// Lock Screen //********************//
    //************************************************************//       

    if (gameState == 0) {
        background(0, 0, 0);
    }
    
    if (gameState >= 1 && gameState < 4) {        //The game is on the lock screen
        
        //Draw the color code image, used to check if the mouse is over the boat man
        image(boatManColorCode, boatManPosX, boatManPosY, 600, 467);
        
        //Check if the mouse is over the boat man, so he can be selected
        if (get(mouseX, mouseY) == color(200, 50, 50)) {
            boatManUnderMouse = true;
        } else {
            boatManUnderMouse = false;
        }
    
        //Draw the background image for the lock screen
        image(lockScreenBG, 0, 0, width, height);
        
        //Draw the arrows
        pushMatrix();
            rotateX(0.4);
            
            //Draw arrow, update their position and opacity for the next frame
            for ( int i = 0; i < numberOfArrows; i++) {
                
                tint(255, arrowOpacity[i]);
                image(unlockArrowImage, arrowPosX[i], 695, 64, 64);
                noTint();
                arrowPosX[i] = arrowPosX[i] + 2;
                
                //Update opacity
                if ( arrowPosX[i] < arrowStartPosX + arrowTravelLength/2 ) { 
                    arrowOpacity[i] = constrain(2*(arrowPosX[i] - arrowStartPosX), 0, 255);
                } else {
                    arrowOpacity[i] = constrain(2*(arrowEndPosX - arrowPosX[i]), 0, 255);
                }
                
                //The arrows has reached the end, reset it
                if ( arrowPosX[i] > arrowEndPosX ) {
                    arrowPosX[i] = arrowStartPosX;
                    arrowOpacity[i] = 0;
                }
            }
    
        popMatrix();
    
        if (gameState == 1) {       
            image(boatMan, boatManPosX, boatManPosY, 600, 467);
            image(titleImage, 70, 120, 650, 86);
            color bgColor = color(0, 0, 0, 255*(1 - (gameStateTimer - 0.05)/blackToSplashDuration));
            fill(bgColor);
            rect(0, 0, width, height);
        } else if (gameState == 2) {        //We're on the lock screen, done with the transition
    
            if (boatManSelected == true) {
                boatManPosX = boatManPosX + mouseX - pmouseX;
                boatManPosX = constrain(boatManPosX, 25, 800);
            }
            
            image(boatMan, boatManPosX, boatManPosY, 600, 467);
            image(titleImage, 70, 120, 650, 86);

        }
    }


    //*********************************************************************************//
    //***********************// Start Drawing the Actual Game //***********************//
    //*********************************************************************************//

    if (gameState >= 3 && gameState <= 6) {

        //Draw the path
        image(below, 0, 0);

        //************************************************************//
        //*************// Check the Avatar Positioning //*************//
        //************************************************************//

        
        if (avatarSelected == true) {
            
            color colorUnderMouse = get(mouseX, mouseY);

            //If the below is white then user loses control of the avatar. Otherwise, check which color is under the mouse cursor, and what zones that corresponds to.
            if (colorUnderMouse == color(255, 255, 255)) {
                avatarSelected = false;
            } else {

                for ( int i = 0; i < numberOfZones; i++) {
                    if (get(mouseX, mouseY) == zoneColorCodes[i]) {
                        currentZone = i;
                    }
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

        //Test if avatar is being occluded
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
    
            //Draw the title of the Zone
            text(zoneTextTable.getString(currentZone, 0), 450, 300, 475, 500);
            textFont(zoneTextFont, zoneTextFontSize);
    
            //Draw the zone text in two textboxes.
            text(zoneTextTable.getString(currentZone, "Text String 1"), 450, 340, 460, 120);
            text(zoneTextTable.getString(currentZone, "Text String 2"), 450, 465, 275, 250);
    
            //Draw the image in the bottom right quadrant
            image(zoneImages[currentZone], 725, 460, 180, 140);

        popMatrix();

        //*****************************************************//
        //****************// Draw the Avatar //****************//
        //*****************************************************//

        if (hideAvatar != 1) {
            
            //Set the position of the avatar
            if (avatarSelected == true) {
                avatarCurrentPosX = mouseX;
                avatarCurrentPosY = mouseY;
            }

            directionTimer = (millis() - directionTimerSaved)/1000;

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
                directionTimerSaved = millis();
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
        }

        //****************// Obstacle 2 //*****************************//


        obs2Timer = (millis() - obs2TimerSaved)/1000;


        if (obs2Timer > obs2PauseLength/2 && obs2Timer < obs2WaveDuration + obs2PauseLength/2) {

            //Draw the sound wave, and use the obs2WaveDuration to control how fast the wave animated
            tint(255, obs2Opacity);
            image(soundwaves, obs2CurrentPosX, obs2CurrentPosY, obs2Width*soundWaveScale, obs2Height*soundWaveScale);
            noTint();
            
            float waveAnimPct = (obs2Timer - obs2PauseLength/2)/obs2WaveDuration;
            obs2Opacity = lerp(0, 255, 1 - waveAnimPct); 
            obs2CurrentPosX = lerp(obs2StartingPosX, obs2StartingPosX + 50, waveAnimPct); 
            obs2CurrentPosY = lerp(obs2StartingPosY, obs2StartingPosY + 50, waveAnimPct); 
            soundWaveScale = lerp (0.25, 2, waveAnimPct); 

            //Check for collision
            //Holy shit that's a long "if". Basically check to see if the avatar is within a box, that roughly corresponds to the sound wave, at a certain time.
            if ( avatarCurrentPosX >= obs2StartingPosX + 20 && avatarCurrentPosX <= obs2StartingPosX + 110 && avatarCurrentPosY <= obs2StartingPosY + 200 && avatarCurrentPosY >= obs2StartingPosY + 40 && obs2Timer < obs2WaveDuration*0.75 + obs2PauseLength/2 && obs2Timer > obs2WaveDuration*0.15 + obs2PauseLength/2) {
                avatarSelected=false;
                avatarCurrentPosX = avatarReset2PosX;
                avatarCurrentPosY = avatarReset2PosY;
            }

            //Reset the wave
        } else if (obs2Timer > obs2PauseLength/2 + obs2WaveDuration) {
            obs2TimerSaved = millis();
            soundWaveScale = 0.25;
            obs2CurrentPosX = obs2StartingPosX;
            obs2CurrentPosY = obs2StartingPosY;
            obs2Opacity = 255;
        }



        //****************// Draw the Skillbook //********************//

        //Draw the book itself
        image(skillBook, skillBookPosX, skillBookPosY);

        //Draw the "Skills" headline
        textFont(fontRoboto, 32);
        fill(0, 0, 0);
        text("Skills", skillBookPosX + 45, skillBookPosY + 50);

        //Get ready for drawing the skills
        textFont(fontRoboto, bookFontSize);
        
        //Set up positioning
        imageMode(CENTER);
        rectMode(CENTER);
        textAlign(LEFT, CENTER);
        
        //Draw the image that highlights active skill description
        image(skillTitleBg, skillIconPosX[skillDescrActive] + 98, skillIconPosY[skillDescrActive], 240, iconSize + iconSize*0.8);


        //Draw the Skill Icons and titles
        for (int i = 0; i < numberOfSkills; i++) {

            //If the skill is the one being described right now, make the text white. If not make it black.
            if (i == skillDescrActive) {
                fill(255, 255, 255, 255);
            } else { 
                fill(0, 0, 0, 255);
            }

            //If i is higher than the number of skills unlocked, it is not unlocked yet, and the inactive icon is displayed
            if (i >= skillsUnlocked) {
                tint(255, 195);
                image(skillIconsNotActive[i], skillIconPosX[i], skillIconPosY[i], iconSize, iconSize);
                text(skillDataTable.getString(i, "Skill Names"), skillIconPosX[i] + 115, skillIconPosY[i], 200, iconSize);
                noTint();
            } else {    //Otherwise, it's unlocked, draw active icon
                image(skillIconsActive[i], skillIconPosX[i], skillIconPosY[i], iconSize, iconSize);
                text(skillDataTable.getString(i, "Skill Names"), skillIconPosX[i] + 115, skillIconPosY[i], 200, iconSize);
            }
            
        }
        
        //Reset positioning settings
        imageMode(CORNER);
        rectMode(CORNER);
        textAlign(LEFT, BASELINE);


        //Draw the Skill Description
        fill(0, 0, 0, 255);
        textFont(fontRoboto, 16);
        text(skillDataTable.getString(skillDescrActive, "Skill Description"), skillBookPosX + 247, skillIconPosY[0] - 15, 183, 300);

        //Draw the sketches
        tint(255, 220);

        image(skillSketches[skillDescrActive], skillBookPosX + 250, skillBookPosY + 180, 160, 140);
        noTint();

        iconTimer = (millis() - iconTimerSaved)/1000;


        //******************************************************************//
        //****************// Draw the top most layers //*****************//
        //*****************************************************************//
        
        //Draw the top backdrop, that occludes the avatar
        image(verytop, 0, 0);


        //Draw the game title
        if (gameState > 3) {
            image(titleImage, 70, 120, 650, 86);
        }


        //***********************************************************************************//
        //****************// Draw the icon of the skill recently acquired //*****************//
        //***********************************************************************************//

        if (showIconAtAvatar == 1 && iconTimer <= iconAnimDuration) {

            //Calculate the coordinates of the bezier curved used for animating the icon
            bezierX1 = activationPosX;
            bezierY1 = activationPosY;
            bezierX2 = skillIconPosX[lastUnlockedSkill];
            bezierY2 = skillIconPosY[lastUnlockedSkill];
            bezierXC1 = activationPosX;
            bezierYC1 = activationPosY - 300;
            bezierXC2 = skillIconPosX[lastUnlockedSkill];
            bezierYC2 = skillIconPosY[lastUnlockedSkill] - 100;

            //Draw bezier that will be used for animating the skill icon
            noFill();
            noStroke();
            bezierDetail(60);
            bezier(bezierX1, bezierY1, bezierXC1, bezierYC1, bezierXC2, bezierYC2, bezierX2, bezierY2);


            //Calculate the position on the bezier curve this frame
            iconAnimPctDone = 1/iconAnimDuration*iconTimer;
            iconAnimScale = 4 - 6*abs(0.5 - iconAnimPctDone);
            animSkillIconPosX = int(bezierPoint(bezierX1, bezierXC1, bezierXC2, bezierX2, iconAnimPctDone));
            animSkillIconPosY = int(bezierPoint(bezierY1, bezierYC1, bezierYC2, bezierY2, iconAnimPctDone));

            //Draw the icon at the position
            imageMode(CENTER);
            image(skillIconsActive[lastUnlockedSkill], animSkillIconPosX, animSkillIconPosY, iconSize*iconAnimScale, iconSize*iconAnimScale);
            imageMode(CORNER);


            int fadeIn = 255;

            //if (iconTimer < iconAnimDuration*0.25) {
            //    fadeIn = int(255*(1/iconAnimDuration*iconTimer*0.25));
            //} else if (iconTimer > iconAnimDuration*0.75) {
            //    fadeIn = int(255*(1/iconAnimDuration*iconTimer*0.25));
            //}

            tint(255, fadeIn);
            fill(0, 0, 0, 145);
            stroke(0, 200);
            rect(avatarCurrentPosX + 20, avatarCurrentPosY, 80, 27);
            textFont(fontRoboto, 18);
            fill(255, 255, 255, fadeIn);
            text("+1 Skill", avatarCurrentPosX + 30, avatarCurrentPosY + 20);
            noTint();
        } else if (showIconAtAvatar == 1 && iconTimer > iconAnimDuration) {
            showIconAtAvatar = 0;

            //Unlock the new skillm and switch to the description of it
            skillsUnlocked++;
            skillDescrActive = lastUnlockedSkill;
        }


        //***************// Draw the Avatar Outline //******************//
        imageMode(CENTER);
        tint(255, 255*outlineTimer*2);
        image(avatarImages[direction + 4], avatarCurrentPosX, avatarCurrentPosY, avatarSizeX, avatarSizeY);
        imageMode(CORNER);
        noTint();


        //***************// Draw other Game States //******************//

        if (gameState == 3) {                            // The game is transitioning from the splash screen to the map
        
            splashFader = 255*(1 - 1/splashToGameDuration*gameStateTimer);
            tint(255, splashFader);
            image(lockScreenBG, 0, 0, width, height);
            image(boatMan, boatManPosX, boatManPosY, 600, 467);
            noTint();
            image(titleImage, 70, 120, 650, 86);
            
        } else if (gameState >= 5) {                     // Draw the Finishing Screen, both in state 5, 6 and 7
        
            fill(0, 0, 0, 145);
            stroke(0, 200);
            rectMode(CENTER);
            rect(width/2, height/2, 750, 180);
            noStroke();
            rectMode(CORNER);
            //You won text!
            textAlign(CENTER);
            textSize(40);
            fill(255, 255, 255);
            text("CONGRATULATIONS!", width/2, height/2); 
            textSize(20);
            text("You have succesfully navigated Medialogy and completed with a score of "+score, width/2, height/2+40);
            textAlign(LEFT);

            //Now fade to black
            if (gameState == 6) {
                gameStateTimer = constrain(gameStateTimer, 0, finishToBlackDuration);
                float fadeOut = 255 - 255*(1 - 1/finishToBlackDuration*gameStateTimer);
                fill(0, 0, 0, fadeOut);
                rect(0, 0, width, height);
            } else if (gameState == 7) {        //Now just show black screen
                fill(0, 0, 0, 255);
                rect(0, 0, width, height);
            }
        }
    }
}


void mouseDragged() {

    if (gameState == 2) {

        //If then mouse is dragging, while it's over the boat man, he's selected, and can be moved
        if (boatManUnderMouse == true) {
            boatManSelected = true;
        }
    } else if (gameState >= 3) {
        //If the mouse is within the bounding box of the avatar, while mousebutton is held down, the avatar is selected, and can be dragged
        if (mouseX > avatarCurrentPosX - avatarSizeX/2 && mouseX < avatarCurrentPosX + avatarSizeX/2 && mouseY > avatarCurrentPosY - avatarSizeX/2 && mouseY < avatarCurrentPosY + avatarSizeX/2) {
            avatarSelected = true;
        }
    }
}

void mouseReleased() {

    //The avatar is no longer selected
    avatarSelected = false;
    boatManSelected = false;
}


void mouseClicked() {

    if (gameState == 4 || gameState == 5) {
        //Check if one of the skills is clicked on
        for (int i = 0; i < numberOfSkills; i++) {

            //If the mouse is within the bounds of skill number "i", that should be set as the active skill description
            if (mouseX > skillIconPosX[i] && mouseX < skillIconPosX[i] + 160 && mouseY > skillIconPosY[i] - iconSize/2 && mouseY < skillIconPosY[i] + iconSize/2) {
                skillDescrActive = i;
            }
        } 

        if (avatarActivated == false) {
            if (mouseX > avatarCurrentPosX - avatarSizeX/2 && mouseX < avatarCurrentPosX + avatarSizeX/2 && mouseY > avatarCurrentPosY - avatarSizeX/2 && mouseY < avatarCurrentPosY + avatarSizeX/2) {
                avatarActivated = true;
            }
        }
    }
}


//***************// End of Code //******************//