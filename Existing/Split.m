function Split( strip_img )
%SPLIT Summary of this function goes here
%   Detailed explanation goes here

    b = [];
    w = [];
    strip_img = strip_img - 0.5;
    if(strip_img(1) > 0)
        w = [w 1];
    else
        b = [b 1];
    end
    
    for k = 2 : length(strip_img) - 2
        if(strip_img(k+1) * strip_img(k) < 0)
            b = [b k];
            w = [w k];
        end
    end
    
    if(strip_img(length(strip_img)) > 0)
        w = [w length(strip_img)];
    else
        b = [b length(strip_img)];
    end
    
    w_diff = diff(w);
    w_new = w_diff(1:2:length(w_diff));
    b_diff = diff(b);
    b_new = b_diff(1:2:length(b_diff));
    display(w_new);
    display(b_new);
end

