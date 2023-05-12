//IGNORE
class Temp{
  int num;
  int x;
  int y;
  int size;
  float conv;
  Temp(int tx, int ty, int tnum, float tconv){
    num=tnum;
    x=tx;
    y=ty;
    size=40;
    conv=tconv;
  }
  
  void draw(){
    fill(100,100,100);
    ellipse(x,y,size,size);
    fill(0,0,0);
    text(num, x, y);
    text("("+int(x/conv)+","+int(y/conv)+")", x-20, y+10);
  }
  
  boolean clicked(int mx, int my){
    if(dist(mx,my,x,y)<=size){
      return true;
    }
    return false;
  }
}
