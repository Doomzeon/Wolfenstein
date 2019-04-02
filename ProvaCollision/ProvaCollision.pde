
Player player;
void setup()  {
  size(1200,700);
  background(266, 226, 244);
  player= new Player();

}
void draw(){
  frameRate(24);
  player.show();
  println(player.velocity.x);
  player.textOutput();
  println(player.movement[0],player.movement[1]);
 //println(player.ver);
 player.callWorldAnimations();
}




void keyPressed(){
  if(keyCode=='D'){
    player.movement[0]=true;
  }
  if(keyCode=='A'){
    player.movement[1]=true;
    
  }
  if(player.check==0){
    if(keyCode=='W'){
   // player.collision=false;
    player.movement[2]=true; 
   // player.positionVY=player.position.y;
  }
  if(player.checkSparo==0){
    if(keyCode=='R'){
    player.movement[3]=true;
   }
  }
  } 
}
void keyReleased(){
  if(keyCode=='D'){
    player.movement[0]=false;
  }
  if(keyCode=='A'){
    player.movement[1]=false;
  }
  if(keyCode=='R'){
    player.movement[3]=false;
    player.checkSparo=0;
  }
  
  
}