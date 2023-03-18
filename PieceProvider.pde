
public class PieceProvider{
  
  ArrayList<Tetromino> pieceQueue = new ArrayList<Tetromino>();
  
  public Tetromino getNext(){
    if(pieceQueue.size() == 0){
      populateNextList();
    }
    Tetromino current = pieceQueue.get(pieceQueue.size()-1);
    pieceQueue.remove(pieceQueue.size()-1);
    return current;
  }
  
  public Tetromino peekNext(){
    if(pieceQueue.size() == 0){
      populateNextList();
    }
    return pieceQueue.get(pieceQueue.size()-1);
  }
  
  private void populateNextList(){
    ArrayList<Tetromino> pieces = new ArrayList<Tetromino>(Arrays.asList(
      new I(4,0), 
      new O(4,0), 
      new T(4,0), 
      new S(4,0), 
      new Z(4,0), 
      new L(4,0), 
      new J(4,0)
    ));
    for(int i = 0; i < 7; i++){
        int index = (int)(pieces.size() * Math.random());
        pieceQueue.add(pieces.get(index));
        pieces.remove(index);
    }
}
  
}
