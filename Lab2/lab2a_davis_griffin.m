%% ECE 3770 - Lab 2
% G.Davis
% 2/8/2021

clc; clear; close all;

%% Part 1
load lab2data;

fs = 2000;
Ts = 1/fs;
t = 0:Ts:0.1-Ts;

% Plotting the given noisy data
figure(1)
plot(t,y); grid
title('Noisy Data')
ylabel('Amplitude')
xlabel('Time (sec)')

%% Part 2
% Performing fast fourier-transform to identify interference

% Taking half of the fft due to symmetry
n = length(y);
fty = fft(y);
fty = fty(1:n/2);

% Establishing the array of frequencies fft is returning
df = fs/n;
F = fs/2;
f = 0:df:F-df;

% Plotting the spectrum of frequency magnitudes in the signal
figure(2)
plot(f,abs(fty)); grid
title('FFT of the Noisy Data')
ylabel('Amplitude')
xlabel('Frequency (Hz)')

fprintf("Can see from the plot that the prominent signals are 100 Hz, 500 Hz, and 900 Hz");
