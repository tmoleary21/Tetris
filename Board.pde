
public class Board {

  private float offsetX, offsetY;
  private float pixelWidth, pixelHeight;
  private int width, height;
  
  private int[][] board;
  private color[][] colorBoard;
  
  public Board(PVector offset,  PVector pixelDimensions, PVector boardDimensions) {
    
    this.offsetX = offset.x;
    this.offsetY = offset.y;
    this.pixelWidth = pixelDimensions.x;
    this.pixelHeight = pixelDimensions.y;
    this.width = (int) boardDimensions.x;
    this.height = (int) boardDimensions.y;
    this.board = new int[this.height][this.width];
    this.colorBoard = new color[this.height][this.width];
    
  }
  
  public String toString(){
      String s = "";
      for(int[] elem : board){
         s += Arrays.toString(elem) + '\n'; 
      }
      return s;
  }
  
  public void printBoard(){
     println('\n' + this.toString()); 
  }
  
  public PVector getBoardCoord(int x, int y){
     return new PVector(offsetX + x * pixelWidth, offsetY + y * pixelHeight);
  }
  
  public PVector getBoardCoord(PVector coord){
    return getBoardCoord((int)coord.x, (int)coord.y); 
  }
  
  public void drawBoard(Tetromino fallingPiece){
    for(int row = 0; row < this.height; row++){
        for(int column = 0; column < this.width; column++){
            if(board[row][column] == 1){
                fill(colorBoard[row][column]);
                PVector coordinate = getBoardCoord(column, row);
                rect(coordinate.x, coordinate.y, pixelWidth, pixelHeight);
                fill(255);
            }
        }
    }
    
    // Draw current falling piece
    drawTetromino(fallingPiece);
  }
  
  public void drawTetromino(Tetromino piece){
    fill(piece.clr);
    for(PVector squareCoord : piece.getSquares()){
      PVector coordinate = getBoardCoord(squareCoord);
      rect(coordinate.x, coordinate.y, pixelWidth, pixelHeight);
    }
    fill(255);
  }
  
  public boolean isValidPosition(PVector[] position){
    for(PVector point : position){
      if(!inBoard(point) || positionFilled(point)){
          return false;
      }
    }
    return true;
  }
  
  public boolean inBoard(PVector pos){
    return pos.x >= 0 && pos.y >= 0 && pos.y < this.height && pos.x < this.width;
  }
  
  public boolean positionFilled(PVector pos){
    return board[(int)pos.y][(int)pos.x] == 1;
  }
  
  public boolean lockPiece(Tetromino piece){
    for (PVector point : piece.getSquares()) {
      if(point.y < 0){
        return false; //means that it is above the board, so end the game. loss
      }
      board[(int)point.y][(int)point.x] = 1;
      colorBoard[(int)point.y][(int)point.x] = piece.clr;
    }
    return true; 
  }
  
  public int clearLines(){
    int clearedLines = 0;
    
    int[] fullRow = new int[this.width];
    Arrays.fill(fullRow, 1);
    
    for(int i = 0; i < this.height; i++){
      if(Arrays.equals(board[i], fullRow)){
        clearedLines++;
        for(int j = i; j > 0; j--){
          board[j] = board[j-1];
          colorBoard[j] = colorBoard[j-1];
        }
        board[0] = new int[this.width]; // Defaults to zeroes
        colorBoard[0] = new color[this.width];
      }
    }
    
    return clearedLines; // Return number of lines cleared for stats
  }
  
  //Utility. Makes a grid in the playfield
  public void drawGrid(){
    fill(200);
    for(int y = 0; y < this.height; y++){
      for(int x = 0; x < this.width; x++){
        PVector coordinate = getBoardCoord(x,y);
        rect(coordinate.x, coordinate.y, pixelWidth, pixelHeight);
      }
    }
    fill(255);
  }

}
