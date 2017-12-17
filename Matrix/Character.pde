class Char{
 char theChar;
 int x, y;
 
 Char(int tempX, int tempY) {
  x = tempX;
  y = tempY;
  
  getRandomChar();
 }
 
 void show() {
  text(theChar, x, y); 
 }
 
 void getRandomChar() {
   int charType = round(random(1));
   
   if (charType == 0) {
     // Numbers in random() define the unicode character range
     int rndChar = round(random(48, 90));
     theChar = char(rndChar);
   } else if (charType == 1) {
     int rndChar = round(random(12449, 12615));
     theChar = char(rndChar);
   }
 }
}