import gab.opencv.*;
import java.util.Date;
PImage img, img2;
Contour countour;
String path = "C:\\Users\\EJ\\LabWork\\TestTube\\Pictures";
int step =0;
File[] files = listFiles(path);
long[] times = new long[files.length];
int file = 0;
PrintWriter output;
void setup() {
  output = createWriter("data.txt");
  println(path);
  
  //img = loadImage("\\Pictures\\" + fileNames[0]);
  //img2 = loadImage("\\Pictures\\" + fileNames[1]);
size(1500, 720);

}
void draw() {
  File f = files[file];
  img = loadImage("\\Pictures\\" + f.getName());
  
  background(255);
   
  scale(0.25);
  image(img, 0, 0, img.width, img.height);
  //image(img2, img.width, 0, img.width, img.height);
  
switch(step){
  case 0:
    ROI(Color(img));
  break;
  
  case 1:
    println("case 1 ran");
    String lastModified = new Date(f.lastModified()).toString();
    output.println("Image " + (file + 1) + " lowest point : " + FindLines(ROI(Color(img))) + " pixels at " + lastModified);
    times[file] = f.lastModified();
  break;
  
  case 2:
    println("Case 2 ran");
    if(file == files.length-1){
      step++;
    }else{
      file++;
    step=0;
    }
  break;
  
  case 3:
  long max = 0;
  long min = 0;
for(int i = 0;i<times.length-1;i++){
  if(times[i] > times[i+1]){
    max = times[i];
    min = times[i+1];
  }else{
    max = times[i+1];
    min = times[i];
  }
}
  output.println("Time taken :" + (max - min)/1000 + " seconds");
    output.flush();
    output.close();
    exit();
  break;
}

/*
  float distance = (FindLines(Color(img)) - FindLines(Color(img2)));
  println("Moved: " + distance);
  strokeWeight(10);
  line(1100,FindLines(Color(img)),1100, FindLines(Color(img2)));
 
  Graph();
  textSize(72);
text(distance, 600, (FindLines(Color(img2)) - FindLines(Color(img)))/2 + FindLines(Color(img)));
*/
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
// This function returns all the files in a directory as an array of Strings  
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
// This function returns all the files in a directory as an array of Files  
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