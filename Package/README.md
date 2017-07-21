# LabWork
This software is intended to be used to measure the progress of a moving or exapanding colored object.

1. Transfer the pictures you wish to scan into the "Pictures" folder in ColorFinder.
![screenshot 24](https://user-images.githubusercontent.com/24358893/28470278-46c77b72-6e07-11e7-9fd2-b47979ecdbd3.png)

2. Run ColorFinder
![screenshot 25](https://user-images.githubusercontent.com/24358893/28470281-46cbbf66-6e07-11e7-8b20-b293608e0380.png)

3. Find the upper and lower bounds of the color. Use the left and right arrow keys to rotate through the color ranges, and the up and down arrow keys to move through the pictures in the "Pictures" folder
<img width="960" alt="screenshot 26" src="https://user-images.githubusercontent.com/24358893/28470280-46cb51ca-6e07-11e7-999a-637814b56c92.png">

4. Having found the color range, put the images into the “Pictures” folder in TestTube
![screenshot 27](https://user-images.githubusercontent.com/24358893/28470282-46ce1b6c-6e07-11e7-95c5-7b1af2389431.png)

5. Run the TestTube application
![screenshot 35](https://user-images.githubusercontent.com/24358893/28470881-2de15cac-6e09-11e7-8ff5-a742d78a0012.png)

6. Set the duration between each image (it is assumed between 5-60 seconds) and the upper and lower bounds of your color range that you found in ColorFinder. Hit “Confirm” to advance to the next window.
![screenshot 28](https://user-images.githubusercontent.com/24358893/28470284-46d627a8-6e07-11e7-8b98-0ba4752e8231.png)

7. By clicking and dragging your mouse, select the Region of Interest (ROI) for the program to scan. It will appear as a black rectangle.
![screenshot 37](https://user-images.githubusercontent.com/24358893/28470939-5fc7cdc8-6e09-11e7-9933-9bc8bc879ad9.png)

8. Release the mouse and the program will run through all the images in the “Pictures” folder, then exit.
![screenshot 36](https://user-images.githubusercontent.com/24358893/28470880-2ddbd656-6e09-11e7-962f-6ebc403d0a61.png)

9. Click on the “data.txt” file to see your data in print form.
![screenshot 31](https://user-images.githubusercontent.com/24358893/28470288-46df1e6c-6e07-11e7-8916-4ba8359c3f8d.png)
![screenshot 32](https://user-images.githubusercontent.com/24358893/28470286-46d8a230-6e07-11e7-84e6-79a8a8d58922.png)

10. You can also see your data in Excell by opening the “dataX.csv” file
![screenshot 33](https://user-images.githubusercontent.com/24358893/28470287-46dd67ac-6e07-11e7-9f28-93f3ffc63399.png)
![screenshot 34](https://user-images.githubusercontent.com/24358893/28470289-46ec18b0-6e07-11e7-8797-1eaa3fc2c05e.png)
 
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
