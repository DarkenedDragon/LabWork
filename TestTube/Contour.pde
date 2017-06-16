PImage dst;
OpenCV opencvc;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;

/**
*Takes the image of one color that Histogram spits out and finds contour lines on it
*
**/
float FindLines(OpenCV src){
  
 
  opencvc = src;
  
  opencvc.gray();
  opencvc.threshold(70);
  dst = opencvc.getOutput();
  

  contours = opencvc.findContours();
  println("found " + contours.size() + " contours");
  
  noFill();
  strokeWeight(3);
  float[] maxHeight = new float[contours.size()];
  int count = 0;
  for (Contour contour : contours) {
 // stroke(0, 255, 0);
 // contour.draw();
    float[] y = new float[contour.getPolygonApproximation().getPoints().size()];
    int i = 0;
    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x + (x1*4), point.y + (y1*4));
      y[i]= point.y + (y1*4);
   // println(point.x + ", " + point.y);
      i++;
    }
    endShape();
 // println(max(y));
    maxHeight[count] = max(y);
    count++;
    
  }
    println("Maximum Height: " + max(maxHeight));
    return max(maxHeight);
}