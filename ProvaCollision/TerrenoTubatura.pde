public class TerrenoTubatura{
  PVector position=new PVector();
  PImage terra;
  
  public TerrenoTubatura(float x, float y){
      position.x=x;
      position.y=y;
      terra=loadImage("t0.png");
  }
  
  public void animTub(){
    image(terra,position.x,position.y);
  }
  
  

}