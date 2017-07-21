import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gab.opencv.*; 
import java.util.Date; 
import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TestTube extends PApplet {






ControlP5 cp5;
int upper = 50;
int lower = 50;
int confirm = 0;
int interval = 1;

int myColor = color(0,0,0);

PImage img, img2;
Contour countour;
String path;
int step = 0;
int phase = 0;
File[] files;
float[] lowPoint;
int file = 0;
PrintWriter output;

public void setup() {
  path = sketchPath();
  files = listFiles(path + "\\Pictures");
  lowPoint = new float[files.length];
  println(path);

  output = createWriter("data.txt");
  frameRate(120);
  
  cp5 = new ControlP5(this);
  //adding sliders to control the upper and lower bounds of the histogram
  cp5.addSlider("upper")
  .setSize(500, 100)
  .setPosition(width/2 - 250,height/4)
  .setRange(0,255)
  .setValue(10)
  ;
  cp5.addSlider("lower")
  .setSize(500, 100)
  .setPosition(width/2 - 250, (3/4)*height)
  .setRange(0,255)
  .setValue(10)
  ;
  cp5.addSlider("Interval (seconds)")
  .setSize(500, 100)
  .setPosition(width/2 - 250, height/2)
  .setRange(0, 60)
  .setNumberOfTickMarks(13)
  .setValue(5);
  ;
  //Makes the captions more readable
  cp5.getController("upper").getCaptionLabel().setColor(color(10,20,30,140));
  cp5.getController("upper").getCaptionLabel().setSize(25);
  cp5.getController("lower").getCaptionLabel().setColor(color(10,20,30,140));
  cp5.getController("lower").getCaptionLabel().setSize(25);
  cp5.getController("Interval (seconds)").getCaptionLabel().setColor(color(10,20,30,140));
  cp5.getController("Interval (seconds)").getCaptionLabel().setSize(25);
  //adds a "Confirm" button to advance to the next phase
  cp5.addButton("Confirm")
  .setSize(100, 100)
  .setPosition(width/2-50, height - 150)
  .setValue(0);
  
  cp5.getController("Confirm").getCaptionLabel().setSize(25);
}
//Event listener
public void slider(float theColor) {
  myColor = color(theColor);
  println("a slider event. setting background to "+theColor);
}
public void draw() {
  switch(phase){
    case 0:
    background(255);
    //gets the user's input for the bounds of the histogram
  upperb = (int)cp5.getController("upper").getValue();
  lowerb = (int)cp5.getController("lower").getValue();
  interval = (int)cp5.getController("Interval (seconds)").getValue();
  break;
  
  case 1:
  //removes the sliders and button
cp5.remove("Confirm");
cp5.remove("upper");
cp5.remove("lower");
cp5.remove("Interval (seconds)");
i=0;
phase++;
break;
//Main program runs
case 2:
  //loads the image
  File f = files[file];
  img = loadImage("\\Pictures\\" + f.getName());
  
  //displays the image to the screen
  background(255);
  scale(0.25f);
  image(img, 0, 0, img.width, img.height);
  //start of main program
switch(step){
  //gets the user's input for where the program should focus on. This is to help eliminate noise
  case 0:
  println("i: " + i);
    ROI(Color(img));
  break;
  //This runs the FindLines class. It also displays the results of all parts of the program run so far
  case 1:
  println("Line 85 ran");
  //assigns values to array's and to new variables
    lowPoint[file] = FindLines(ROI(Color(img)));
//writes the results to the data.txt file
    if(file > 0){ 
      output.print("Image " + f.getName() + " lowest point : " + lowPoint[file] + " pixels");
      float distance = lowPoint[file] - lowPoint[file - 1];
      output.println(" Moved " + distance + " pixels");
    }else{
      output.println("Image " + f.getName() + " lowest point : " + lowPoint[file] + " pixels");
    }
  break;
  //This step checks to see if there are any more images to process
  case 2:
    if(file == files.length-1){
      step++;
    }else{
      file++;
    step=0;
    }
  break;
  //This step does the time calculations and finishes up the data.txt file. At the end of this step the program exits. 
  case 3:
  
saveCSV();

int seconds = interval * (files.length-1);
int minutes = seconds/60;
int hours = minutes/60;
  output.println("Time Taken : " + hours + " hours " + minutes + " minutes " + (seconds - minutes*60) + " seconds");
    output.flush();
    output.close();
    exit();
  break;
}
break;
  }
  
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
/** 
*This function returns all the files in a directory as an array of Files
*This code is taken from the processing examples page here : https://processing.org/examples/directorylist.html
**/
public File[] listFiles(String dir){
  File file = new File(dir);
  if(file.isDirectory()){
    File[] files = file.listFiles();
    return files;
  }else{
    // If it's not a directory
    return null;
  }
}
public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
}
public void Confirm(){
  if(confirm > 0){
    phase ++;
  }
  confirm++;
}
/**
* Saves the table as a .csv file so it can be looked at in Excel. 
*
**/
public void saveCSV(){
  Table table = new Table();
  table.addColumn("Image");
  table.addColumn("Height");
  table.addColumn("Time (sec)");
  
  for(int i = 0;i<files.length;i++){
    TableRow row = table.addRow();
    File file = files[i];
  row.setString("Image", file.getName());
  row.setInt("Height", (int)lowPoint[i]);
  row.setInt("Time (sec)",interval * i);
  }
  saveTable(table, "dataX.csv");
}
PImage dst;
OpenCV opencvc;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;

/**
*Takes the image of one color that Histogram spits out and finds contour lines on it
*
*This code is modified from https://github.com/atduskgreg/opencv-processing
**/
public float FindLines(OpenCV src){
  
 
  opencvc = src;
  
  opencvc.gray();
  opencvc.threshold(70);
  dst = opencvc.getOutput();
  

  contours = opencvc.findContours();
  println("found " + contours.size() + " contours");
  if(contours.size() == 0){
    return 999;
  }
  
  noFill();
  strokeWeight(3);
  float[] maxHeight = new float[contours.size()];
  int count = 0;
  for (Contour contour : contours) {
 //stroke(0, 255, 0);
 //contour.draw();
    float[] y = new float[contour.getPolygonApproximation().getPoints().size()];
    int i = 0;
    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x + (x1*4), point.y + (y1*4));
      y[i]= point.y + (y1*4);
      i++;
    }
    endShape();
    maxHeight[count] = max(y);
    count++;
    
  }
    println("Maximum Height: " + max(maxHeight));
    return max(maxHeight);
}
OpenCV opencvh;
Histogram histogram;

