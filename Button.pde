class Button{
 int x;
 int y;
 int w;
 int h;
 int c;
 String t;
 
 Button(int x,int y,int w,int h,int colour, String text){
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
   this.c = colour;
   this.t = text;
 }
 
 
 void draw(){
   rectMode(CENTER);
   fill(c);
   rect(x,y,w,h);
   fill(0);
   textSize(30);
   text(t,x - 30,y);
 }
 
 boolean clickButton(){
  if (mouseX >= this.x && mouseX <= (this.x+this.w) && mouseY >= y && mouseY <= (this.y+this.h)) {
    return true; 
  }
   return false;
 }
  
}
