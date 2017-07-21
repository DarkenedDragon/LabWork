# LabWork
This software is intended to be used to measure the progress of a moving or exapanding colored object.

1. Transfer the pictures you wish to scan into the "Pictures" folder in ColorFinder.
 
2. Run ColorFinder

3. Find the upper and lower bounds of the color
 
4. Having found the color range, put the images into the “Pictures” folder in TestTube
 
5. Run the TestTube application
<insert photo here>
6. Set the duration between each image (it is assumed between 5-60 seconds) and the upper and lower bounds of your color range that you found in ColorFinder. Hit “Confirm” to advance to the next window.
 
7. By clicking and dragging your mouse, select the Region of Interest (ROI) for the program to scan. It will appear as a black rectangle.
<insert image here>

8. Release the mouse and the program will run through all the images in the “Pictures” folder, then exit.

9. Click on the “data.txt” file to see your data in print form.
 
10. You can also see your data in Excell by opening the “data.csv” file

 
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