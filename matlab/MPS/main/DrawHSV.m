%inputs:
%plotradius: the plot radius of the disk. Image will be 2*plotradius+1 x 2*plotradius+1
%plotvalue:  the Value at which the slice of the HSV cylinder is to be taken. In the range 0-1
plotradius = 100;
plotvalue = 1;
[x, y] = meshgrid(-plotradius:plotradius);  %get x,y coordinates of pixels in image
[hue, saturation] = cart2pol(x, y);  %convert to angle, radius. Angle is the hue, radius is the saturation in the HSV cylinder
hue = (hue + pi) / (2*pi); %rescale from -pi:pi to 0:1 since matlab use 0:1 for the range of the hue
saturation = saturation / plotradius;  %rescale saturation to range 0:1. Not that anything above 1 is outside the cylinder
value = ones(size(hue)) * plotvalue;  %set value constant for all points in the disk
%now set points outside the disk (saturation >1) to white. That'd be a value of 1 and saturation of 0. hue doesn't matter
outsidedisk = saturation > 1;
saturation(outsidedisk) = 0;
value(outsidedisk) = 1;
%finally, convert hsv to rgb and plot
rgb = hsv2rgb(cat(3, hue, saturation, value));
imshow(rgb);