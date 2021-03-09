%% ECE 3770 - Lab 5 - Sample Exercises
%  E.Berde
%  3/8/2021

%% Part 1 - Read in Hootie
% Read in sound, determine sample frequency
[g,fs] = audioread("hootie.wav");
sound(g,fs);

%% Part 2

sz = size(g)
g(:,2) = [];
sz = size(g)

%% Part 3 - Create the corresponding time array.
n=length(g)                
T = n/fs                   % We use big T to specify the total time
dt=1/fs;                   % dt (delta time) for one sample
t=0:dt:T-dt;               % Create the corresponding time array.
sz = size(t)
%% Part 4 - Plot a spectrogram
figure(1)
spectrogram(g,256,250,256,fs,'yaxis')
size(t)

%% Part 5 - Use the chirp function
x = chirp(t,1000,5,5000,'linear');
figure(2)
spectrogram(x,256,250,256,fs,'yaxis')

%% Part 6 - Cat sounds together
[g,fs] = audioread("cowbell.wav");
g(:,2)=[];                               % only keep one track
%sound(g,fs);
d = zeros(round(fs*.064),1);
g=cat(1,g,d);
fs
size(g);
g=cat(1,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g);
d = zeros(fs*7.2,1);
size(g)
size(d)
g=cat(1,d,g);
[r,fs] = audioread("reaper.m4a",[1,length(g)]);
sound(r+g,fs);
