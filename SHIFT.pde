import java.awt.*;
//Variables
color green=color(31, 255, 203);
color white=color(255, 255, 255);
color black=color(0, 0, 0);
color coral=color(255, 111, 94);
color space=white;
color ground=black;
color play1=green;
color play2=coral;
color temp;

int X=100;
int Y=100;
int dx=0;
int dy=0;
int jumpCount=0;

boolean phase1=true;  //tells what phase the player is in: black or white
boolean key1Grabbed=false;    //true when key1 is grabbed              **key1 was coded first but is actually grabbed second when playing
boolean key2Grabbed=false;    //true when the key2 is grabbed
boolean dead=false;    //true if you touch the spikes, ends game
boolean win=false;    //true when you win the game
boolean jump=false;  //tells when the player is jumping

PImage key1;

Rectangle p1s1;  //areas where spikes are specific to which phase you are in
Rectangle p1s2;
Rectangle p2s1;
Rectangle p2s2;
Rectangle p1key1;
Rectangle p2key1;
Rectangle p1key2;
Rectangle p2key2;
Rectangle p1finish;
Rectangle p2finish;

void setup(){      //2 Mazes had to be drawn and created because the get() function does not account for translations and rotations
  background(255);
  size(1300, 1200);
  noStroke();
  frameRate(200);
  p1s1=new Rectangle(600, 800, 500, 100);  //phase1 spikes1
  p1s2=new Rectangle(700, 1100, 400, 100);  //phase1 spikes2
  p2s1=new Rectangle(200, 0, 400, 100);  //phase2 spikes1
  p2s2=new Rectangle(200, 300, 500, 100);  //phase2 spikes2
  p1key1=new Rectangle(1200, 600, 100, 100);  //phase1 key1
  p2key1=new Rectangle(0, 500, 100, 100);      //phase2 key1
  p1key2=new Rectangle(500, 1100, 100, 100);  //phase1 key2
  p2key2=new Rectangle(700, 0, 100, 100);      //phase2 key2
  p1finish=new Rectangle(1250, 1000, 50, 100);  //finish door
  p2finish=new Rectangle(0, 100, 50, 100);  //finish door
  key1=loadImage("key.jpg");                //key icon
}

void draw(){
  if(!dead){
    if(!win){
      if(phase1){
        maze1();
      }
      else{
        maze2();
      }
      // PLAYER DRAWN
      fill(play1);
      rect(X, Y, 50, 100);
      keyMove();
    }
    else{  //reached finish (won)
      background(green);
      fill(white);
      textSize(200);
      text("YOU WIN", 200, 600);
    }
  }
  else{      //Dead
    background(coral);
    fill(white);
    textSize(200);
    text("YOU LOSE", 150, 600);
  }
}

void keyReleased(){
  dx=0;
  if(keyCode==SHIFT){  //if shift was pressed, change phase/maze
    if(grounded()){
      phase1=!phase1;    
      temp=space;      //reverse ground and space colors
      space=ground;
      ground=temp;
      temp=play1;      //reverse player colors
      play1=play2;
      play2=temp;
      //CHANGE X AND Y COORDINATES
      X=1300-X-50;
      Y=1200-Y-200;
    }
  }
    keyCode=0;  //when key is released prevents continuous movement
}

void maze1(){  //Draws the background for phase1
  background(255);
  fill(0);
  //STATIC BLACK
  rect(0, 200, 200, 200);
  rect(100, 300, 200, 300);
  rect(0, 500, 100, 400);
  rect(400, 300, 400, 100);
  rect(900, 300, 100, 200);
  rect(1000, 200, 100, 500);
  rect(1100, 400, 100, 600);
  rect(1200, 500, 100, 500);
  rect(600, 900, 500, 100);
  rect(0, 1000, 500, 100);
  rect(500, 1100, 200, 100);
  rect(1100, 1100, 200, 100);
  //SPIKES
  for(int i=600; i<1100; i+=50){
    triangle(i, 900, i+25, 800, i+50, 900);
  }
  if(!key1Grabbed){  //if key1 not grabbed draw spikes, show key
    image(key1, 1200, 600);
    for(int i=700; i<1100; i+=50){
      triangle(i, 1200, i+25, 1100, i+50, 1200);
    }
  }
  else{  //key1 has been grabbed, cover spikes
    rect(700, 1100, 400, 100);
  }
  if(key2Grabbed){  //key2 grabbed black rectangle
    rect(0, 900, 300, 100);
  }
  else{    //key2 not grabbed show key image
    image(key1, 500, 1100);
    rect(900, 0, 200, 300);
  }
  if(!win){
    for(int i=Y; i<Y+100; i++){
      if(p1finish.contains(X+50, Y)){
        win=true;
      }
    }
    fill(200, 200, 255);
    rect(1250, 1000, 50, 100);
  }
}

