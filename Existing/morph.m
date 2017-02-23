function [morphed] = morph(img_whitespace)

    img = img_whitespace(1);
    whitespaces = img_whitespace(2);
    val = thirdQuartile(whitespaces);
    SE = strel('rectangle', [2*val, 2*val]);
    morphed = imdilate(img, SE);
    
end