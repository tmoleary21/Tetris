import java.util.Arrays;

Tetromino current;
Tetromino next;
int frame = 0;
float Vx = 0;
float G = 1;
int Vorient = 0;

int[][] board = new int[20][10];
color[][] colorboard = new color[20][10];
int gamemode = 1; //0 is menu, 1 is game, 2 is game over

ArrayList<Tetromino> nextPieces = new ArrayList<Tetromino>();

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
  //if(keyPressed){
    if(Vx != 0){
      current.moveX(Vx, board);
    }
    if(Vorient != 0){
      current.turn(Vorient);
    }
    
  //}
  Vorient = 0;
  Vx = 0;
  
  //Move Down
  if(frame % ((1/G) * 60) == 0){ //Frame rate is 60fps, so to start we want it to move every second. That would be 60 frames.
    if(current.moveY(board) == false){//Moves the piece down then also checks if it needs to lock
      if(!current.lock(board, colorboard)){
        gamemode = 2;
      }
      else{
        println(frame);
        printBoard();
        current = nextPieces.get(nextPieces.size()-1);
        nextPieces.remove(nextPieces.size()-1);
        current.setPos(80,0);
      }
    }
    G = 1;
  }
  
  if(nextPieces.size() == 0){
     populateNextList(); 
  }
  
  next = nextPieces.get(nextPieces.size()-1);
  next.setPos(240, 40);
  next.drawBlock(board);
  
  
  current.drawBlock(board);
  
  //Put pieces on the board that are aready locked
  drawBoard();  
  
  clearLines();
  
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
  //println(frame);
  if(frame >= Integer.MAX_VALUE) frame = 0;
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
  printBoard();
  populateNextList();
  current = nextPieces.get(nextPieces.size()-1);
  nextPieces.remove(nextPieces.size()-1);
}

//Makes a grid in the playfield. Nice to have
void drawGrid(){
  fill(200);
  for(int i = 0; i < 200; i += 20){
    for(int j = 0; j < 400; j += 20){
      rect(i,j,20,20);
    }
  }
  fill(255);
}

void printBoard(){
    println('\n');
    for(int[] elem : board){
       println(Arrays.toString(elem)); 
    }
}

void drawBoard(){
    for(int row = 0; row < 20; row++){
        for(int column = 0; column < 10; column++){
            if(board[row][column] == 1){
                fill(colorboard[row][column]);
                rect(column * 20, row * 20, 20, 20);
                fill(255);
            }
        }
    }
}

void clearLines(){
 for(int i = 0; i < board.length; i++){
   if(Arrays.equals(board[i], new int[]{1,1,1,1,1,1,1,1,1,1})){
       clearedLines++;
       for(int j = i; j > 0; j--){
          board[j] = board[j-1]; 
       }
   }
 }
}

void populateNextList(){
    ArrayList<Tetromino> pieces = new ArrayList<Tetromino>(Arrays.asList(new I(80,0), new O(80,0), new T(80,0), new S(80,0), new Z(80,0), new L(80,0), new J(80,0)));
    for(int i = 0; i < 7; i++){
        int index = (int)(pieces.size() * Math.random());
        nextPieces.add(pieces.get(index));
        pieces.remove(index);
    }
}
