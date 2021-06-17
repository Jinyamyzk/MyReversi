
class Cell {
  int col; // 横の位置
  int row; // 縦の位置
  int stone = 0; // 石があるか。0：なし、1:黒、-1:白

  Cell(int colNum, int rowNum) {
    col = colNum;
    row = rowNum;
  }

  /**
  * マスを描画する
  */
  void display() {
    stroke(0);
    fill(0,140,0);
    rect(col * 50, row * 50, 50, 50); 

    // 石がある場合
    if(stone != 0){
      noStroke();
      if(stone == 1){ // 1は黒
        fill(0,0,0);
      } else { // それ以外は白
         fill(255,255,255);
      }
      // 円を描画する
      ellipse(col * 50 + 25, row* 50 + 25, 40,40);
    }
  }

  /**
  * 石を置く
  * @param stoneColor 置く石の色。黒なら1、白なら-1
  */
  void putStone(int stoneColor){
    stone = stoneColor;  
  }
  
  void removeStone(){
    stone = 0;
  }

  void flip() {
    stone *= -1;
  }

  boolean hasStone() {
    return (stone != 0); 
  }
}
