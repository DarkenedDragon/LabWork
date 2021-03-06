
import gab.opencv.*;
import java.util.Date;
import controlP5.*;

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

void setup() {
  path = sketchPath();
  files = listFiles(path + "\\Pictures");
  lowPoint = new float[files.length];
  println(path);

  output = createWriter("data.txt");
  frameRate(120);
  size(1500, 720);
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
void slider(float theColor) {
  myColor = color(theColor);
  println("a slider event. setting background to "+theColor);
}
void draw() {
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
  scale(0.25);
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
String[] listFileNames(String dir) {
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
File[] listFiles(String dir){
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
void Confirm(){
  if(confirm > 0){
    phase ++;
  }
  confirm++;
}
/**
* Saves the table as a .csv file so it can be looked at in Excel. 
*
**/
void saveCSV(){
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