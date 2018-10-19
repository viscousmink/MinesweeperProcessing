PImage img;
Tile[][] tiles;
int numBombs;
boolean Bopped;

void setup() {
  numBombs = 0;
  tiles = new Tile[16][16];
  for(int i=0; i<16; i++) {
    for(int j=0; j<16; j++) {
      tiles[i][j] = new Tile();
    }
  }
  for(int i=0; i<16; i++) {
    for(int j=0; j<16; j++) {
      tiles[i][j].setBomb(Randomize( i , j ));
    }
  }
  println("There are " + numBombs + " in the field");
  frameRate(30);
  size(400,400);
  background(0);
  img = loadImage("tile.jpg");
  Bopped = false;
  surrounding();
}

void draw() {
  background(0);
  for(int i=0; i<16; i++) {
    for(int j=0; j<16; j++) {
      if(tiles[i][j].isClicked) {
        
      }
      image(img, (i * 25), (j * 25), 25, 25);
      if(tiles[i][j].isClicked) {
        text(tiles[i][j].surround, i*25 + 10, j*25 + 15);
      }
    }
  }
  if(Bopped) {
    fill(0);
    rect(100,100, width/2, height/2);
    fill(255);
    text("Ya Lost", width/2 - 25, height/2);
  }
}

boolean Randomize(int i, int j) {
  boolean state;
  float r = random(100);
  
  // giving this puppy a 20% chance of being a bomb!
  if(r < 50 && r > 30) {
    state = true; 
    numBombs += 1;
    println("Adding bomb at " + i + " " + j);
  }
  else state = false;
  
  return state; 
}

void mouseClicked() {
  int x = mouseX/25, y = mouseY/25;
  
  println(x + " " + y);
  
  Bopped = tiles[x][y].clicked();
  region(x, y);
}

void surrounding() {
  for(int i=0; i<16; i++) {
    for(int j=0; j<16; j++) {
      if(i>=1) {
        if(j>0) {
          if(tiles[i-1][j-1].isBomb) {
            tiles[i][j].surround += 1;
          }
        }
        if(tiles[i-1][j].isBomb) {
          tiles[i][j].surround += 1;
        }
        if(j<15) {
          if(tiles[i-1][j+1].isBomb) {
            tiles[i][j].surround += 1;
          }
        }
      }
       if(j>0) { 
         if(tiles[i][j-1].isBomb) {
           tiles[i][j].surround += 1;
         }
       }
      if(tiles[i][j].isBomb) {
        tiles[i][j].surround += 1;
      }
      if(j<15) {
        if(tiles[i][j+1].isBomb) {
          tiles[i][j].surround += 1;
        }
      }
      if(i<15) {
        if(j>0) {
          if(tiles[i+1][j-1].isBomb) {
            tiles[i][j].surround += 1;
          }
        }
        if(tiles[i+1][j].isBomb) {
          tiles[i][j].surround += 1;
        }
        if(j<15) {
          if(tiles[i+1][j+1].isBomb) {
            tiles[i][j].surround += 1;
          }
        }
      }
    }
  }
}

void region(int i, int j) {
  if(tiles[i][j].search)
    return;
  tiles[i][j].search = true;
  println("region " + i + " " + j);
  if(tiles[i][j].isBomb == false && tiles[i][j].surround == 0) {
    tiles[i][j].isClicked = true;
    if(i<15) {
      region(i+1,j);
    }
    if(i>0) {
      region(i-1,j);
    }
    if(j>0) {
      region(i,j-1);
    }
    if(j<15) {
      region(i,j+1);
    }
  }
}
