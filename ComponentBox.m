function ComponentBox(file)
%COMPONENTBOX Summary of this function goes here
%   Detailed explanation goes here
    img = imread(file);
    glevel = graythresh(img);
    bwimg = im2bw(img, glevel);
    bwimg = ~bwimg;
    CC = bwconncomp(bwimg, 8);
    stats = regionprops(CC, 'BoundingBox');
    hold on;
    imshow(img);
    for k = 1 : length(stats)
        thisBB = stats(k).BoundingBox;
        rectangle('Position', thisBB, 'EdgeColor', 'r');
    end
    hold off;
end

