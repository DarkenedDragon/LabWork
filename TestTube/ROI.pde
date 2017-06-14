
OpenCV opencv;
int i = 0;
int x1, x2, y1, y2;
OpenCV ROI(PImage image){
  opencv = new OpenCV(this, image);
  noFill();
  rect(x1, y1, (mouseX - x1)*4, (mouseY - y1)*4);
  opencv.setROI(x1*4, y1*4, x2*4, y2*4);
 if(i==2){
   i++;
   step++;
 }
 return opencv;
 
}
void mousePressed(){
  if(i%2==0){
    x1 = mouseX;
    y1 = mouseY;
    i++;
  }else{
    x2 = mouseX - x1;
    y2 = mouseY - y1;
    i++;
  }
  
}