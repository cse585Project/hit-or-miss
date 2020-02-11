% The function to detect the groups of the smallest circles in input image.
% Input is a binary image and the approximated radius of circles.
% Output is a image to show the positions of the smallest circles
% in input image.
function smallest_circle_img = detect_smallest_circle(img, radius)
% create first structuring element which is a white circle with 
% black background
r = radius - 2; 
h = r*2 + 1; w = r*2 + 1; 
I = zeros(h, w);
[x, y] = meshgrid(1:w, 1:h);  
I(((x-ceil(w/2)).^2+(y-ceil(h/2)).^2) <= r^2) = 1;

% create second structuring element which is a black circle with 
% white background
r2 = radius + 2; 
h2 = r2*2+21; w2 = r2*2+21; 
I2 = zeros(h2, w2);
[x, y] = meshgrid(1:w2, 1:h2);  
I2(((x-ceil(w2/2)).^2+(y-ceil(h2/2)).^2) <= r2^2) = 1;

% Hit-or-Miss transform
left = erosion(img, I);
right = erosion(~img, ~I2);
smallest_circle_img= ~(left & right);
return