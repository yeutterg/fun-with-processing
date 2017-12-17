class Stream {
  ArrayList<Char> chars;
  int numChars, speed, rndPos;
  
  Stream(int tempX, int textSize) {
   chars = new ArrayList<Char>();
   numChars = round(random(10, 30));
   
   // random speed, based on division from frame rate 
   speed = round(random(frameRate/4, frameRate*2));
   
   // start position at a random y
   rndPos = round(random(0, height-textSize));
   
   // Get the characters
   for (int y = 0; y < numChars * textSize; y += textSize) {
    chars.add(new Char(tempX, y + rndPos));
   }
  }
  
  void update() {
    for (int i = 0; i < chars.size(); i++) {
      // transparency higher on earlier iterations
      float trans = map(i, 0, chars.size() - 1, 50, 255);
      
      // fill green
      fill(0, 250, 80, trans);
      
      // fill white if last
      if (i == chars.size() - 1) fill(250, 255, 250); 
      
      // Move the characters
      if (frameCount % speed == 0) {
        chars.get(i).y += 20;
        
        // Character retains position if not new
        if (i == chars.size() - 1) {
          chars.get(i).getRandomChar();
        } else {
          chars.get(i).theChar = chars.get(i+1).theChar;
        }
      }
      
      // Change the character randomly
      if (random(1) < 0.001) {
        chars.get(i).getRandomChar();
      }
      
      // Display
      chars.get(i).show();
    }
    
    // Reset if we exceed the height
    if (chars.get(0).y > height) {
      for (int i = 0; i < chars.size(); i++) {
        chars.get(i).y = ((chars.size() - 1) - i) * -textSize;
      }
    }
  }
}