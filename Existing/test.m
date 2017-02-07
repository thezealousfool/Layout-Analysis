img = imread('../img2.jpg');
bwimg = im2bw(img, graythresh(img));
p_h = sum(~bwimg, 2);
p_h = smooth(p_h, 15);
z_h = p_h > mean(p_h);
size_img = size(bwimg);
A = [];
for k = 1 : size_img(2)
    A = [A z_h];
end
A = im2bw(A, 0.1);
bwimg = bwimg .* A;
imshow(bwimg)

z_h = z_h - 0.5;

l_h = [];
for k = 1 : length(z_h) - 1
    if(z_h(k + 1) * z_h(k) < 0)
        l_h = [l_h k];
    end
end

delta = diff(l_h);
V = mean(delta .^ 2) - (mean(delta) ^ 2);
display(V);