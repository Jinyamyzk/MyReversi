
class Board {
  ArrayList<ArrayList> cells; // マスの行を入れておく配列
  int b=0;
  int w=0;
  
  Board() {
    cells = new ArrayList<ArrayList>();

    for(int row = 0; row < 8; row++){
      // 行ごとの配列を作る
      ArrayList<Cell> rCells = new ArrayList<Cell>();

      for(int col = 0; col < 8; col++){
        // マスを作って行の配列に入れる
        Cell cell = new Cell(col, row);
        rCells.add(cell);
      }

      // 行の配列を全体の配列に入れる
      cells.add(rCells);
    }
  }

  void initGame() {
    getCellAt(3,3).putStone( 1 );
    getCellAt(4,4).putStone( 1 );
    getCellAt(3,4).putStone( -1 );
    getCellAt(4,3).putStone( -1 );
  }

  /**
  * 盤面の「描く」機能
  * マスを一個一個とりだして描画させている
  */
  void display() {
    // マスを一個一個とりだしてマスの「描画する」機能を実行する
    for(ArrayList<Cell> row: cells){
      for(Cell c: row){
        c.display(); 
      }  
    }
  }
  
  //盤面のコマの数
  int evalBoard(int stoneColor){
    for(ArrayList<Cell> row: cells){
      for(Cell c: row){
        if (c.stone == 1){
          b++;
        } else if (c.stone == -1){
          w++;
        }
      }  
    }
    return (stoneColor == 1) ? (b-w) : (w-b);
  }

  /**
  * ある座標にあるマスを返す
  */
  Cell getCellAtXY(int x,int y) {
    int colNum = floor( x / 50);
    int rowNum = floor( y / 50);
    return (Cell) cells.get(rowNum).get(colNum); 
  }


  /**
  * あるマスに石を置いた場合にひっくりかえせるセルの配列を返す
  * @param cell 石を置こうとするマス
  * @param stone 置く石を意味する整数。Cell.BLACKまたはCell.WHITE
  */
  ArrayList<Cell> cellsToFlipWith(Cell cell, int stone) {
    ArrayList<Cell> cellsToFlip = new ArrayList<Cell>();
    if(cell.hasStone()){
      return cellsToFlip;
    }

    // 縦横斜めの8方向に対象となるマスをとってきて、引っ繰り返せるかどうか調べる
    for(int dCol = -1; dCol < 2; dCol ++){
      for(int dRow = -1; dRow < 2; dRow ++) {
        ArrayList<Cell> cellsInDir = this.getCellsInDirection(cell, dCol, dRow);
        ArrayList<Cell> checked = new ArrayList<Cell>();
        for(Cell c: cellsInDir) {
           if(!c.hasStone()){
                 break;
            }
            // 色が違う場合はいったん配列に入れる
            if(c.stone != stone){
                 checked.add(c);
            }
            // 同じ色の石がみつかったら返却する配列にそこまでの石を入れてループを抜ける
            if(c.stone == stone){
               for(Cell toFlip: checked){
                 cellsToFlip.add(toFlip);
               }
               break;
            }
          }
          // 同じ色の石が見つからなかったらcheckedは破棄される
       }
     }
     return cellsToFlip;
  }

  /**
  * あるマスを起点として指定された方向に並ぶセルを返す
  * 右上方向なら directionCol = 1, directionRow = -1 となる
  * @param cellAtStart 起点となるマス
  * @param directionCol 横方向 -1=左,0=そのまま,1=右
  * @param directionRow 縦方向 -1=上,0=そのまま,1=下
  */
  ArrayList<Cell> getCellsInDirection(Cell cellAtStart,int directionCol, int directionRow ) {
    ArrayList<Cell> cellsToReturn  = new ArrayList<Cell>();
    if(directionCol == 0 && directionRow == 0){
      return cellsToReturn;
    }
    int col = cellAtStart.col + directionCol;
    int row = cellAtStart.row + directionRow;
    Cell nextCell = getCellAt(col,row);
    while(nextCell != null){
      cellsToReturn.add(nextCell);
      col += directionCol;
      row += directionRow;
      nextCell = getCellAt(col,row);
    }
    return cellsToReturn;
  }

  Cell getCellAt(int col, int row) {
    if(col < 0 || col > 7 || row < 0 || row > 7){
      return null;
    }
    return (Cell) cells.get(row).get(col); 
  }


  ArrayList<Cell> getEmptyCells() {
    ArrayList<Cell> eCells = new ArrayList<Cell>();
    for(ArrayList<Cell> row: cells){
      for(Cell cell: row){
        if(!cell.hasStone()){
          eCells.add(cell);
        }
      }
    }
    return eCells;
  }
  
  Board copy(){
    Board b = new Board();
    for (ArrayList<Cell> row : this.cells){
      for (Cell cell : row){
        b.getCellAt(cell.col, cell.row).putStone(cell.stone);
      }
    }
    return b;
  }
}
