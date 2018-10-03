class HotSpot {
  PVector pos;
  Reveal reveal;
  AudioSample sound;
  int size = 50;
  int revealTime;
  String blobId = "";
  boolean revealed = false;

  HotSpot(int _size, Reveal r, AudioSample s) {
    size = _size;
    reveal = r;
    sound = s;
    pos = new PVector(random(width) *0.9, random(height)* 0.9);
  }

  boolean checkCollision(Blob b) {
    
    float d = dist(pos.x, pos.y, b.pos.x, b.pos.y);
    println("dist:" + str(d));
    if (d < 100) {
      if(!revealed){
        revealTime = millis(); 
        revealed = true;
        blobId = b.id;
        sound.trigger();
      }
    }
    if (blobId == b.id && revealed) {
      reveal.update(b.pos);
    }  

    return revealed;
  }  

  void draw() {
    //pushStyle();
    //fill(255, 0, 0);
    //ellipse(pos.x, pos.y, size, size);
    //popStyle();
    if (revealed && millis() - revealTime < 5000) {
      reveal.draw();
    } else {
      if (revealed) {
        revealed = false;
        pos = new PVector(random(width), random(height));

        blobId = "";
        println("reveal over");
      }
    }
  }
}
