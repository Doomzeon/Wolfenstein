public class Heart{
  PVector position=new PVector();
  PImage terra;
  
  public Heart(float x, float y){
      position.x=x;
      position.y=y;
      terra=loadImage("t0.png");
  }
  
  public void animTub(){
    image(terra,position.x,position.y);
  }
  
  

}