int lowerb = 9;
int upperb = 10;

int test;

/**
* This code is modified from https://github.com/atduskgreg/opencv-processing

**/
public PImage Color(PImage img){
  opencvh = new OpenCV(this, img);
  opencvh.useColor(HSB);
  
  opencvh.setGray(opencvh.getH().clone());
  opencvh.inRange(lowerb, upperb);
  histogram = opencvh.findHistogram(opencvh.getH(), 255);
  return opencvh.getOutput();
}

public void Graph(){
scale(4.0f);
  noStroke(); fill(0);
  histogram.draw(10, height - 230, 400, 200);
  noFill(); stroke(0);
  line(10, height-30, 410, height-30);
  
  textSize(12);
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
   scale(0.25f);
}
OpenCV opencv;
int i = 0;
int x1, y1, x2, y2, w, h;

/**
* This code is modified from https://github.com/atduskgreg/opencv-processing
**/
public OpenCV ROI(PImage image){
  opencv = new OpenCV(this, image);
  if(i <= 0){
    x1 = mouseX;
    y1 = mouseY;
  }
  //moves the first point to the top left corner to prevent that weird bug
  if(x1 > x2){
    int temp = x1;
    x1 = x2;
    x2 = temp;
  }
  if(y1 > y2){
    int temp = y1;
    y1 = y2;
    y2 = temp;
  }
  w = x2 - x1;
  h = y2 - y1;
  //sets the Region Of Interest (ROI)
  opencv.setROI(x1*4, y1*4, w*4, h*4);
  
 if(i==2){
   step++;
   noFill();
   rect(x1*4, y1*4, w*4, h*4);
 }else{
   noFill();
   rect(x1*4, y1*4, (mouseX - x1)*4, (mouseY - y1)*4);
 }
 return opencv;
 
}
/**
* Function that assigns the corners of the ROI to the points clicked upon
**/
public void mousePressed(){
  if(i%2==0){
    x1 = mouseX;
    y1 = mouseY;
    i++;
  }

}
public void mouseReleased(){
    x2 = mouseX;
    y2 = mouseY;
    i++;
  }
  public void settings() {  size(1500, 720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TestTube" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
