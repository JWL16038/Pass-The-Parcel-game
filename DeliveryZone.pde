class DeliveryZone{
  PImage image;
  int cellX;
  int cellY;
  int indexX;
  int indexY;
  float cellWidth;
  float cellHeight;
  
  DeliveryZone(int x,int y, float w,float h){
      cellX = (int)w*x;
      cellY = (int)h*y;
      cellWidth = w;
      cellHeight = h;
      indexX = x;
      indexY = y;
      image = loadImage("DeliveryZone.jpg");
  }
  
  
  int getX(){
   return indexX; 
  }
  int getY(){
    return indexY;
  }
  
  void draw(){
    image(image,cellX,cellY,cellWidth,cellHeight);
  }
  
}
