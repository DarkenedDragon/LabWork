OpenCV opencv;
int i = 0;
int x1, y1, x2, y2, w, h;

/**
* This code is modified from
**/
OpenCV ROI(PImage image){
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
void mousePressed(){
  if(i%2==0){
    x1 = mouseX;
    y1 = mouseY;
    i++;
  }

}
void mouseReleased(){
    x2 = mouseX;
    y2 = mouseY;
    i++;
  }