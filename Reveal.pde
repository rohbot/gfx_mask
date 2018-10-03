class Reveal {
  PImage niceImage;
  PImage maskedImage;
  int iw, ih;
  int dw, dh;
  PGraphics graphicalMask;
  float x;
  float y;

  Reveal(String imgFile) {
    niceImage = loadImage(imgFile);
    iw = niceImage.width;
    ih = niceImage.height;
    dw = width - iw;
    dh = height - ih;
    graphicalMask = createGraphics(iw, ih, JAVA2D);
    graphicalMask.beginDraw();
    // Erase graphics with black background
    graphicalMask.background(0);
    graphicalMask.endDraw();
  }

  void update(PVector pos) {
    x = pos.x - dw/2;
    y = pos.y - dh/2;
  }  

  void draw() {
    graphicalMask.beginDraw();
    // Erase graphics with black background
    graphicalMask.background(0);
    // Draw in white
    graphicalMask.fill(255);
    graphicalMask.noStroke();
    // An ellipse to see a good part of the image
    graphicalMask.ellipse(x, y, 90, 90);
    graphicalMask.endDraw();

    // Copy the original image (kept as reference)
    maskedImage = niceImage.get();
    // Apply the mask
    maskedImage.mask(graphicalMask);
    // Display the result
    image(maskedImage, dw/2, dh/2);
  }
}
