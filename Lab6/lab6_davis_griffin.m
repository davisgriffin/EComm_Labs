%% ECE 3770 - Lab 6 - Studying Eye Images
%  G.Davis
%  3/28/21

clc; clear; close all; clear sound;

%% Read in Benchmark Images
fileList = ["Lab6-NoiseEye/0.jpg","Lab6-NoiseEye/677.jpg","Lab6-NoiseEye/1515.jpg",...
            "Lab6-NoiseEye/6637.jpg","Lab6-NoiseEye/9161.jpg"];

straight = imread(fileList(1));
inside = imread(fileList(2));
closed = imread(fileList(3));
outside = imread(fileList(4));
up = imread(fileList(5));

%% Greyscale & Filter Images
% Greyscale images to help with correlation
% Filter helps remove noise artifacts
% straight = greyscale(straight);
inside = greyscale(inside);
closed = greyscale(closed);
outside = greyscale(outside);
up = greyscale(up);
dim = size(straight);

straight = filter2(fspecial('average',[dim(1),dim(2)]),greyscale(straight))/255;

%% Setup Test Images
% Select several test images at random and greyscale them
imgList = dir("Lab6-NoiseEye");

n = 10; % number of test images
x = rand(1,n)*numel(imgList);
% testList = ones(1,n);
imgs = ones(dim(1),dim(2),dim(3),n);
for i = 1:n
    imgs(:,:,i) = greyscale(imread(imgList(x(i))));
%     testList(i) = imgList(x(i));
end



%% Functions
function img = greyscale(in)
    img = uint8(0.2989 * in(:,:,1) + 0.5870 * in(:,:,2) + 0.1140 * in(:,:,3));
end