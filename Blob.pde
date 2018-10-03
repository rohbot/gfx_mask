class Blob {
  String id;
  PVector pos;
  int drawX;
  int drawY;
  int size;
  int lastUpdated;
  PImage brushImage;

  Blob(String _id, int _size) {
    id = _id;
    size = _size;
    brushImage = loadImage("images/brush.png");
    pos = new PVector();
  }
  void update(int _x, int _y) {
    pos.x = _x;
    pos.y = _y;
    drawX = _x - (size / 2);
    drawY = _y - (size / 2) ;
    lastUpdated = millis();
  }

  void draw() {
    //ellipse(pos.x/2, pos.y/2, 50, 50);
    image(brushImage, drawX, drawY, size, size);
  }

  String toString() {
    return id + " : " + pos;
  }
}  
