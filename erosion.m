function erosion_pic = erosion(X,B)
% for all B we ensure B=B^s
% Specificly, we ensure B to be a (2k+1)*(2k+1) centrosymmetric matrix
% thus we can only focus on how to inplement Minkowski Subtraction

% padding X with black pixels
l = floor(length(B(1,:))/2);
X = padarray(X, [l,l], 1);

erosion_pic = zeros(size(X));
[ROW,COL] = size(X);
% be aware of border affect
for x=1+l:ROW-l
    for y=1+l:COL-l
        curr_X = X(x-l:x+l,y-l:y+l);
        tmp = (curr_X & B) == B;
        erosion_pic(x,y) = all(tmp(:));
    end
end
erosion_pic = erosion_pic(l+1:end-l, l+1:end-l);
return