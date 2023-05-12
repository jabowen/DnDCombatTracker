ArrayList<Player> players=new ArrayList<Player>();
ArrayList<Structure> structs= new ArrayList<Structure>();
ArrayList<Button1> buttons=new ArrayList<Button1>(); 
ArrayList<Temp> temps=new ArrayList<Temp>();
ArrayList<Player> dead=new ArrayList<Player>();
Tabl t;

int tempNum=0;
int togButSt=0;
String inp1="0";
String inp2="0";
int curr=0;
int lastPlayer=0;
int lastAction=0;
int[] oldCoord={0,0};
int playSel=-1;
int dsize=50;

float conversion=0;
int dimension=60;//ft

int Button1Space=5;


void setup(){
  size(700,850);
  conversion=width/dimension;
  //rectMode(CENTER);
  fillPlayers();
  fillStructs();
  fillButton1s();
  t=new Tabl(0,35,players,conversion);
}

void draw(){
    background(250,123,98);
    //draw buildings
    for(int i=0; i<structs.size(); i++){
       structs.get(i).draw();
    }
    //draw players
    for(int i=0; i<players.size(); i++){
       Player p=players.get(i);
       if(p.hp>0){
         p.draw(playSel==i);
       }else{
         boolean livingClone=false;
         for(int j=0; j<players.size(); j++){
           if(i==j){continue;}
           if(p.name==players.get(j).name){
             livingClone=true;
             break;
           }
         }
         if(!livingClone){
           dead.add(p);
         }
         players.remove(i); 
       }
    }
    //display dead
    for(int i=0; i<dead.size(); i++){
      Player p=dead.get(i);
      fill(p.colors[0],p.colors[1],p.colors[2]);
      ellipse(width-i*dsize-dsize/2,dsize/2,dsize,dsize);
    }
    //draw temps
    for(int i=0; i<temps.size(); i++){
       temps.get(i).draw();
     }
    //draw Buttons
    for(int i=0; i<buttons.size(); i++){
      if(i==1){
        buttons.get(i).draw(inp1);
      }else if(i==2){
        buttons.get(i).draw(inp2);
      }else{
        buttons.get(i).draw("");
      }
    }    
    //draw table
    t.draw();
}

void mousePressed(){
  if(mouseButton==RIGHT){
    tempNum++;
    temps.add(new Temp(mouseX,mouseY,tempNum, conversion));
    lastAction=1;
    selectPlayer(-1);
    return;
  }
  //undo
  if(buttons.get(0).clicked(mouseX, mouseY)){
       if(lastAction==0){
         int[] newCoord={oldCoord[0],oldCoord[1]};
         oldCoord[0]=players.get(lastPlayer).x;
         oldCoord[1]=players.get(lastPlayer).y;
         players.get(lastPlayer).port(newCoord[0],newCoord[1]);
       }else if(lastAction==1){
         temps.remove(temps.size()-1);
         tempNum--;
       }else if(lastAction==2){
         players.get(lastPlayer).setMaxHp(oldCoord[0],int(inp2));
       }else if(lastAction==3){
         players.remove(players.size()-1);
       }else if(lastAction==4){
         players.get(lastPlayer).changeHp(-int(inp1));
       }
       lastAction=0;
       selectPlayer(-1);
       return;
    }
    //set inp1
    if(buttons.get(1).clicked(mouseX, mouseY)){
        inp1="";
        curr=1;
        return;
    }
    //set inp2
    if(buttons.get(2).clicked(mouseX, mouseY)){
        inp2="";
        curr=2;
        return;
    }
    //toggle Table
    if(buttons.get(3).clicked(mouseX, mouseY)){
        t.toggleDisp();
        return;
    }
    //Move
    if(buttons.get(butByTxt("Move")).clicked(mouseX, mouseY)){
        oldCoord[0]=players.get(playSel).x;
        oldCoord[1]=players.get(playSel).y;
        players.get(playSel).move(int(inp1),int(inp2));
        lastPlayer=playSel;
        selectPlayer(-1);
        lastAction=0;
        return;
    }
    //Change Max
    if(buttons.get(butByTxt("Change Max")).clicked(mouseX, mouseY)){
        Player p =players.get(playSel);
        oldCoord[0]=p.maxhp;
        p.setMaxHp(int(inp1),int(inp2));
        lastPlayer=playSel;
        selectPlayer(-1);
        lastAction=2;
        return;
    }
    //Clone
    if(buttons.get(butByTxt("Clone")).clicked(mouseX, mouseY)){
        Player p=players.get(playSel).makeMore(int(inp1),int(inp2));
        if(p!=null){
          players.add(p); 
        }
        selectPlayer(-1); 
        lastAction=3;
        return;
    }
    //Port
    if(buttons.get(butByTxt("Port")).clicked(mouseX, mouseY)){
        oldCoord[0]=players.get(playSel).x;
        oldCoord[1]=players.get(playSel).y;
        players.get(playSel).port(int(inp1),int(inp2));
        lastPlayer=playSel;
        selectPlayer(-1);
        lastAction=0;
        return;
    }
    //Change Hp
    if(buttons.get(butByTxt("Change HP")).clicked(mouseX, mouseY)){
        players.get(playSel).changeHp(int(inp1));
        lastPlayer=playSel;
        selectPlayer(-1);
        lastAction=4;
        return;
    }
    
    //Change attribute
    if(buttons.get(butByTxt("Change Att")).clicked(mouseX, mouseY)){

        return;
    }
    
   for(int i=0; i<players.size(); i++){
       //players.get(i).draw();
       if(players.get(i).selected(mouseX,mouseY)){
         if(playSel<0){
           selectPlayer(i);
         }else{
           selectPlayer(-1); 
         }
         return;
       }
    }
    for(int i=0; i<temps.size(); i++){
      Temp tmp=temps.get(i);
      if(tmp.clicked(mouseX, mouseY)){
        temps.remove(i);
        selectPlayer(-1);
      }
    }
    selectPlayer(-1);
    
    for(int i=0; i<dead.size(); i++){
      if(dist(mouseX, mouseY,width-i*dsize-dsize/2,dsize/2)<dsize/2){
        Player p=dead.get(i);
        p.setBothHp(1,1);
        players.add(p);
        dead.remove(i);
      }
    }
}

