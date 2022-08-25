class LevelTemplate {
  ArrayList<int[][]> listlevels = new ArrayList<int[][]>();
  int[][] level;

  int[][] level1 = {
    {3, 1, 1, 1, 1, 1, 2, 0}, 
    {0, 1, 0, 0, 2, 1, 0, 1}, 
    {0, 1, 0, 1, 0, 1, 0, 0}, 
    {0, 1, 0, 1, 0, 1, 1, 1}, 
    {2, 1, 2, 0, 0, 1, 0, 0}, 
    {1, 1, 0, 1, 0, 1, 0, 2}, 
    {0, 1, 0, 1, 2, 1, 0, 1}, 
    {2, 0, 0, 1, 1, 1, 0, 4}};

  int[][] level2 = {
    {3, 0, 1, 1, 1, 1, 0, 1, 1, 2}, 
    {1, 0, 0, 1, 0, 0, 0, 1, 0, 0}, 
    {1, 2, 1, 1, 0, 1, 0, 0, 0, 1}, 
    {1, 1, 1, 1, 0, 1, 0, 1, 1, 1}, 
    {1, 1, 2, 0, 0, 1, 0, 0, 1, 1}, 
    {1, 1, 0, 1, 0, 1, 0, 1, 2, 1}, 
    {2, 1, 0, 1, 0, 1, 1, 1, 0, 4}, 
    {0, 1, 0, 0, 1, 1, 2, 1, 1, 1}, 
    {0, 0, 0, 1, 0, 0, 0, 0, 1, 1}, 
    {0, 0, 1, 1, 1, 1, 0, 0, 0, 2}};
    
  int[][] level3 = {
    {3, 1, 1, 1, 1, 0, 1, 4, 1, 0}, 
    {0, 1, 0, 0, 0, 0, 1, 0, 2, 0}, 
    {0, 1, 0, 1, 0, 1, 1, 1, 1, 0}, 
    {0, 1, 0, 1, 0, 1, 1, 1, 1, 1}, 
    {0, 0, 0, 1, 0, 1, 0, 1, 1, 1}, 
    {1, 1, 1, 1, 0, 0, 0, 0, 1, 0}, 
    {1, 1, 1, 1, 1, 1, 1, 0, 0, 0}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 1, 0}, 
    {1, 0, 1, 1, 1, 1, 0, 1, 1, 1}, 
    {0, 2, 1, 1, 1, 1, 0, 0, 0, 2}};    

  int rows ;
  int cols ;
  float cellWidth ;
  float cellHeight;
  boolean[][] grid;
  boolean[][] surfaces;
  DeliveryZone dz;
  int maxLevels;

  //Loads all levels 
  void loadAllLevels() {
    listlevels.add(level1);    
    listlevels.add(level2);
    listlevels.add(level3);
    maxLevels = listlevels.size();
  }

  //Loads current level
  void load(int levelNum) {
    level = listlevels.get(levelNum-1);
    rows = level.length;
    cols = level[0].length;
    cellWidth = 800/cols;
    cellHeight = 800/rows;
    grid = new boolean[rows][cols];
    surfaces = new boolean[rows][cols];
  }

  //Builds current level
  void setup() {
    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {    
        if (level[i][j] == 1) {//solid wall (crate)
          grid[i][j]=true;
        } else if (level[i][j] == 2) {
          surfaces[i][j]=true;
        } else if (level[i][j] == 3) {
          getParcel().gridX = j;
          getParcel().gridY = i;
        } else if (level[i][j] == 4) {
          dz = new DeliveryZone(j, i, cellWidth, cellHeight);
        }
      }
    }
  }

  //Draws current level
  void draw() {
    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {
        int cellX = (int)cellWidth*j;
        int cellY = (int)cellHeight*i;
        if (grid[i][j]) {
          Crates c = new Crates(cellX, cellY, cellWidth, cellHeight);
          c.draw();
        } else if (!grid[i][j] && surfaces[i][j]) {
          fill(50, 50, 50); 
          stroke(0);
          strokeWeight(2);
          rectMode(CORNER);
          rect(cellX, cellY, cellWidth, cellHeight);
        } else {
          fill(128, 128, 128); 
          stroke(0);
          strokeWeight(2);
          rectMode(CORNER);
          rect(cellX, cellY, cellWidth, cellHeight);
        }
      }
    }
    dz.draw();
  }

  //Check if the level is solved
  boolean solved() {
    if (getParcel().gridX == dz.getX() && getParcel().gridY == dz.getY()) {
      return true;
    }
    return false;
  }
}
