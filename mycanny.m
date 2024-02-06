function edgeImage = mycanny(grayImage, lowThreshold, highThreshold, n)
    if n > 1
        grayImage = imgaussfilt(grayImage, 'FilterSize', n);
    end

    edgeImage = edge(grayImage, 'canny', [lowThreshold, highThreshold]);
end
