
OpenCV opencv;
int i = 0;
int x1, w, y1, h;
OpenCV ROI(PImage image){
  opencv = new OpenCV(this, image);
  if(i <= 0){
    x1 = mouseX;
    y1 = mouseY;
  }
  noFill();
  rect(x1*4, y1*4, (mouseX - x1)*4, (mouseY - y1)*4);
  
  //dragging causes crash
  
  opencv.setROI(x1*4, y1*4, w*4, h*4);
  
 if(i==2){
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
    w = (mouseX - x1);
    h = (mouseY - y1);
    i++;
  }
  
}