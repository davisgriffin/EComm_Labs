%% ECE 3770 - Lab 3
%  G.Davis
%  2/28/2021

clc; clear; close all; clear sound;

%% Part 1
% Playing and plotting the .mp3

[g, fs] = audioread('country.mp3');

% Transpose and create mono channel for faster operation
g = 0.8*transpose(g(:,1));

% sound(g,fs);

T = 1/fs;
t = 0:T:(length(g)/fs)-T;

% Values for zoomed in plots
t1 = 500000;
t2 = 505000;

figure(1)
plot(t,g)
title('Country Guitar Pickin''')
xlabel('Time (sec)')
ylabel('Amplitude')

figure(2)
plot(t(1,t1:t2),g(1,t1:t2))
title('Country Guitar Pickin'' Zoomed')
xlabel('Time (sec)')
ylabel('Amplitude')

%% Part 2
% Modulating the signal with a carrier frequency

fc = 10000;
s = 10.*(1+0.5.*g).*cos(2*pi*fc*t);

figure(3)
plot(t,s)
title('Country Guitar Pickin'' Modulated')
xlabel('Time (sec)')
ylabel('Amplitude')

figure(4)
plot(t(1,t1:t2),s(1,t1:t2))
title('Country Guitar Pickin'' Modulated Zoomed')
xlabel('Time (sec)')
ylabel('Amplitude')

% Perform fft on signal without modulating
G = fft(g);
G = fftshift(G);
G = G./length(G);
GM = abs(G);

% Perform fft on signal with k_a = 0.5
S = fft(s);
S = fftshift(S);
df = fs/length(S);
F = fs/2;

f= -F:df:F-df;

S = S./length(S);   % Remove relativity of requency
SM = abs(S);        % Get magnitudes of G

figure(5)
plot(f,GM); grid
title('Frequency Response Without Modulation')
xlabel('Frequency (Hz)')
ylabel('Amplitude')

figure(6)
plot(f,SM); grid
title('Frequency Response with k_a = 0.5')
xlabel('Frequency (Hz)')
ylabel('Amplitude')

%% Part 3
smax = max(abs(s));
smin = 10-(smax-10);

mu = (smax-smin)/(smax+smin);
fprintf('The estimated modulation index for ka=0.5 is %.3f\n\n',mu);

%% Part 4
% Modifying k_a to maximize modulation index

s = 10.*(1+1.35.*g).*cos(2*pi*fc*t);
smax = max(abs(s));
smin = 10-(smax-10);

mu = (smax-smin)/(smax+smin);
fprintf('The estimated modulation index for ka=1.35 is %.3f\n\n',mu);