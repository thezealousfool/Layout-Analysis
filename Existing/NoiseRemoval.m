function NoiseRemoval( non_text_img )
%NOISEREMOVAL Summary of this function goes here
%   Detailed explanation goes here
    SE = strel('square', 2);
    new_img = imdilate(non_text_img, SE);
    figure;
    subplot(2,1,1)
    imshow(new_img);
    subplot(2,1,2)
    imshow(non_text_img);
end

