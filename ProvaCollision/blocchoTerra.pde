public class blocchoTerra{
  PVector position=new PVector();
  PImage terra;
  
  public blocchoTerra(float x, float y){
      position.x=x;
      position.y=y;
      terra=loadImage("t2.png");
  }
  
  public void animTerra(){
    image(terra,position.x,position.y);
  }
  
  

}