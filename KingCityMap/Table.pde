class Tabl{
 int x;
 int y;
 int sx;
 int sy;
 float conv;
 boolean show;
 ArrayList<Player> players;
 Tabl(int tx, int ty, ArrayList<Player> tplayers, float tconv){
   players=tplayers;
   x=tx;
   y=ty;
   conv=tconv;
   sx=(players.size()+1)*30;
   sy=(players.size()+1)*15;
   show=true;
 }
 
 //display
 void draw(){
   if(!show){
     return; 
   }
   textSize(10);
   fill(255,255,255);
   //dist table
   rect(x,y,sx,sy);
   //stat table
   rect(x,y+sy+20,sx,45);
   line(x,y+sy+35,x+sx,y+sy+35);
   line(x,y+sy+50,x+sx,y+sy+50);
   line(x+sx/(players.size()+1),y+sy+35, x+sx/(players.size()+1),y+sy+65);
   fill(0,0,0);
   text("HP",x,y+sy+45);
   text("Coord",x,y+sy+60);
   //horizontal lines
   for(int i=1; i<players.size()+1; i++){
     line(x,y+i*sy/(players.size()+1),x+sx,y+i*sy/(players.size()+1));
   }
   //colored rects
   for(int i=0; i<players.size(); i++){
     fill(players.get(i).colors[0],players.get(i).colors[1],players.get(i).colors[2]);
     rect(x+sx/(players.size()+1),y+(i+1)*sy/(players.size()+1),sx-sx/(players.size()+1),sy/(players.size()+1));
   }
   
   fill(0,0,0);
   //dists
   for(int i=0; i<players.size(); i++){
     text(players.get(i).name,x+(i+1)*sx/(players.size()+1)+2,y+10);
     text(players.get(i).name,x+2,y+(i+1)*sy/(players.size()+1)+10);
     for(int j=0; j<players.size(); j++){
       int dist=int(dist(players.get(i).x,players.get(i).y,players.get(j).x,players.get(j).y)/conv); 
       text(dist,x+(i+1)*sx/(players.size()+1)+2,y+(j+1)*sy/(players.size()+1)+10);
     }
   }
   
   //stats
   for(int i=0; i<players.size(); i++){
     text(players.get(i).name,x+(i+1)*sx/(players.size()+1)+2,y+30+sy);
     text(players.get(i).hp+"/"+players.get(i).maxhp,x+(i+1)*sx/(players.size()+1)+2,y+30+sy+15);
     text("("+int(players.get(i).x/conv)+", "+int(players.get(i).y/conv)+")",x+(i+1)*sx/(players.size()+1)+2,y+30+sy+30);
   }
   
   textSize(16);
 }
 
 //changes from visible to hidden
 void toggleDisp(){
   show=!show; 
 }
}
