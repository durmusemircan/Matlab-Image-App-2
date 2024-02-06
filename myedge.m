function edgeImage = myedge(intensityImage, method, includeDiagonals, threshold, useOtsu)
   
    switch method
        case 'kirsch'
            edgeImage = kirschEdgeDetection(intensityImage, includeDiagonals);
        case 'prewitt'
            edgeImage = prewittEdgeDetection(intensityImage);
        case 'sobel'
            edgeImage = sobelEdgeDetection(intensityImage);
        case 'scharr'
            edgeImage = scharrEdgeDetection(intensityImage);
        otherwise
            error('Unknown method selected.');
    end

    if useOtsu
        level = graythresh(edgeImage); % Otsu's method
        edgeImage = imbinarize(edgeImage, level);
    else
        edgeImage = imbinarize(edgeImage, threshold); % User-defined threshold
    end
end

function edgeImage = kirschEdgeDetection(grayImage, includeDiagonals)

    masks = cat(3, [-3 -3 5; -3 0 5; -3 -3 5], ...
                   [-3 5 5; -3 0 5; -3 -3 -3], ...
                   [5 5 5; -3 0 -3; -3 -3 -3], ...
                   [5 5 -3; 5 0 -3; -3 -3 -3]);
    if includeDiagonals
        masks = cat(3, masks, ...
                       [5 -3 -3; 5 0 -3; 5 -3 -3], ...
                       [-3 -3 -3; 5 0 -3; 5 5 -3], ...
                       [-3 -3 -3; -3 0 -3; 5 5 5], ...
                       [-3 -3 -3; -3 0 5; -3 5 5]);
    end
    
    edgeImage = applyMasks(grayImage, masks);
end

function edgeImage = prewittEdgeDetection(grayImage)

    Gx = [-1 0 1; -1 0 1; -1 0 1];
    Gy = Gx';
    
    edgeImage = applyGradientMasks(grayImage, Gx, Gy);
end

function edgeImage = sobelEdgeDetection(grayImage)

    Gx = [-1 0 1; -2 0 2; -1 0 1];
    Gy = Gx';
    
    edgeImage = applyGradientMasks(grayImage, Gx, Gy);
end

function edgeImage = scharrEdgeDetection(grayImage)

    Gx = [-3 0 3; -10 0 10; -3 0 3];
    Gy = Gx';
    
    edgeImage = applyGradientMasks(grayImage, Gx, Gy);
end

function edgeImage = applyMasks(grayImage, masks)
    edgeImage = zeros(size(grayImage));
    for i = 1:size(masks, 3)
        filteredImage = imfilter(double(grayImage), masks(:,:,i), 'replicate');
        edgeImage = max(edgeImage, filteredImage);
    end
    edgeImage = mat2gray(edgeImage);
end

function edgeImage = applyGradientMasks(grayImage, Gx, Gy)
    edgeX = imfilter(double(grayImage), Gx, 'replicate');
    edgeY = imfilter(double(grayImage), Gy, 'replicate');
    edgeImage = sqrt(edgeX.^2 + edgeY.^2);
    edgeImage = mat2gray(edgeImage);
end
