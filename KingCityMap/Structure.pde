class Structure{
  int x;
  int y;
  String name;
  int[] colors;
  int shape;
  int sx;
  int sy;
  float conv;
  Structure(int tx, int ty,  int tsx, int tsy, String tname, int[] tcolors, int tshape, float tconv){
    x=tx;
    y=ty;
    name=tname;
    colors=tcolors;
    shape=tshape;
    sx=tsx;
    sy=tsy;
    conv=tconv;
  }
  //display
  void draw(){
      fill(colors[0],colors[1],colors[2]);
      if(shape==0){
        ellipse(x,y,sx,sy);
      }else if(shape==1){
        rect(x,y,sx,sy);
      }
      fill(0,0,0);
      if(colors[0]==0 && colors[1]==0 && colors[2]==0){
        fill(255,255,255);
      }
      if(shape==0){
        text(name,x,y);
        text("("+int(sx/conv)+"ft, "+int(sy/conv)+"ft)",x,y+20);
      }else{
        text(name,x+sx/2,y+sy/2); 
        text("("+int(sx/conv)+"ft, "+int(sy/conv)+"ft)",x+sx/2,y+sy/2+20); 
      }
  }
}
