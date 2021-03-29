%% ECE 3770 - Lab 6 - Studying Eye Images
%  G.Davis
%  3/28/21

clc; clear; close all; clear sound;

%% Read in Benchmark Images
fileList = ["Lab6-NoiseEye/0.jpg","Lab6-NoiseEye/677.jpg","Lab6-NoiseEye/1515.jpg",...
            "Lab6-NoiseEye/6637.jpg","Lab6-NoiseEye/9161.jpg"];
dim = size(mask(imread(fileList(1))),1:2); % Get image resolution

benchmark = zeros(dim(1),dim(2),numel(fileList)); % initialize array of benchmark images
H = fspecial('average',15); % averaging filter

% Greyscale images to help with correlation
% Filter helps remove noise artifacts
% Mask isolates only the parts of the image necessary to analyze
for i = 1:numel(fileList)
    benchmark(:,:,i) = mask(filter2(H,greyscale(imread(fileList(i))))/255);
end

figure
montage(benchmark);
title("Benchmark Images");

%% Setup Test Images
% Select several test images at random and greyscale, filter, and mask
imgList = dir("Lab6-NoiseEye");

n = 10; % number of test images
x = floor(rand(1,n)*numel(imgList));
imgs = ones(dim(1),dim(2),n);
c1 = 1:numel(fileList);

for i = 1:n
    st = imgList(x(i));
    if find(fileList=="Lab6-NoiseEye/"+st.name)>0
        % RNG selected a testimage
        st = imgList(x(i)+1);
    end
    imgs(:,:,i) = mask(filter2(H,greyscale(imread(sprintf("%s\\%s",st.folder,st.name))))/255);
    fprintf("\n%s\n",st.name);
    c1 = 1:numel(fileList);
    for j = 1:numel(fileList)
        c(:,:,j) = normxcorr2(benchmark(:,:,j),imgs(:,:,i));
        c1(j) = max(max(abs(c(:,:,j))));
    end
    fprintf("Looking Straight Correlation : %g\n" + ...
            "Looking Inside Correlation   : %g\n" + ...
            "Closed / Blinking Correlation: %g\n" + ...
            "Looking Outside Correlation  : %g\n" + ...
            "Looking Up Correlation       : %g\n",+ ...
            c1(1),c1(2),c1(3),c1(4),c1(5));
    index = find(c1==max(c1));
    decideEye(index, c);
end

figure
montage(imgs);
title("Test Images"), snapnow

%% Functions
function img = greyscale(in)
    img = uint8(0.2989 * in(:,:,1) + 0.5870 * in(:,:,2) + 0.1140 * in(:,:,3));
end

function img = mask(img)
    h = 200;
    k = 150;
    c_radius = 80;
    r_radius = 60;
    c_radius_squared = c_radius * c_radius;
    r_radius_squared = r_radius * r_radius;
    for r = 1:size(img, 1)    % for number of rows of the image
        for c = 1:size(img, 2)    % for number of columns of the image
            if ( ( (c-h)^2/c_radius_squared + (r-k)^2/r_radius_squared ) <= 1)
                img(r, c) = img(r, c);
            else
                img(r, c) = 0;
            end
        end
    end
    img = img(k-r_radius:k+r_radius,h-c_radius:h+c_radius);
end

function decideEye(index, c)
    switch index
        case 1
            fprintf("Eye is looking straight.\n\n");
            figure, surf(c(:,:,index)), shading flat
            title("Eye looking straight")
        case 2
            fprintf("Eye is looking inside.\n\n");
            figure, surf(c(:,:,index)), shading flat
            title("Eye looking inside")
        case 3
            fprintf("Eye is closed / blinking.\n\n");
            figure, surf(c(:,:,index)), shading flat
            title("Eye closed / blinking")
        case 4
            fprintf("Eye is looking outside.\n\n");
            figure, surf(c(:,:,index)), shading flat
            title("Eye looking outside")
        case 5
            fprintf("Eye is looking upwards.\n\n");
            figure, surf(c(:,:,index)), shading flat
            title("Eye looking upwards")
    end
    snapnow
end