class Button1{
 int x;
 int y;
 String txt;
 int sx;
 int sy;
 int space;
 boolean show;
 int[] cols={128,128,128};
 Button1(int tinx, int tiny, int tx, int ty, String ttxt, boolean tshow){
   txt=ttxt;
   sx=80;
   sy=30;
   space=5;
   x=tx+tinx*(space+sx);
   y=ty+tiny*(space+sy);
   show=tshow;
 }
 
 //display
 void draw(String val){
   if(!show){
     return; 
   }
   fill(cols[0],cols[1],cols[2]);
   rect(x,y,sx,sy,8,8,8,8);
   fill(0,0,0);
   text(txt+val,x+10,y+15);
 }
 
 //returns true if clicked
 boolean clicked(int mx, int my){
  if(show && mx>=x && mx<=x+sx && my>=y && my<=y+sy){
    return true; 
  }
  return false;  
 }
 
 //changes from visible to hidden
 void toggleDisp(boolean tshow){
   show=tshow; 
 }
 
 //changes the colors
 void setCol(int[] tcols){
   cols[0]=tcols[0];
   cols[1]=tcols[1];
   cols[2]=tcols[2];
 }
}
