public class sea{
  PVector position=new PVector();
  PImage terra;
  
  public sea(float x, float y){
      position.x=x;
      position.y=y;
      terra=loadImage("sea.png");
  }
  
  public void animSea(){
    image(terra,position.x,position.y);
  }
  
  

}