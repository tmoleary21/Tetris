import java.util.Arrays;

class Tetromino {
  public int x, y;
  public int orientation; 
  PVector[][] points;
  color clr;

  public Tetromino(int x, int y) {
    this.x = x;
    this.y = y;
    orientation = 0;
  }
  
  public void setPos(int x, int y){
   this.x = x;
   this.y = y;
   updatePoints();
  }
  
  public boolean moveX(int Vx, Board board) {
      PVector[] position = points[orientation];
      PVector[] nextPosition = new PVector[position.length];
      for(int i = 0; i < position.length; i++){
        nextPosition[i] = new PVector(position[i].x + Vx, position[i].y);
      }
      if(board.isValidPosition(nextPosition)){
        x += Vx;
        updatePoints();
        return true;
      }
      else{
        return false;
      }

  }
    
  public boolean moveY(Board board) {
      PVector[] position = points[orientation];
      PVector[] nextPosition = new PVector[position.length];
      for(int i = 0; i < position.length; i++){
        nextPosition[i] = new PVector(position[i].x, position[i].y + 1);
      }
      if(board.isValidPosition(nextPosition)){
        y += 1;
        updatePoints();
        return true;  
      }
      else{
        return false; 
      }
  }
  
  void turn(int Vorient, Board board) {
    int nextOrientation = (orientation + Vorient) % 4;
    PVector[] nextPosition = points[nextOrientation];
    if(board.isValidPosition(nextPosition)){
      orientation = nextOrientation; 
    }
  }

  //This should be basically the only method to be changed between different types of blocks
  void updatePoints() {
    //Here to exist
  }
  
  public PVector[] getSquares() {
    return points[orientation];
  }
  
}


/***********************
START OF SPECIFIC BLOCKS
************************/


/*  
    *
    *
    *
    *
*/
class I extends Tetromino {
  public final String ID = "LONGBAR";

  //Constructor
  public I(int x, int y) {
    super(x, y);
    clr = color(0,255,255);
    updatePoints();
  }

  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-1, y), new PVector(x, y), new PVector(x+1, y), new PVector(x+2, y)}, 
      {new PVector(x, y-1), new PVector(x, y), new PVector(x, y+1), new PVector(x, y+2)}, 
      {new PVector(x-2, y), new PVector(x-1, y), new PVector(x, y), new PVector(x+1, y)}, 
      {new PVector(x, y-2), new PVector(x, y-1), new PVector(x, y), new PVector(x, y+1)}};
  }
}


/*  
    * *
    * *
*/
class O extends Tetromino {
  public final String ID = "BOX";

  //Constructor
  public O(int x, int y) {
    super(x, y);
    clr = color(255,255,0);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-1, y), new PVector(x, y), new PVector(x, y-1), new PVector(x-1, y-1)}, 
      {new PVector(x-1, y), new PVector(x, y), new PVector(x, y-1), new PVector(x-1, y-1)}, 
      {new PVector(x-1, y), new PVector(x, y), new PVector(x, y-1), new PVector(x-1, y-1)}, 
      {new PVector(x-1, y), new PVector(x, y), new PVector(x, y-1), new PVector(x-1, y-1)}};
  }
}


/*  
      *
    * * *
*/
class T extends Tetromino {
  public final String ID = "T-PIECE";

  //Constructor
  public T(int x, int y) {
    super(x, y);
    clr = color(255,0,255);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-1, y), new PVector(x, y), new PVector(x, y-1), new PVector(x+1, y)}, 
      {new PVector(x, y-1), new PVector(x, y), new PVector(x+1, y), new PVector(x, y+1)}, 
      {new PVector(x+1, y), new PVector(x, y), new PVector(x, y+1), new PVector(x-1, y)}, 
      {new PVector(x, y+1), new PVector(x, y), new PVector(x-1, y), new PVector(x, y-1)}};
  }
}


/*  
      * *
    * *
*/
class S extends Tetromino {
  public final String ID = "S-PIECE";

  //Constructor
  public S(int x, int y) {
    super(x, y);
    clr = color(0,255,0);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-1, y), new PVector(x, y), new PVector(x, y-1), new PVector(x+1, y-1)}, 
      {new PVector(x, y-1), new PVector(x, y), new PVector(x+1, y), new PVector(x+1, y+1)}, 
      {new PVector(x+1, y), new PVector(x, y), new PVector(x, y+1), new PVector(x-1, y+1)}, 
      {new PVector(x, y+1), new PVector(x, y), new PVector(x-1, y), new PVector(x-1, y-1)}};
  }
}


/*  
    * *
      * *

*/
class Z extends Tetromino {
  public final String ID = "Z-PIECE";

  //Constructor
  public Z(int x, int y) {
    super(x, y);
    clr = color(255,0,0);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-1, y-1), new PVector(x, y-1), new PVector(x, y), new PVector(x+1, y)}, 
      {new PVector(x+1, y-1), new PVector(x+1, y), new PVector(x, y), new PVector(x, y+1)}, 
      {new PVector(x+1, y+1), new PVector(x, y+1), new PVector(x, y), new PVector(x-1, y)}, 
      {new PVector(x-1, y+1), new PVector(x-1, y), new PVector(x, y), new PVector(x, y-1)}};
  }
}


/*  
    *
    *
    * *
*/
class L extends Tetromino {
  public final String ID = "L-PIECE";

  //Constructor
  public L(int x, int y) {
    super(x, y);
    clr = color(255,100,0);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x, y-1), new PVector(x, y), new PVector(x, y+1), new PVector(x+1, y+1)}, 
      {new PVector(x+1, y), new PVector(x, y), new PVector(x-1, y), new PVector(x-1, y+1)}, 
      {new PVector(x, y+1), new PVector(x, y), new PVector(x, y-1), new PVector(x-1, y-1)}, 
      {new PVector(x-1, y), new PVector(x, y), new PVector(x+1, y), new PVector(x+1, y-1)}};
  }
}

/*  
      *
      *
    * *
*/
class J extends Tetromino {
  public final String ID = "J-PIECE";

  //Constructor
  public J(int x, int y) {
    super(x, y);
    clr = color(0,0,255);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x, y-1), new PVector(x, y), new PVector(x, y+1), new PVector(x-1, y+1)}, 
      {new PVector(x+1, y), new PVector(x, y), new PVector(x-1, y), new PVector(x-1, y-1)}, 
      {new PVector(x, y+1), new PVector(x, y), new PVector(x, y-1), new PVector(x+1, y-1)}, 
      {new PVector(x-1, y), new PVector(x, y), new PVector(x+1, y), new PVector(x+1, y+1)}};
  }
}
