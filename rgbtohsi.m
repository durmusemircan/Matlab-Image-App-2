function hsi = rgbtohsi(rgb)
    rgb = im2double(rgb); 
    r = rgb(:, :, 1);
    g = rgb(:, :, 2);
    b = rgb(:, :, 3);

    numi = 0.5 * ((r - g) + (r - b));
    denom = sqrt((r - g).^2 + (r - b) .* (g - b));
    theta = acos(numi ./ (denom + eps)); 
    H = theta;
    H(b > g) = 2*pi - H(b > g);
    H = H / (2*pi);

    S = 1 - 3 .* min(min(r, g), b) ./ (r + g + b + eps);

    I = (r + g + b) / 3;

    hsi = cat(3, H, S, I);
end
