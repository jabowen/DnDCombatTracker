class Player{
  int size;
  int x;
  int y;
  float conv;
  String name;
  int[] colors;
  int maxhp;
  int hp;
  int[] hpVals={0,0,0,0};
  Player(int tx, int ty, String tname, int[] tcolors, float tconv){
    x=tx;
    y=ty;
    name=tname;
    colors=tcolors;
    conv=tconv;
    size=50;
    maxhp=0;
    hp=0;
  }
  //display
  void draw(boolean sel){
      fill(colors[0],colors[1],colors[2]);
      ellipse(x,y,size,size);
      fill(0,0,0);
      if(colors[0]==0 && colors[1]==0 && colors[2]==0){
        fill(255,255,255);
      }
      text(name+" "+hp+"/"+maxhp,x-size/2,y);
      text("("+int(x/conv)+", "+int(y/conv)+")",x-size/2,y+15);
      if(name=="Mike"&&sel){
        text("("+hpVals[0]+", "+hpVals[1]+", "+hpVals[2]+", "+hpVals[3]+")",x-size/2,y+30);
      }
  }
  
  //move a set distance in a certian direction
  void move(float dist, int ang){
     float rang=radians(-ang);
     dist=dist*conv;
     x=x+int(dist*cos(rang));
     y=y+int(dist*sin(rang));
  }
  
  //teleport
  void port(int nx, int ny){
    x=nx;
    y=ny;
  }
  
  //chnage the max HP and scale the current HP with it
  void setMaxHp(int newMax, int toChange){
    if(name=="Mike"){
      if(toChange<1 || toChange>hpVals.length){
        print("wrong Inp2");
      }else{
        hpVals[toChange-1]=newMax;
      }
      float sum=0.0;
      for(int i=0; i<hpVals.length; i++){
        sum+=hpVals[i]; 
      }
      newMax=ceil(sum/hpVals.length);
    }
    hp=ceil(hp*(newMax/(maxhp+0.0)));
    maxhp=newMax;
  }
  
  //set both max HP and HP to new values
  void setBothHp(int newMax, int newhp){
    maxhp=newMax; 
    hp=newhp;
  }
  //set maxHP to average of list, and set HP to full
  void setBothHp(int[] newMaxs){
    hpVals=newMaxs;
    float sum=0.0;
    for(int i=0; i<hpVals.length; i++){
      sum+=hpVals[i]; 
    }
    maxhp=ceil(sum/hpVals.length);
    hp=maxhp;
  }
  
  //change current hp
  void changeHp(int hpChange){
    hp+=hpChange; 
  }
  
  //returns true if player is selcted
  boolean selected(int mx, int my){
    if(dist(mx,my,x,y)<=size/2){
      return true;
    }
    return false;
  }
  
  //clones the player with same HP at a different position
  Player makeMore(int inp1, int inp2){
    if(name=="Dyl"){
       Player p=new Player(x, y, name, colors, conv);
       p.move(inp1,inp2);
       p.setBothHp(maxhp,hp);
       return p;
    }
    return null;
  }
}
