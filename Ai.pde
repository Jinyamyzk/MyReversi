
class Ai {
  Board board;
  int stoneColor;

  Ai(Board board) {
    this.board = board;
    this.stoneColor = -1; // 白
  }

  /**
  * どのマスに置くか考える
  * いまのところは愚直に一番ひっくりかえせる数が多いのを選んでる
  * そのうち2〜３手先を計算するようにするつもり
  * @return 置くマス
  */
  Cell think(Board b, int stoneColor) {
    Tuple bestCell = null;
    bestCell = searchBoardTree1(b,  stoneColor);
    
    return bestCell.c;
  }   
  
  Tuple searchBoardTree1(Board b, int stoneColor){
    ArrayList<Cell> candidates = b.getEmptyCells();
    ArrayList<Tuple> v_list = new ArrayList<Tuple>();
    for (Cell cell: candidates){
      ArrayList<Cell> cellsToFlip = b.cellsToFlipWith(cell,  stoneColor);
      if (cellsToFlip.size() == 0){
        continue;
      } else {
        // 石を置いて
        cell.putStone(stoneColor);  
        // それぞれひっくり返す
        for(Cell c: cellsToFlip){
          c.flip();
        }
        int nextStone = stoneColor * -1;
        Tuple v = searchBoardTree2(b, nextStone);
        v.c = cell;
        v_list.add(v);
        for(Cell c: cellsToFlip){
          c.flip();
        }
        cell.removeStone();
      }         
    }
    Tuple bestCell = null;
    int min = 100;
    for (Tuple t: v_list){
      if (t.v < min){
        min = t.v;
        bestCell = t;
      }
    }
    return bestCell;
  }
  
  Tuple searchBoardTree2(Board b, int stoneColor){
    ArrayList<Cell> candidates = b.getEmptyCells();
    Tuple bestCell = null;
    int max = -100;
    for (Cell cell: candidates){
      ArrayList<Cell> cellsToFlip = b.cellsToFlipWith(cell,  stoneColor);
      if (cellsToFlip.size() == 0){
        continue;
      } else {
        if (cellsToFlip.size() > max){
          max = cellsToFlip.size();
          bestCell = new Tuple(cell, max);
        }
      }
    }
    return bestCell;
  }
}