void selectPlayer(int val){
  if(val>-1){
    for(int i =togButSt; i<buttons.size(); i++){
        Button1 b=buttons.get(i);
        b.toggleDisp(true);
        b.setCol(players.get(val).colors);
     }
     playSel=val;
  }else{
    for(int i =togButSt; i<buttons.size(); i++){
        buttons.get(i).toggleDisp(false);
      }
    playSel=-1;
  }
}

int butByTxt(String inp){
  for(int i=0; i<buttons.size(); i++){
    Button1 b= buttons.get(i);
    if(b.txt==inp){
      return i;
    }
  }
  return -1;
}

boolean insideRect(int x, int y, int sx, int sy){
  if(mouseX>=x && mouseX<=x+sx && mouseY>=y && mouseY<=y+sy){
   return true; 
  }
  return false; 
}


void keyPressed(){
 if (key == '\n' ) {
    curr=0; 
  } else {
    if(curr==1){
      inp1 = inp1 + key; 
    }else if(curr==2){
      inp2=inp2+key; 
    }
  }
}

void fillButton1s(){
  //normal Button1s
  String[] txts={"Undo", "Inp1=", "Inp2=", "Table"};
  for(int i=0; i<txts.length; i++){
    buttons.add(new Button1(i,0,0,0,txts[i],true));
  }
  //toggle Button1s
  togButSt=txts.length;
  String[][] togTxts={{"Move","Change Max", "Clone"}, {"Port", "Change HP", "Change Att"}};
  for(int i=0; i<togTxts.length; i++){
     for(int j=0; j<togTxts[i].length; j++){
        buttons.add(new Button1(i,j,width/2-80,height/2,togTxts[i][j], false));
     }
  }
}

void fillPlayers(){
  //players
  {
    int[] colors={180,0,0};
    players.add(new Player(width/2,height/4,"Fate",colors,conversion));
    players.get(0).setBothHp(25,25);
  }
  {
    int[] colors={192, 192, 192};
    players.add(new Player(width*3/9,height*3/4,"Sher",colors,conversion));
    players.get(1).setBothHp(22,22);
  }
  {
    int[] colors={89,203,232};
    players.add(new Player(width*4/9,height*3/4,"Dyl",colors,conversion));
    players.get(2).setBothHp(8,8);
  }
  {
    int[] colors={0,255,0};
    int[] hpVals={5,18,45,1};
    players.add(new Player(width*5/9,height*3/4,"Mike",colors,conversion));
    players.get(3).setBothHp(hpVals);
  }
  {
    int[] colors={255, 215, 0};
    players.add(new Player(width*6/9,height*3/4,"Alex",colors,conversion));
    players.get(4).setBothHp(24,24);
  }
  {
    int[] colors={255, 255, 255};
    players.add(new Player(width*3/9,height*3/4+height/10,"Dep",colors,conversion));
    players.get(5).setBothHp(20,20);
  }
}
void fillStructs(){
  //buildings
  {
    int[] colors={255,255,224};
    structs.add(new Structure(width/4, height/8, width/2, height,"Street",colors,1,conversion));
  }
  {
    int[] colors={128, 0, 0};
    structs.add(new Structure(0, 0, width, height/8,"Saloon",colors,1,conversion));
  }
  {
    int[] colors={150, 75, 0};
    structs.add(new Structure(width/20, height/4, width/4-width/20, height,"Buildings",colors,1,conversion));
  }
  {
    int[] colors={150, 75, 0};
    structs.add(new Structure(width*3/4, height/4, width/4-width/20, height,"Buildings",colors,1,conversion));
  }
  {
    int[] colors={250,231,218};
    structs.add(new Structure(width/4+width/20, height/8+height/40, width/2-width/10, height/20,"Crowd",colors,1,conversion));
  }
}
