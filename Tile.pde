class Tile {
  boolean isBomb;
  boolean isClicked;
  int surround;
  boolean search;
  
  public void setBomb(boolean bomb) {
    isBomb = bomb;
  }
  
  public Tile() {
    isClicked = false;
    search = false;
  }
  
  public boolean clicked() {
    isClicked = true;
    if(isBomb) {
      println("You just got destroyed boy!");
      return true;
    }  
    else return false;
}
}
