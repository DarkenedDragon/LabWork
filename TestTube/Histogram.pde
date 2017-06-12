OpenCV opencvh;
Histogram histogram;

int lowerb = 76;
int upperb = 77;

PImage Color(PImage img){
  opencvh = new OpenCV(this, img);
  opencvh.useColor(HSB);
  
  opencvh.setGray(opencvh.getH().clone());
  opencvh.inRange(lowerb, upperb);
  histogram = opencvh.findHistogram(opencvh.getH(), 255);
  return opencvh.getOutput();
}

void Graph(){
scale(4.0);
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
   scale(0.25);
}