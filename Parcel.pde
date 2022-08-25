class Parcel {
  PImage image;
  int x, y;
  int gridX, gridY;
  float pwidth, pheight;
  boolean teleported = false;

  Parcel(int indexX, int indexY, float w, float h) {
    gridX = indexX;
    gridY = indexY;
    pwidth = w;
    pheight = h;
    image = loadImage("Parcel.jpg");
  }

  void draw() {
    x = gridX * (int)pwidth;
    y = gridY * (int)pheight;
    image(image,x,y,pwidth,pheight);
  }
}
