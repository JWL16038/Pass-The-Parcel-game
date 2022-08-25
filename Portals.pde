class Portals {
  int bCellX;
  int bCellY;
  int oCellX;
  int oCellY;
  float CellW;
  float CellH;
  boolean bSet = false;
  boolean oSet = false;
  
  void leftMouse(int x,int y,float w,float h){//left mouse for blue portal
    bCellX = x*(int)w;
    bCellY = y*(int)h;
    CellW = w;
    CellH = h;
    bSet = true;
  }
  void rightMouse(int x,int y,float w,float h){//right mouse for orange portal
    oCellX = x*(int)w;
    oCellY = y*(int)h;
    CellW = w;
    CellH = h;
    oSet = true;
  }
  
  void drawBlue(){
    fill(0,0,255);
    strokeWeight(3);
    rectMode(CORNER);
    rect(bCellX,bCellY,CellW,CellH);
    
  }
  void drawOrange(){
    fill(255,165,0);
    strokeWeight(3);
    rectMode(CORNER);
    rect(oCellX,oCellY,CellW,CellH);
    
  }
  
  boolean getBlueSet(){
   return bSet; 
  }
  boolean getOrangeSet(){
   return oSet; 
  }
  
  int getBX(){
    return bCellX/int(CellW);
  }
  int getBY(){
    return bCellY/int(CellH);
  }
  
  int getOX(){
    return oCellX/int(CellW);
  }
  int getOY(){
    return oCellY/int(CellH);
  }
  

}
