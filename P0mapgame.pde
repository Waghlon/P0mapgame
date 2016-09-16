//<<<<<<< HEAD
/*
###########################################
//test by Juha hoping not to fuck it up
P0 project - Map game

Revision: 3
Date: 14/09/2016
By: Andreas


Rules for good coding
1) Make sure to regularily comment your code
2) Before you edit any section, make sure to talk to Lars and/or whoever is near you first.
3) Whenever you commit, update the revision number (just add one), date and name
4) Please compile and test your code at least once, before committing it.

Revision 3 notes
I added the prototype Niklas made and deleted the thing we don't need anymore
e.g. the Info zone (which needs to be a whole other code)

As it is now the avatar (ball) has a starting which it returns to if the line it is on isn't black
I don't think the program recognizes the colors of our poster, so having the poster between the road and the ball should be a problem
Right now the road is missing, but I think I will play a bit with making a new road

Test

3.7

Road in progress
###########################################
*/

//Below we initialize the variables and classes for the media.

int ballX = 100;
int ballY = 725;
int ballTester = 0;


void setup(){
  size(1086, 768); //closest approximation of A0. Works on all laptops
  frameRate(59); //standard screen refresh for most computer monitors. Might have to check again in case of other hardware

  //set drawing modes
  //load media
  //draw static graphics, ie. graphics that are ALWAYS on the same location
}

void draw(){
  background(255);
   
    //path()
  //draw/initialize some way of making sure where the path is 
  //check if the player is on the path
  //if yes, do not, if no, reset his position elsewhere
  
   strokeWeight(30);
   stroke(0,0,0);
line(100,725,150,700);
line(150,700,150,625);
line(150,625,80,580);
line(80,580,80,550);
line(80,550,100,550);
line(100,550,150,580);
line(150,580,150,500);
line(150,500,115,450);
line(115,450,90,430);
line(90,430,110,400);
line(110,400,150,400);
line(150,400,220,500);
line(220,500,220,600);
line(220,600,190,700);
line(190,700,230,700);
line(230,700,300,700);
line(300,700,375,575);
line(375,575,410,575);
//line(410,575,

  /*
  I suggest a loop of functions that goes like this:
  
  player input and draw player
  check if the player is on the path
  move obstacles and draw obstacles
  check for collisions
  check for progress
  draw rest of the graphics
  
  //ball that we must mess with
  */
      //player()
  //constantly check for input
  //move player and draw him at new location
  //save coordinates into variables, in case we need them elsewhere
  
strokeWeight(5);
noFill();
stroke(255,0,0);
ellipse(ballX,ballY,20,20);

//does the mouse hold the ball

if (mouseX > ballX-10 & mouseX < ballX+10 & mouseY < ballY+10 & mouseY > ballY-10){
  ballTester = 1;
}


//is the ball over the line?

if (get(ballX,ballY) != color(0,0,0)){
  println("BAD!");
  ballTester = 0;
  ballX=100;
  ballY=725;
}
else{
  println("good!");

}

//THIS SHOULD BE THE LAST THING THAT IS DONE!!!
if (ballTester == 1){
  ballX=mouseX;
  ballY=mouseY;
}
   
  
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
//=======