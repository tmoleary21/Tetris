import java.util.Arrays;

class Tetromino {
  public float x;
  public float y;
  public int orientation; 
  PVector[][] points;
  boolean[] canMoveRLD; //indicates if can move right, left, or down (In that order)
  boolean[] canTurnRL;

  public Tetromino(float x, float y) {
    this.x = x;
    this.y = y;
    orientation = 0;
    canMoveRLD = new boolean[]{true, true, true};
    canTurnRL = new boolean[]{true, true};
  }

  public void drawBlock(int[][] board) {
    //draw boxes
    for (int block = 0; block < 4; block++) {
      rect(points[orientation][block].x, points[orientation][block].y, 20, 20);
    }

    canMoveRLD[0] = checkRight(board);
    canMoveRLD[1] = checkLeft(board);
    canMoveRLD[2] = checkDown(board);
    canTurnRL[0] = checkCW(board);
    canTurnRL[1] = checkCCW(board);
    println(Arrays.toString(points[orientation]));
    println(Arrays.toString(canMoveRLD));
    println(Arrays.toString(canTurnRL));
  }

  public void moveX(float Vx) {
    if ((Vx > 0 && canMoveRLD[0]) || (Vx < 0 && canMoveRLD[1])) {
      x += Vx * 20;
      updatePoints();
    }
  }
  public void moveY() {
    if (canMoveRLD[2]) {
      y += 20;
      updatePoints();
    }
  }
  void turn(int Vorient) {
    if ((Vorient == 1 && canTurnRL[0]) || (Vorient == 3 && canTurnRL[1])) {
      orientation = (orientation + Vorient) % 4;
    }
  }

  //This should be basically the only method to be changed between different types of blocks
  void updatePoints() {
    //Here to exist
  }

  public void lock(int[][] board) {
    for (PVector point : points[orientation]) {
      board[(int)(point.y / 20)][(int)(point.x / 20)] = 1;
    }
  }

  boolean checkDown(int[][] board) {
    for (PVector point : points[orientation]) {
      if (point.y + 20 >= height) {
        return false;
      }
      if (point.y > 0 && (int)point.y / 20 + 1 < 20 && board[(int)point.y / 20 + 1][(int)point.x / 20] == 1) {
        return false;
      }
    }
    return true;
  }

  boolean checkLeft(int[][] board) {
    for (PVector point : points[orientation]) {
      if (point.x - 20 < 0) {
        return false;
      }
      if (point.y > 0 && board[(int)point.y / 20][(int)point.x / 20 - 1] == 1) {
        return false;
      }
    }
    return true;
  }

  boolean checkRight(int[][] board) {
    for (PVector point : points[orientation]) {
      if (point.x + 20 >= width - 120) { //check boundary
        return false;
      }
      if (point.y > 0 && (int)point.x / 20 + 1 < 10 && board[(int)point.y / 20][(int)point.x / 20 + 1] == 1) { //check for piece
        return false;
      }
    }
    return true;
  }

  boolean checkCW(int[][] board) {
    int nextOrientation = (orientation + 1) % 4;
    for (PVector point : points[nextOrientation]) {
      if (point.x < 0 || point.x >= width - 120 ||  point.y >= height) {
        return false;
      }
      if (point.y > 0 && board[(int)point.y / 20][(int)point.x / 20] == 1) {
        return false;
      }
    }
    return true;
  }

  boolean checkCCW(int[][] board) {
    int nextOrientation = (orientation + 3) % 4;
    for (PVector point : points[nextOrientation]) {
      if (point.x < 0 || point.x >= width - 120 ||  point.y >= height) {
        return false;
      }
      if (point.y > 0 && board[(int)point.y / 20][(int)point.x / 20] == 1) {
        return false;
      }
    }
    return true;
  }

  boolean inBoard(int x, int y, int[][] board) {
    return x >= 0 && y >= 0 && y < board.length && x < board[0].length;
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
  public I(float x, float y) {
    super(x, y);
    updatePoints();
  }

  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-20, y), new PVector(x, y), new PVector(x+20, y), new PVector(x+40, y)}, 
      {new PVector(x, y-20), new PVector(x, y), new PVector(x, y+20), new PVector(x, y+40)}, 
      {new PVector(x-40, y), new PVector(x-20, y), new PVector(x, y), new PVector(x+20, y)}, 
      {new PVector(x, y-40), new PVector(x, y-20), new PVector(x, y), new PVector(x, y+20)}};
  }
}


/*  
    * *
    * *
*/
class O extends Tetromino {
  public final String ID = "BOX";

  //Constructor
  public O(float x, float y) {
    super(x, y);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}};
  }
}


/*  
      *
    * * *
*/
class T extends Tetromino {
  public final String ID = "T-PIECE";

  //Constructor
  public T(float x, float y) {
    super(x, y);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x+20, y)}, 
      {new PVector(x, y-20), new PVector(x, y), new PVector(x+20, y), new PVector(x, y+20)}, 
      {new PVector(x+20, y), new PVector(x, y), new PVector(x, y+20), new PVector(x-20, y)}, 
      {new PVector(x, y+20), new PVector(x, y), new PVector(x-20, y), new PVector(x, y-20)}};
  }
}


/*  
      * *
    * *
*/
class S extends Tetromino {
  public final String ID = "BOX";

  //Constructor
  public S(float x, float y) {
    super(x, y);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}};
  }
}


/*  
    * *
      * *

*/
class Z extends Tetromino {
  public final String ID = "BOX";

  //Constructor
  public Z(float x, float y) {
    super(x, y);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}};
  }
}


/*  
    *
    *
    * *
*/
class L extends Tetromino {
  public final String ID = "BOX";

  //Constructor
  public L(float x, float y) {
    super(x, y);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}};
  }
}

/*  
      *
      *
    * *
*/
class J extends Tetromino {
  public final String ID = "BOX";

  //Constructor
  public J(float x, float y) {
    super(x, y);
    updatePoints();
  }
  
  void updatePoints() {
    points = new PVector[][]{
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}, 
      {new PVector(x-20, y), new PVector(x, y), new PVector(x, y-20), new PVector(x-20, y-20)}};
  }
}
