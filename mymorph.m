function coloredImage = mymorph(binaryImage, colormapName)

    cc = bwconncomp(binaryImage);

    labelMatrix = labelmatrix(cc);

    numLabels = double(max(labelMatrix(:)));

    numLabels = max(numLabels, 1);

    switch colormapName
        case 'Jet'
            cmap = jet(numLabels);
        case 'HSV'
            cmap = hsv(numLabels);
        case 'Hot'
            cmap = hot(numLabels);
        case 'Cool'
            cmap = cool(numLabels);
        case 'Parula'
            cmap = parula(numLabels);
        otherwise
            error('Invalid colormap name. Valid options are Jet, HSV, Hot, Cool, and Parula.');
    end

    coloredImage = label2rgb(labelMatrix, cmap, 'k', 'shuffle');
end
