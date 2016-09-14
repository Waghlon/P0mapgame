/*
###########################################
P0 project - Map game

Revision: 2
Date: 14/09/2016
By: Lars


Rules for good coding
1) Make sure to regularily comment your code
2) Before you edit any section, make sure to talk to Lars and/or whoever is near you first.
3) Whenever you commit, update the revision number (just add one), date and name
4) Please compile and test your code at least once, before committing it.

###########################################
*/

//Below we initialize the variables and classes for the media.




void setup(){
  size(1086, 768); //closest approximation of A0. Works on all laptops
  frameRate(59); //standard screen refresh for most computer monitors. Might have to check again in case of other hardware
  background(255);
  //set drawing modes
  //load media
  //draw static graphics, ie. graphics that are ALWAYS on the same location
}

void draw(){
  
  /*
  I suggest a loop of functions that goes like this:
  
  player input and draw player
  check if the player is on the path
  move obstacles and draw obstacles
  check for collisions
  check for progress
  draw rest of the graphics
  
  
  */

  
}



  //DESIRED FUNCTIONALITY

    //player()
  //constantly check for input
  //move player and draw him at new location
  //save coordinates into variables, in case we need them elsewhere
  
    
    //path()
  //draw/initialize some way of making sure where the path is 
  //check if the player is on the path
  //if yes, do not, if no, reset his position elsewhere
  
  
    //obstacles()
  //draw obstacles
  //animate obstacles
  
  
    //collision()
  //constantly check for location for obsctacles and progress
  //code for respawning when you fail
  
   
   //progress()
 //check if the player has gone far enough to trigger more info or end of game 
 //if he has, draw info or similiar stuff
 //draw something about the skillset