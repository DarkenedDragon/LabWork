import gab.opencv.*;
PImage img, img2;
Contour countour;

void setup() {
  img = loadImage("GOPR8950.JPG");
  img2 = loadImage("GOPR8951.JPG");
size(1500, 720);

}
void draw() {
  background(255);
   
  scale(0.25);
  image(img, 0, 0, img.width, img.height);
  image(img2, img.width, 0, img.width, img.height);
  //scale(0.5);

  //Color();
//ndLines(Color(img));

  float distance = (FindLines(Color(img)) - FindLines(Color(img2)));
  println("Moved: " + distance);
  strokeWeight(10);
  line(1100,FindLines(Color(img)),1100, FindLines(Color(img2)));
 
  Graph();
  textSize(72);
text(distance, 600, (FindLines(Color(img2)) - FindLines(Color(img)))/2 + FindLines(Color(img)));
}

void keyPressed(){
  if(keyCode == RIGHT){
    upperb += 2;
    lowerb += 2;
  }else if(keyCode == LEFT){
    upperb -= 2;
    lowerb -= 2;
  }
   upperb = constrain(upperb, lowerb, 255);
  lowerb = constrain(lowerb, 0, upperb-1);

}