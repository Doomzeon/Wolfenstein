public class Player{
  
  ArrayList<TerrenoTubatura> terra=new ArrayList<TerrenoTubatura>();
  ArrayList<blocchoTerra> blocchiTerra=new ArrayList<blocchoTerra>();
  ArrayList<sottoTerra> blocchiSotto=new ArrayList<sottoTerra>();
  ArrayList<sea> acqua=new ArrayList<sea>();
  int posx=0;
  int posy=600;
  int vita=100;
  int check=0;
  int lasBP;//verificare che bottone e stato premuto ultimo 1 destra 0 sinistra
  PImage[] goRight =new PImage[3];
  PImage[] goLeft=new PImage[3];
  PImage[] jump=new PImage[2];
  int checkSparo;
  float gravity=-20;
  int imgR=0;
  int proiettili=8;
  boolean[] movement=new boolean[4];//0=goRight;1=goLeft;2=goUp;3=spara
  int imgL=0;
  int checkT;
  ArrayList<Amo> amo=new ArrayList<Amo>();
  PVector position=new PVector(0,200);//17=largezza del corpo/erba =1pix quindi 187+1
  PVector velocity=new PVector(5,-40);
  
  float gravityAld=-20;
  
  
  private int k=2;
  public Player(){
   terra.add(new TerrenoTubatura(0,550));
   terra.add(new TerrenoTubatura(550,500));
   terra.add(new TerrenoTubatura(750,500));
   terra.add(new TerrenoTubatura(1000,350));
   
   amo.add(new Amo(425,325));
   
   blocchiTerra.add(new blocchoTerra(200,500));
   blocchiTerra.add(new blocchoTerra(250,400));
   blocchiTerra.add(new blocchoTerra(300,350));
   blocchiTerra.add(new blocchoTerra(400,350));
   blocchiTerra.add(new blocchoTerra(450,350));
   blocchiTerra.add(new blocchoTerra(500,450));
   blocchiTerra.add(new blocchoTerra(900,450));
   blocchiTerra.add(new blocchoTerra(950,350));
   //carico il terreno sotto
   for(int i=0;i<78;i++){
   blocchiSotto.add(new sottoTerra(posx,posy));
   posx+=50;
   if(i==23){
     posx=0;
     posy=650;
   }
   if(i==47){
     posx=450;
     posy=550;
   }
   if(i==62){
     posx=950;
     posy=500;
   }
   if(i==67){
     posx=950;
     posy=450;
   }if(i==72){
   posx=999;
   posy=400;
   }
   }
   blocchiSotto.add(new sottoTerra(250,500));
   blocchiSotto.add(new sottoTerra(450,450));
   //acqua
   posx=250;
   posy=550;
   for(int i=0;i<11;i++){
     acqua.add(new sea(posx,posy));
     posx+=50;
     if(i==3){
       posx=300;
       posy=500;
     }
     if(i==7){
       posx=300;
       posy=450;
     }
   }
   acqua.add(new sea(350,400));

  
    for(int i=0;i<2;i++){
      goRight[i]=loadImage(""+i+".png");
    }
    for(int i=0;i<2;i++){
      goLeft[i]=loadImage(""+k+".png");
      k+=1;
    }
    jump[0]=loadImage("j.png");
    jump[1]=loadImage("jl.png");
    
  }
  public void show(){
    //varibiale per il jumping fino a che punto arriva 
    if(movement[0]==false&&movement[1]==false&&movement[2]==false&&lasBP==1){
      background(66, 226, 244);
     image(goRight[0],position.x,position.y);//disegna imagine
    //callWorldAnimations();
    collision();
    }
    if(movement[0]==false&&movement[1]==false&&movement[2]==false&&lasBP==0){
      background(66, 226, 244);
     image(goLeft[0],position.x,position.y);//disegna imagine
 //  callWorldAnimations();
   collision();
    }//faccio controlli qualli bottoni sono stati schiaciati e in base ai bottoni
    //schiaciaticambio posizione e faccio partire animazione
    if(movement[0]==true){
      if(velocity.x==0&&collConAltroBloccho!=true){
          velocity.x=5;
        }
        if(movement[2]==true&&collConAltroBloccho==true)
          velocity.x=5;
      if(position.x+43>=width){
        velocity.x=0;
      }
      println(velocity.x+"asd");
      position.x+=velocity.x;
      background(66, 226, 244);
        imgR+=1;
        if(imgR>=2)
            imgR=0;
        image(goRight[imgR],position.x,position.y);
       //callWorldAnimations();
        lasBP=1;
       collision();
    }
    if(movement[1]==true){
        if(velocity.x==0&&collConAltroBloccho!=true){
          velocity.x=5;
        }
        if(movement[2]==true&&collConAltroBloccho==true)
          velocity.x=5;
      if(position.x<=0){
        velocity.x=0;
      }
      println(velocity.x);
      position.x-=velocity.x;
       background(66, 226, 244);
        imgL+=1;
        if(imgL>=2)
            imgL=0;
        image(goLeft[imgL],position.x,position.y);
      //callWorldAnimations();
         lasBP=0;
        collision();
    }
     if(movement[3]==true&&proiettili>0&&checkSparo==0){
       checkSparo=1;
       proiettili-=1;
       
     }
    //gravita
    
    if(movement[2]==true&&lasBP==1){
      position.y+=gravity;
      gravity+=1;
      check=1;
      println(position.y+"destra");
      background(66, 226, 244);
      image(jump[0],position.x,position.y);
     // callWorldAnimations();
      collision();
    }
    if(movement[2]==true&&lasBP==0){
      position.y+=gravity;
      gravity+=1;
      check=1;
     println(position.y+"sinistra");
      background(66, 226, 244);
      image(jump[1],position.x,position.y);
      //callWorldAnimations();
     collision();
    }
  
    if(movement[2]==true&&movement[0]==true){
      background(66, 226, 244);
      image(jump[0],position.x,position.y);
      println(position.y+"sinistra");
    //  callWorldAnimations();collision();
      collision();
    }
    if(movement[2]==true&&movement[1]==true){
      background(66, 226, 244);
      image(jump[1],position.x,position.y);
      println(position.y+"destra");
     // callWorldAnimations();collision();
       collision();
    }
  }
  boolean ver;
  boolean collConAltroBloccho;
  
  void collision(){
      
    if(lasBP==1&&position.x>=terra.get(0).position.x&&position.x<=terra.get(0).position.x+200&&position.y+63>=terra.get(0).position.y||lasBP==0&&position.x+43>=terra.get(0).position.x&&position.x+17<=terra.get(0).position.x+200&&position.y+63>=terra.get(0).position.y){
    
      if(lasBP==1&position.x+41>=terra.get(0).position.x+200){
          velocity.x=0;
          collConAltroBloccho=true;
          position.x=200-41;
        }
        else
          collConAltroBloccho=false;
        position.y=terra.get(0).position.y-63;
        update();
        ver=true;
        println(collConAltroBloccho+"asd");
      }
       else if(lasBP==1&&position.x>=blocchiTerra.get(0).position.x&&position.x<=blocchiTerra.get(0).position.x+50&&position.y+63>=blocchiTerra.get(0).position.y||lasBP==0&&position.x+43>=blocchiTerra.get(0).position.x&&position.x+17<=blocchiTerra.get(0).position.x+50&&position.y+63>=blocchiTerra.get(0).position.y){
      if(lasBP==1&position.x+41>=blocchiTerra.get(0).position.x+50){
          velocity.x=0;
          collConAltroBloccho=true;
          position.x=250-41;
        }
        else
          collConAltroBloccho=false;
        position.y=blocchiTerra.get(0).position.y-63;
        update();
        ver=true;
      }
      else if(lasBP==1&&position.x>=blocchiTerra.get(1).position.x&&position.x<=blocchiTerra.get(1).position.x+50&&position.y+63>=blocchiTerra.get(1).position.y||lasBP==0&&position.x+43>=blocchiTerra.get(1).position.x&&position.x+17<=blocchiTerra.get(1).position.x+50&&position.y+63>=blocchiTerra.get(1).position.y){
      if(lasBP==1&position.x+41>=blocchiTerra.get(1).position.x+50){
          velocity.x=0;
          collConAltroBloccho=true;
          position.x=300-41;
        }
        else
          collConAltroBloccho=false;
        position.y=blocchiTerra.get(1).position.y-63;
        update();
        ver=true;
      }
      else if(lasBP==1&&position.x>=blocchiTerra.get(2).position.x&&position.x<=blocchiTerra.get(2).position.x+50&&position.y+63>=blocchiTerra.get(2).position.y||lasBP==0&&position.x+43>=blocchiTerra.get(2).position.x&&position.x+17<=blocchiTerra.get(2).position.x+50&&position.y+63>=blocchiTerra.get(2).position.y){
      
        collConAltroBloccho=false;
        position.y=blocchiTerra.get(2).position.y-63;
        update();
        ver=true;
      }
      else if(lasBP==1&&position.x>=blocchiTerra.get(3).position.x&&position.x<=blocchiTerra.get(3).position.x+50&&position.y+63>=blocchiTerra.get(3).position.y||lasBP==0&&position.x+43>=blocchiTerra.get(3).position.x&&position.x+17<=blocchiTerra.get(3).position.x+50&&position.y+63>=blocchiTerra.get(3).position.y){
      
        collConAltroBloccho=false;
        position.y=blocchiTerra.get(3).position.y-63;
        update();
        ver=true;
      }
      else if(lasBP==1&&position.x>=blocchiTerra.get(4).position.x&&position.x<=blocchiTerra.get(4).position.x+50&&position.y+63>=blocchiTerra.get(4).position.y||lasBP==0&&position.x+43>=blocchiTerra.get(4).position.x&&position.x+17<=blocchiTerra.get(4).position.x+50&&position.y+63>=blocchiTerra.get(4).position.y){
      
        collConAltroBloccho=false;
        position.y=blocchiTerra.get(4).position.y-63;
        update();
        ver=true;
      }
      else if(lasBP==1&&position.x>=terra.get(1).position.x&&position.x<=terra.get(1).position.x+200&&position.y+63>=terra.get(1).position.y||lasBP==0&&position.x+43>=terra.get(1).position.x&&position.x+17<=terra.get(1).position.x+200&&position.y+63>=terra.get(1).position.y){
      
        collConAltroBloccho=false;
        position.y=terra.get(1).position.y-63;
        update();
        ver=true;
        println(collConAltroBloccho+"asd");
      }
      else if(lasBP==1&&position.x>=terra.get(2).position.x&&position.x<=terra.get(2).position.x+150&&position.y+63>=terra.get(2).position.y||lasBP==0&&position.x+43>=terra.get(2).position.x&&position.x+17<=terra.get(2).position.x+150&&position.y+63>=terra.get(2).position.y){
      
      if(lasBP==1&position.x+41>=terra.get(2).position.x+150){
          velocity.x=0;
          collConAltroBloccho=true;
          position.x=900-41;
        }
        else
          collConAltroBloccho=false;
        position.y=terra.get(2).position.y-63;
        update();
        ver=true;
        println(collConAltroBloccho+"asd");
      }else if(lasBP==1&&position.x>=blocchiTerra.get(6).position.x&&position.x<=blocchiTerra.get(6).position.x+50&&position.y+63>=blocchiTerra.get(6).position.y||lasBP==0&&position.x+43>=blocchiTerra.get(6).position.x&&position.x+17<=blocchiTerra.get(6).position.x+50&&position.y+63>=blocchiTerra.get(6).position.y){
      if(lasBP==1&position.x+41>=blocchiTerra.get(6).position.x+50){
          velocity.x=0;
          collConAltroBloccho=true;
          position.x=950-41;
        }
        else
          collConAltroBloccho=false;
        position.y=blocchiTerra.get(6).position.y-63;
        update();
        ver=true;
      }
      else if(lasBP==1&&position.x>=blocchiTerra.get(7).position.x&&position.x<=blocchiTerra.get(7).position.x+50&&position.y+63>=blocchiTerra.get(7).position.y||lasBP==0&&position.x+43>=blocchiTerra.get(7).position.x&&position.x+17<=blocchiTerra.get(7).position.x+50&&position.y+63>=blocchiTerra.get(7).position.y){
      
        collConAltroBloccho=false;
        position.y=blocchiTerra.get(7).position.y-63;
        update();
        ver=true;
      }
      else if(lasBP==1&&position.x>=terra.get(3).position.x&&position.x<=terra.get(3).position.x+200&&position.y+63>=terra.get(3).position.y||lasBP==0&&position.x+43>=terra.get(3).position.x&&position.x+17<=terra.get(3).position.x+200&&position.y+63>=terra.get(3).position.y){

        collConAltroBloccho=false;
        position.y=terra.get(3).position.y-63;
        update();
        ver=true;
        println(collConAltroBloccho+"asd");
      }
      else{
        ver=false;
        position.y+=2;
      }
      println(ver);
    }
    
   void textOutput(){
     textSize(16);
     text("Proiettili: "+proiettili,20,20);
     text("Vita: "+vita+"%",20,50);
     
   }
   void update(){
        gravity=gravityAld;
        check=0;
        movement[2]=false;
        float d=dist(amo.get(0).position.x,amo.get(0).position.y,position.x,position.y);
        println(d);
        if(d>=39&&d<=51){
         amo.get(0).collisioneConPlayer=true;
         proiettili+=8;
        
         
     }
        //callWorldAnimations();
   }
    void callWorldAnimations(){
      for(int i=0;i<terra.size();i++){
        TerrenoTubatura terreno=terra.get(i);
        terreno.animTub();
      }
      for(int i=0;i<blocchiTerra.size();i++){
        blocchoTerra terreno2=blocchiTerra.get(i);
        terreno2.animTerra();
      }
      for(int i=0;i<blocchiSotto.size();i++){
        sottoTerra terreno2=blocchiSotto.get(i);
        terreno2.animSotto();
      }
      for(int i=0;i<acqua.size();i++){
        sea terreno2=acqua.get(i);
        terreno2.animSea();
      }
     
        amo.get(0).aniAmo();
      
      }
    }