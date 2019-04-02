public class Amo{
  PVector position=new PVector();
  PImage amo;
  float vecchiaPosizioneY;
  int k=1;
  boolean collisioneConPlayer=false;
  public Amo(float x, float y){
      position.x=x;
      position.y=y;
      amo=loadImage("amo.png");
      vecchiaPosizioneY=position.y;
  }
  
  public void aniAmo(){
    if(collisioneConPlayer==false){
      position.y+=k;
      image(amo,position.x,position.y);
      if(position.y>=vecchiaPosizioneY+10){
        k*=-1;
      }
      if(position.y<=vecchiaPosizioneY){
        k*=-1;
      }
    }
    else{
      position.x=0;
      position.y=0;
    }
}
}