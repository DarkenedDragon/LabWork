import gab.opencv.*;
import java.util.Date;
PImage img, img2;
Contour countour;
String path = "C:\\Users\\EJ\\LabWork\\TestTube\\Pictures";
int step = 0;
File[] files = listFiles(path);
long[] times = new long[files.length];
float[] lowPoint = new float[files.length];
int file = 0;
PrintWriter output;

void setup() {
  output = createWriter("data.txt");
  frameRate(120);
  size(1500, 720);

}
void draw() {
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
    ROI(Color(img));
  break;
  //This runs the FindLines class. It also displays the results of all parts of the program run so far
  case 1:
  //assigns values to array's and to new variables
    String lastModified = new Date(f.lastModified()).toString();
    lowPoint[file] = FindLines(ROI(Color(img)));
    times[file] = f.lastModified();
//writes the results to the data.txt file
    if(file > 0){ 
      output.print("Image " + (file + 1) + " lowest point : " + lowPoint[file] + " pixels at " + lastModified);
      float distance = lowPoint[file] - lowPoint[file - 1];
      long time = (times[file] - times[file - 1])/1000; 
      output.println(" Moved " + distance + " pixels in " + time + " seconds");
    }else{
      output.println("Image " + (file + 1) + " lowest point : " + lowPoint[file] + " pixels at " + lastModified);
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
  long max = 0;
  long min = times[files.length-1];
for(int i = 0;i<times.length;i++){
  if(times[i] > max){
    max = times[i];
  }
  if(times[i] < min){
    min = times[i];
  }
  println(times[i]);
  println("Max: " + max + " Min: " + min);
}
long seconds = (max - min)/1000;
long minutes = seconds/60;
long hours = minutes/60;
  output.println("Time taken :" + hours + " hours " + minutes + " minutes " + (seconds - minutes*60) +  " seconds");
    output.flush();
    output.close();
    exit();
  break;
}

/*
//Optional code that displays the distance on the image. Not really nessisary. 
  float distance = (FindLines(Color(img)) - FindLines(Color(img2)));
  println("Moved: " + distance);
  strokeWeight(10);
  line(1100,FindLines(Color(img)),1100, FindLines(Color(img2)));
 
  Graph();
  textSize(72);
text(distance, 600, (FindLines(Color(img2)) - FindLines(Color(img)))/2 + FindLines(Color(img)));
*/
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