void maze2(){  //Draws the background
  background(255);
  fill(0);
  //STATIC BLACK
  rect(1100, 800, 200, 200);
  rect(1000, 600, 200, 300);
  rect(1200, 300, 100, 400);
  rect(500, 900, 400, 100);
  rect(300, 700, 100, 200);
  rect(200, 500, 100, 500);
  rect(100, 200, 100, 600);
  rect(0, 200, 100, 500);
  rect(200, 200, 500, 100);
  rect(800, 100, 500, 100);
  rect(600, 0, 200, 100);
  rect(0, 0, 200, 100);
  //SPIKES
  for(int i=200; i<700; i+=50){
    triangle(i, 300, i+25, 400, i+50, 300);
  }
  if(!key1Grabbed){    //draw spikes and key
    image(key1, 0, 500);
    for(int i=200; i<600; i+=50){
      triangle(i, 0, i+25, 100, i+50, 0);
    }
  }
  else{    //cover spikes
    rect(200, 0, 400, 100);
  }
  if(key2Grabbed){  //remove blocked area and add new black area
    rect(1000, 200, 300, 100);
  }
  else{          //draw key and blocked area
    image(key1, 700, 0);
    rect(200, 900, 200, 300);
  }
  if(!win){    //check for win
    for(int i=Y; i<Y+100; i++){
      if(p2finish.contains(X+50, Y)){
        win=true;
      }
    }
    fill(200, 200, 255);
    rect(0, 100, 50, 100);
  }
}

void keyMove(){  //key input for player movement
  if(!key1Grabbed){    //check for key
    for(int i=X; i<X+50; i++){
      if(phase1){
        if(p1key1.contains(i, Y)){
          key1Grabbed=true;
        }
      }
      else{
        if(p2key1.contains(i, Y)){
          key1Grabbed=true;
        }
      }
    }
  }
   if(!key2Grabbed){    //check for key
    for(int i=X; i<X+50; i++){
      if(phase1){
        if(p1key2.contains(i, Y)){
          key2Grabbed=true;
        }
      }
      else{  //phase2
        if(p2key2.contains(i, Y)){
          key2Grabbed=true;
        }
      }
    }
  }
  if(!jump){
    dy=1;
    //if there is white space below then you are falling
    for(int i=X; i<X+50;i++){
      if (get(i, Y+100)!=space){  //if there is something below you
        dy=0;  //not falling
        if(phase1){  //check phase 1 spikes
          if(p1s1.contains(i, Y+100)){
            dead=true;
          }
          if(!key1Grabbed){
            if(p1s2.contains(i, Y+100)){
              dead=true;
            }
          }
        }
        else{  //check phase 2 spikes
          if(p2s1.contains(i, Y+100)||p2s2.contains(i, Y+100)){
            dead=true;
            if(!key1Grabbed){
              if(p2s2.contains(i, Y+100)){
                dead=true;
              }
            }
          }
        }
      }     
    }
  }
  else{  //jump
    jumpCount++;
    if(grounded() || jumpCount>100){  //end jump
      jump=false;
      jumpCount=0;
    }
  }
  if (key==CODED){
    if(keyCode==UP){  //jump
      if(grounded()){
        jump=true;
        dy=-1;
      }
    }
    if(keyCode==RIGHT){  //check right movement
      dx=1;
      for(int i=Y; i<Y+100;i++){
        if (get(X+50, i)!=space){  //if there is something to your right
          dx=0;  //no right movement
        }      
      }
    }
    if(keyCode==LEFT){    //check left movement
      dx=-1;
      for(int i=Y; i<Y+100;i++){
        if (get(X-1, i)!=space){  //if there is something to your left
          dx=0;  //no left movement
        }      
      }
    }
  }
  X=X+dx;
  Y=Y+dy;
}

boolean grounded(){  //returns true if you are not falling
  boolean result=true;
  for(int i=X; i<X+50;i++){
    if (get(i, Y+100)!=ground){  //if at any point there is not ground below the player
      return false;
    }
  }
  return result;
}