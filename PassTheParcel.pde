LevelTemplate curLevel;
Parcel parcel;
Portals portals;
int curLevelIndex = 1;
int curStage = 0; //Stages of the game: 0, main menu, 1 play game, 2 quit
Button b1;
Button b2;

void setup() {
  size(800, 800);
}

void drawMenu() {
  textSize(70);
  text("Pass the parcel", width/5, height/5);
  b1 = new Button(width/2, height/2 - 100, 200, 70, 100, "Play");
  b1.draw();
  b2 = new Button(width/2, height/2, 200, 70, 100, "Quit");
  b2.draw();
}

//Changes the stage
void changeStage(int num) {
  if (num == 0 || num == 2) {
    curStage = num;
  } else if (num == 1) {
    curStage = num; 
    initializeGame();
  } else println("Not a valid stage");
}


void initializeGame() {
  curLevel = new LevelTemplate();
  portals = new Portals();
  curLevel.loadAllLevels();
  loadNextLevel();
}

//Loads next level
void loadNextLevel() {
  curLevel.load(curLevelIndex);
  parcel = new Parcel(0, 0, curLevel.cellWidth, curLevel.cellHeight);
  portals = new Portals();
  curLevel.setup();
}

//Handle key press based on current stage
void keyPressed() {
  switch(curStage) {
    default:
      break;//do nothing
    case(1):
      if (keyCode == UP) {
        if (parcel.gridY > 0 && !curLevel.grid[parcel.gridY-1][parcel.gridX]) {
          parcel.gridY--;
          parcel.teleported = false;
        }
      } else if (keyCode == DOWN) {
        if (parcel.gridY < curLevel.rows-1 && !curLevel.grid[parcel.gridY+1][parcel.gridX]) {
          parcel.gridY++;
          parcel.teleported = false;
        }
      } else if (keyCode == LEFT) {
        if (parcel.gridX > 0 && !curLevel.grid[parcel.gridY][parcel.gridX-1]) {
          parcel.gridX--;
          parcel.teleported = false;
        }
      } else if (keyCode == RIGHT) {
        if (parcel.gridX < curLevel.rows-1 && !curLevel.grid[parcel.gridY][parcel.gridX+1]) {
          parcel.gridX++;
          parcel.teleported = false;
        }
      }
      break;
  }
}

//Check the portals in the game 
void checkPortal() {  
  if (portals.getBlueSet() == true) {
    portals.drawBlue();
    if (parcel.gridX == portals.getBX() && parcel.gridY == portals.getBY() && portals.getOrangeSet() && !parcel.teleported) {
      parcel.gridX = portals.getOX();
      parcel.gridY = portals.getOY();
      parcel.teleported = true;
    }
  }
  if (portals.getOrangeSet() == true) {
    portals.drawOrange();
    if (parcel.gridX == portals.getOX() && parcel.gridY == portals.getOY() && portals.getBlueSet() && !parcel.teleported) {
      parcel.gridX = portals.getBX();
      parcel.gridY = portals.getBY();
      parcel.teleported = true;
    }
  }
}

//Handle mouse events
void handleMouse() {
  switch(curStage) {
    case(0):
      if(mousePressed&& (mouseButton == LEFT)){
        if (b1.clickButton()) {
            changeStage(1);
        } 
        else if (b2.clickButton()) {
            changeStage(2);
        }
      }
      break;
    case(1):
      if (mousePressed && (mouseButton == LEFT)) {
        int j = mouseX/(int)curLevel.cellWidth;
        int i = mouseY/(int)curLevel.cellHeight;
        if (!curLevel.grid[i][j] && curLevel.surfaces[i][j]) {
          portals.leftMouse(j, i, curLevel.cellWidth, curLevel.cellHeight);
          curLevel.surfaces[i][j] = false;
        }
      } else if (mousePressed && (mouseButton == RIGHT)) {
        int j = mouseX/(int)curLevel.cellWidth;
        int i = mouseY/(int)curLevel.cellHeight;
        if (!curLevel.grid[i][j] && curLevel.surfaces[i][j]) {
          portals.rightMouse(j, i, curLevel.cellWidth, curLevel.cellHeight);
          curLevel.surfaces[i][j] = false;
        }
      }
      break;
  }
}

//Advance to the next level, if there are no more levels left, it'll quit the game.
void advanceNextLevel() {
  if (curLevelIndex <= curLevel.maxLevels -1) {
    println("Parcel delivered!");
    curLevelIndex++;
    loadNextLevel();
  } else {
    println("Parcel delivered!");
    println("Game over");
    curStage = 2;
  }
}

//The main game engine, handles everything
void draw() {
  background(255);
  switch(curStage) {
    case(0):
      drawMenu();
      handleMouse();
      break;
    case(1):      
      curLevel.draw();
      parcel.draw();
  
      handleMouse();
      checkPortal();
  
      if (curLevel.solved()) {
        advanceNextLevel();
      }
      break;
    case(2):
      exit();
      break;
  }
}

//returns the current parcel in game
Parcel getParcel() {
  return parcel;
}
