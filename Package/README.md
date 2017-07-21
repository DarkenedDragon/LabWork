# LabWork
This software is intended to be used to measure the progress of a moving or exapanding colored object.

Instructions for use:
1. Use the ColorFinder program to find the color range that your object is in. 
2. Once you have that range, run the TestTube program and input the upper and lower bounds of the range you just obtained from ColorFinder
3. Select the Region of Interest(ROI) by dragging a rectangle around the area you wish to process. 
4. Let the program run. It may take several minutes depending on the amount of pictures you are processing. The results can be found in the data.txt and data.csv files.

NOTE: If the returned value is 999, it is the programs's error message and means that it found nothing with in that ROI and color range. 

Common errors:
1. Same values for each picture:
	This means that the software has found an instance of the color you are scanning for in an unexpected and immobile place and it is the lowest
	point of your image. Try to crop out this part when you use the ROI tool
2. Too much noise!
	This is a problem with how the picture was taken. This software does not do much of anything to reduce an images noise, so it is important when taking the pictues
	to try to keep possible noise to a minimum. Try taking your pictures against a single color backdrop and in good, even lighting.
3. The image crosses into two different color ranges in ColorFinder:
	In TestTube simply combine the ranges found in ColorFinder. Input the lowerbound of the lower range and upper bound of the upper range 
	when TestTube prompts you for the bounds. However, this technique can increase the amount of background noise the software picks up. 