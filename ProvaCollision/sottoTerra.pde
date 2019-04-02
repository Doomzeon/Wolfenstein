public class sottoTerra{
  PVector position=new PVector();
  PImage terra;
  
  public sottoTerra(float x, float y){
      position.x=x;
      position.y=y;
      terra=loadImage("pezzoSotto.png");
  }
  
  public void animSotto(){
    image(terra,position.x,position.y);
  }
  
  

}