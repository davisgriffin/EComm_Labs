%% ECE 3770 - Lab 3 - Sample Exercises
%  E.Berde
%  2/22/2021

clc; clear; close all; clear sound;% clear screen, variables, functions, close figures
%% Part 1 - Obtain and investigate a royalty free mp3
% An Epic Story by MaxKoMusic | https://maxkomusic.com/
% Music promoted by https://www.free-stock-music.com
% Creative Commons Attribution-ShareAlike 3.0 Unported
% https://creativecommons.org/licenses/by-sa/3.0/deed.en_US

% [g,fs] = audioread("country.mp3",[1,441000]);
[g, fs] = audioread('country.mp3');

% Transpose and create mono channel for faster operation
g = 0.5*transpose(g(:,1));
sz = size(g)               % Shows size [x 2] where 2 is from left/right channels
% g=g(1:441000,1);           % Isolating only one Left/Right Channel


sz = size(g)
sound(g,fs)
% g=.2*g;                    % Lowering the volume
n=length(g)                

T = n/fs                   % We use big T to specify the total time of a sample.  It can be calcualted from the number of samples divided by the samples/sec.

dt=1/fs; T = n*dt          % Alternately, we could have calculated the sample time (delta time) for one sample, then multipled by the number of samples to find the total time.

t=0:dt:T-dt;               % Let's create a corresponding time array.  Be careful, array size needs to match or you'll get an error when plotting the data.
sz = size(t)
figure(1)
plot(t,g); grid

% g is 441000 x 1 and time is 1 x 441000
% this is fine except for multiplying to create a carrier frequency
% so need to transpose

% g = transpose(g);

%% Part 2 - Let's run an FFT

G = fft(g);       % run an fft on the data

n = length(G)    

G = fftshift(G);  % Shift the negative frequencies of the FFT.  I typically keep this in G, but you may prefer to use a new variable.
                  % We know that G(1) is 0Hz/DC so keep track of where it
                  % ends up! 
                  % [1 2 3 4 5 6]->[4 5 6 1 2 3]    [1 2 3 4 5 6 7]->[5 6 7 1 2 3 4]
                  
df = fs/n         % Calculate the frequency difference (delta frequency) for one bin.

F = fs/2          % I'll use big F to specify the Nyquist frequency (the maximum frequency in our output)

f=-F:df:F-df;     % Create a frequency array for the axis.  Notice how for an even number of bins, Nyquist ends up on the negative side.

G = G./n;         % Divide by the number of samples (this is a byproduct of the fft algorithm)
GM = abs(G);      % GM contains the magnitudes of G

figure(3)
plot(f,GM)
%% Part 3 - Ok, let's modulate using a 20k signal with an amplutude of 4

f1 = 20000;

c = 4.0*cos(2*pi*f1*t);         % Calculate carrier signal

s=g+1;
s=s.*c;

figure(4)
plot(t,s); grid
sm=abs(s);
smax=max(sm)
