OpenCV opencv;
int i = 0;
int x1, w, y1, h;

/**
* This code is modified from
**/
OpenCV ROI(PImage image){
  opencv = new OpenCV(this, image);
  if(i <= 0){
    x1 = mouseX;
    y1 = mouseY;
  }
  
  //dragging causes crash
  
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
* Functiont that assigns the corners of the ROI to the points clicked upon
**/
void mousePressed(){
  if(i%2==0){
    x1 = mouseX;
    y1 = mouseY;
    i++;
  }
  
  else{
    w = (mouseX - x1);
    h = (mouseY - y1);
    i++;
  }
  
}
/*
void mouseReleased(){
    w = (mouseX - x1);
    h = (mouseY - y1);
    i++;
}
*/