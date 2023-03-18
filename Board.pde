
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
  
  public PVector getBoardCoord(int x, int y){
     return new PVector(offsetX + x * pixelWidth, offsetY + y * pixelHeight);
  }
  
  public void drawBoard(){
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

}
