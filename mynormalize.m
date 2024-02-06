function normImg = mynormalize(img)
    normImg = img;
    for k = 1:size(img, 3)
        channel = img(:, :, k);
        normImg(:, :, k) = (channel - min(channel(:))) / (max(channel(:)) - min(channel(:)));
    end
end
