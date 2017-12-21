// Based on tutorial here: https://www.youtube.com/watch?v=vTs9RBwCWw4

PFont foreignFont;
ArrayList<Stream> streams;
int textSize = 20;
int windowWidth;
boolean recording = false;

void setup() {
  size(1280, 720, P2D);
  
  // Ensure this font is installed on your computer
  // Otherwise use another unicode font
  foreignFont = createFont("Arial Unicode MS", textSize); 
  textFont(foreignFont);
  textAlign(LEFT, TOP);
  
  streams = new ArrayList<Stream>();
  
  for(int x = 0; x < width; x += textSize) {
    streams.add(new Stream(x, textSize));
  }
  
  windowWidth = width;
}

void draw() {
  background(0, 20, 0);
  
  // Check if window width has not changed
  if (windowWidth == width) {
    // Update all streams
    for (Stream s : streams) {
      s.update();
    }
  } else {
    // Clear the streams and reset
    streams.clear();
    for (int x = 0; x < width; x += textSize) {
      streams.add(new Stream(x, textSize));
    }
  }
  
  if (recording) {
    saveFrame("video/####.png");
    println("Recording");
  } 
  
  println("Framerate: " + frameRate);
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    recording = !recording;
  }
}