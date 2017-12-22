import processing.pdf.*;

PShape baseMap;  // Stores the background image
String data[][];  // Parsed CSV data
int labelSubset = 20;  // Number of labels to draw

void setup() {
  size(1800, 900);
  noLoop();  // only run once
  
  // Load the base image
  baseMap = loadShape("WorldMap.svg");
  
  // Load the font--may need to change dep. on system
  PFont f = createFont("Avenir-Medium", 12);
  textMode(MODEL);
  textFont(f);
  
  // Load and parse the CSV
  String csv[] = loadStrings("meteors.csv");
  data = new String[csv.length][6];
  for(int i = 0; i < csv.length; i++) {
    data[i] = csv[i].split(",");
  }
}

void draw() {
  beginRecord(PDF, "meteorStrikes.pdf");
  
  // Draw the map background image
  shape(baseMap, 0, 0, width, height);
  
  for(int i = 1; i < data.length; i++) {
    // Compute latitude and longitude
    float lat = map(float(data[i][4]), 90, -90, 0, height);
    float lon = map(float(data[i][3]), -180, 180, 0, width);

    // Draw the circle based on meteor size
    float markerSize = 0.05 * sqrt(float(data[i][2]))/PI;
    noStroke();
    fill(255, 0, 0, 50);
    ellipse(lon, lat, markerSize, markerSize);
    
    // Label a subset of the largest meteorites
    if(i < 1 + labelSubset) {
      fill(0);
      text(data[i][0], lon + markerSize + 5, lat + 4);
      noFill();
      stroke(0);
      line(lon+markerSize/2, lat, lon + markerSize, lat);
    }
  }
  
  endRecord();
  println("PDF Saved.");
}