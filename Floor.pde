class Floor{
  PImage image;
  int cellX;
  int cellY;
  int indexX;
  int indexY;
  float cellWidth;
  float cellHeight;
  boolean concrete;
  
  
  Floor(int x,int y, float w,float h,boolean portalable){
      cellX = (int)w*x;
      cellY = (int)h*y;
      cellWidth = w;
      cellHeight = h;
      indexX = x;
      indexY = y;
      concrete = portalable;   
  }
  
  
  int getX(){
   return indexX; 
  }
  int getY(){
    return indexY;
  }
  

  void draw(){
    if(concrete){
       fill(100,100,0); 
    }
    else{
        fill(50,50,0);
    }
   stroke(0);
   strokeWeight(3);
   rectMode(CORNER);
   rect(cellX,cellY,cellWidth,cellHeight);
  }
  
  
  
  
  
}
