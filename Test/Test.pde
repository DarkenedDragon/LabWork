import gab.opencv.*;

import gab.opencv.*;

PImage img;
OpenCV opencv;
Histogram histogram;

int lowerb = 50;
int upperb = 100;

void setup() {
  img = loadImage("colored_balls.jpg");
  opencv = new OpenCV(this, img);
  size(1024, 768);
  opencv.useColor(HSB);
}