import java.util.Map;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
HashMap<String, Blob> blobs;
ArrayList<HotSpot> hotspots;
String removeBlob = "";

Reveal r1;
Reveal r2;
Reveal r3;
Reveal r4;
Reveal r5;

int mode = 1;

void setup() {
  size(1280, 720);
  r1 = new Reveal("images/KLCC_1.jpg");
  r2 = new Reveal("images/KLCC_2.jpg");
  r3 = new Reveal("images/KLCC_3.jpg");
  r4 = new Reveal("images/KLCC_4.jpg");
  r5 = new Reveal("images/KLCC_5.jpg");
  blobs =  new HashMap<String, Blob>();
  
  hotspots = new ArrayList<HotSpot>();
  hotspots.add(new HotSpot(50, r1));
  //hotspots.add(new HotSpot(50, r2));
  //hotspots.add(new HotSpot(50, r3));
  
  oscP5 = new OscP5(this, 9995);

  background(0);

}

void draw() {
  background(0);
  try {

    for (Blob b : blobs.values()) {
      b.draw();
      if (millis() - b.lastUpdated > 5000) {
        removeBlob = b.id;
      }
    }

    if (removeBlob != "") {
      blobs.remove(removeBlob);
      removeBlob = "";
    }
  }
  catch(Exception e) {
    println(e);
  }
  
  for( HotSpot h: hotspots){
    h.draw();
  } 
  
}

void updateBlob(String blobId, int x, int y) {
  Blob b = blobs.get(blobId);
  if (b == null) {
    b = new Blob(blobId, 50);
    blobs.put(blobId, b);

  }
  b.update(x, y);
  //Check for collosions
  for( HotSpot h: hotspots){
    if(h.checkCollision(b)){
      //println("Collided! " + b);
    }
    
            
  } 
  
}  

void oscEvent(OscMessage msg) {
  /* print the address pattern and the typetag of the received OscMessage */
  if (msg.checkAddrPattern("/blobs")==true) {
    /* check if the typetag is the right one. */
    if (msg.checkTypetag("sii")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      String blobId = msg.get(0).stringValue();  
      int x = msg.get(1).intValue();
      int y = msg.get(2).intValue();
      //println(" values: "+blobId+", "+x+", "+y);
      updateBlob(blobId, x, y);
      return;
    }
  }
}



void keyPressed() {
  switch(key) {
  case '1':
    mode = 1;
    break;
  case '2':
    mode = 2;
    break;
  case '3':
    mode = 3;
    break;
  case '4':
    mode = 4;
    break;
  case '5':
    mode = 5;
    break;
  }
  println(mode);
}  

//void mouseMoved() {
//  r1.update(mouseX, mouseY);
//  r2.update(mouseX, mouseY);
//  r3.update(mouseX, mouseY);
//  r4.update(mouseX, mouseY);  
//  r5.update(mouseX, mouseY);
//}
