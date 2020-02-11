% Read the original image
f=imread('RandomDisks-P10.jpg');
[m,n]=size(f);
f1=zeros(size(f));

% transform the image to a binary image 
% 0 represents black and 1 represents white
% let threshold=128
for i=1:m
    for j=1:n
        if f(i,j) < 128
            f1(i,j) = 0;
        else
            f1(i,j) = 1;
        end
    end
end

% after converting, three channels are the same.
% Thus, we can use eithe of them.
% The image reduces from 3 channel to 1 channel
% Make black be the background
X = ~f1(:,:,1);

% Apply opening first and then closing to image
% for denoising, where B is the structuring 
% elements.
B = ones(3,3);
opening = dilation(erosion(X,B),B);
closing = erosion(dilation(opening,B),B);

% Find the radii of circles in image
[centers, radii] = imfindcircles(closing,[6 100],'Sensitivity', 0.9);
minr = floor(min(radii));
maxr = ceil(max(radii));

% Show the images which indicate the position of smallest circles 
% and largest circles
subplot(1,2,1);
imshow(detect_smallest_circle(closing, minr)),title('Positions of Smallest Circles');
subplot(1,2,2);
imshow(detect_largest_circle(closing, maxr)),title('Positions of Largest Circles');