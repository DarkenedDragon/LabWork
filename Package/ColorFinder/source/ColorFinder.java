import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gab.opencv.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ColorFinder extends PApplet {


String[] fileNames;
PImage img;
OpenCV opencv;
Histogram histogram;

int lowerb = 8;
int upperb = 10;
int count = 0;
int countchk = 1;
public void setup() {
  String path = sketchPath() + "\\Pictures\\";
  fileNames = listFileNames(path);
  

}
 
public void draw() {
  if(countchk != count){
    countchk = count;
  img = loadImage("\\Pictures\\" + fileNames[count]);
  println(fileNames[count]);
  opencv = new OpenCV(this, img);
  opencv.useColor(HSB);
  }
  opencv.loadImage(img);

  image(img, 0, 0, width, height);
  
  opencv.setGray(opencv.getH().clone());
  opencv.inRange(lowerb, upperb);
  histogram = opencv.findHistogram(opencv.getH(), 255);

  image(opencv.getOutput(), 3*width/4, 3*height/4, width/4,height/4);

  noStroke(); fill(0);
  histogram.draw(10, height - 230, 400, 200);
  noFill(); stroke(0);
  line(10, height-30, 410, height-30);

  text("Hue", 10, height - (textAscent() + textDescent()));

  float lb = map(lowerb, 0, 255, 0, 400);
  float ub = map(upperb, 0, 255, 0, 400);

  stroke(255, 0, 0); fill(255, 0, 0);
  strokeWeight(2);
  line(lb + 10, height-30, ub +10, height-30);
  ellipse(lb+10, height-30, 3, 3 );
  text(lowerb, lb-10, height-15);
  ellipse(ub+10, height-30, 3, 3 );
  text(upperb, ub+10, height-15);
  
  textSize(21);
  text("Lower bound: " + lowerb, 425, height - (textAscent() + textDescent())-10);
  text("Upper bound: " + upperb, 425, height - (textAscent() + textDescent())+15);
  textSize(12);

}

public void keyPressed(){
  if(keyCode == RIGHT){
    upperb += 2;
    lowerb += 2;
  }else if(keyCode == LEFT){
    upperb -= 2;
    lowerb -= 2;
  }else if(keyCode == UP && count <fileNames.length-1){
    count++;
  }else if(keyCode == DOWN && count > 1){
    count--;
  }
  upperb = constrain(upperb, lowerb, 255);
  lowerb = constrain(lowerb, 0, upperb-1);

}

/** 
*This function returns all the files in a directory as an array of Strings
*This code is taken from the processing examples page here : https://processing.org/examples/directorylist.html
**/
public String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}
  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ColorFinder" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
