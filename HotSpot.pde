class HotSpot {
  PVector pos;
  Reveal reveal;
  int size = 50;
  int revealTime;
  String blobId = "";
  boolean revealed = false;

  HotSpot(int _size, Reveal r) {
    size = _size;
    reveal = r;
    pos = new PVector(random(width), random(height));
  }

  boolean checkCollision(Blob b) {
    float d = dist(pos.x, pos.y, b.pos.x, b.pos.y);
    println("dist:" + str(d));
    if (d < 100) {
      pos = new PVector(random(width), random(height));
      revealTime = millis(); 
      revealed = true;
      blobId = b.id;
    }
    if (blobId == b.id && revealed) {
      reveal.update(b.pos);
    }  

    return revealed;
  }  

  void draw() {
    pushStyle();
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, size, size);
    popStyle();
    if (millis() - revealTime < 5000) {
      reveal.draw();
    } else {
      if (revealed) {
        revealed = false;
        blobId = "";
      }
    }
  }
}
