function [bwimg] = ComponentBox(file)
%COMPONENTBOX Summary of this function goes here
%   Detailed explanation goes here
    img = imread(file);
    glevel = graythresh(img);
    bwimg = im2bw(img, glevel);
    invbwimg = ~bwimg;
    stats = regionprops(invbwimg, 'BoundingBox', 'Area', 'Extent', 'Eccentricity', 'EulerNumber');
    stats = stats([stats.Area] > 6);
    stats = stats([stats.Extent] > 0.06);
    stats = stats([stats.Eccentricity] < 0.9982);
    stats = stats([stats.EulerNumber] > -3);
    stats = stats([stats.EulerNumber] < 3);
    newimg = ones(size(img) .* [1 1 0] + [0 0 1], 'uint8') * 255;
    for k = 1 : length(stats)
        thisBB = stats(k).BoundingBox;
        xoff = thisBB(1) - 0.5;
        yoff = thisBB(2) - 0.5;
        for l = 1 : thisBB(3)
            for m = 1 : thisBB(4)
                newimg(yoff + m, xoff + l) = bwimg(yoff + m, xoff + l) * 255;
            end
        end
    end
    
    bwimg = im2bw(newimg, glevel);
end

