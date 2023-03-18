import java.util.Arrays;

Tetromino current;
Tetromino next;
int frame = 0;
int Vx = 0;
float G = 1;
int Vorient = 0;

Board board;
int gamemode = 1; //0 is menu, 1 is game, 2 is game over

PieceProvider pieceProvider;

//SCORE VARIABLES
int clearedLines = 0;
int score = 0;

void draw(){
  //background and separator
  background(200);
  line(200,0,200,height);
  
  //Score
  text("Lines " + clearedLines, 220, 100);;
  
  
  
  //Move right/left
  if(Vx != 0){
    current.moveX(Vx, board);
  }
  if(Vorient != 0){
    current.turn(Vorient, board);
  }
    
  Vorient = 0;
  Vx = 0;
  
  //Move Down
  if(frame % ((1/G) * 60) == 0){ //Frame rate is 60fps, so to start we want it to move every second. That would be 60 frames.
    if(current.moveY(board) == false){// Moves the piece down then also checks if it needs to lock
      if(!board.lockPiece(current)){ // Game over
        gamemode = 2;
      }
      else{
        board.printBoard();
        current = pieceProvider.getNext();
      }
    }
    G = 1;
  }
  
  next = pieceProvider.peekNext();
  //next.setPos(240, 40);
  //next.drawBlock(board.board);
  
  board.drawBoard(current);
  
  clearedLines += board.clearLines();
  
  if(gamemode == 2){
     fill(0);
     rect(40, 80, 120, 100);
     fill(255,0,0);
     text("GAME OVER\nSCORE: " + score + "\nLINES: " + clearedLines, 40, 100);
     fill(255);
     noLoop();
  }
  
  //Increasing and checking frame counter. Continuous
  frame++;
  if(frame >= Integer.MAX_VALUE-1) frame = 0;
}

void keyPressed(){
   if(key == CODED){
     if(keyCode == RIGHT){
        text("RIGHT",220,120);
        Vx = 1;
     }
     if(keyCode == LEFT){
         text("LEFT",220,120);
         Vx = -1;
     }
     if(keyCode == DOWN){
         text("DOWN",220,120);
         G = 10;
     }
   }
   //rotate CCW
   if(key == 'z'){
       Vorient = 3;
   }
   //rotate CW
   if(key == 'x'){
     Vorient = 1;
   }
}

void setup(){
  size(320,400); 
  textSize(20);
  
  initBoard();
  board.printBoard();
  
  pieceProvider = new PieceProvider();
  
  current = pieceProvider.getNext();
}

void initBoard(){
  PVector offset = new PVector(0,0);
  PVector pixelDimensions = new PVector(20,20);
  PVector boardDimensions = new PVector(10,20);
  board = new Board(offset, pixelDimensions, boardDimensions);
}
