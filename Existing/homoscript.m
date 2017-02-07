p_h = sum(~bwimg, axis);
z_h = smooth(p_h, 25);
g_h = gradient(z_h);

l_h = [];
for k = 1 : length(g_h) - 1
    if(g_h(k + 1) * g_h(k) < 0)
        l_h = [l_h k];
    end
end

delta = diff(l_h);
V = mean(delta .^ 2) - (mean(delta) ^ 2);
display(V);