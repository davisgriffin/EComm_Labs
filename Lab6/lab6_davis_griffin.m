%% ECE 3770 - Lab 6 - Studying Eye Images
%  G.Davis
%  3/28/21

clc; clear; close all; clear sound;

%% Read in Benchmark Images
fileList = ["Lab6-NoiseEye/0.jpg","Lab6-NoiseEye/677.jpg","Lab6-NoiseEye/1515.jpg",...
            "Lab6-NoiseEye/6637.jpg","Lab6-NoiseEye/9161.jpg"];
dim = size(imread(fileList(1)),1:2); % Get image resolution

% benchmark = zeros(dim(1),dim(2),numel(fileList)); % initialize array of benchmark images
H = fspecial('average',10); % averaging filter

% 1- looking straight
% 2 - looking inside
% 3 - closed / blinking
% 4 - looking outside
% 5 - looking up

% Greyscale images to help with correlation
% Filter helps remove noise artifacts
% Mask isolates only the parts of the image necessary to analyze
for i = 1:numel(fileList)
%     benchmark(:,:,i) = mask(filter2(H,greyscale(imread(fileList(i)))));
    benchmark(:,:,i) = mask(greyscale(imread(fileList(i))));
end

%% Setup Test Images
% Select several test images at random and greyscale, filter, and mask
imgList = dir("Lab6-NoiseEye");

n = 10; % number of test images
x = floor(rand(1,n)*numel(imgList));
% imgs = ones(dim(1),dim(2),n);

for i = 1:n
    st = imgList(x(i));
    imgs(:,:,i) = mask(filter2(H,greyscale(imread(sprintf("%s\\%s",st.folder,st.name)))));
    fprintf("\n%s\n",st.name);
    for j = 1:numel(fileList)
        c = normxcorr2(benchmark(:,:,j),imgs(:,:,i));
        figure, surf(c), shading flat
        fprintf("%g\n",max(max(abs(c))));
%         c = abs(c);
%         [ypeak, xpeak] = find(c==max(c(:)));
%         yoffset = ypeak-dim(1);
%         xoffset = xpeak-dim(2);
    end
end



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
end