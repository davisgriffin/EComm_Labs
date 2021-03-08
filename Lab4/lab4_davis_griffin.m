%% ECE 3770 - Lab 4 - Generation of FM Signals and FM Spectrum
%  G.Davis
%  3/8/21

clc; clear; close all; clear sound; % clear screen, variables, functions, close figures

%% Part 1
% Generate an FM wave with beta=2 for 1 second

% Generate a 100 Hz sinusoidal message
fs = 5000;
fm = 100;
fc = 1000;
beta = 2;

T = 1/fs;
t = 0:T:1-T;

msg = sin(2*pi*fm*t);

% Modulate with carrier fc=1kHz beta = 2
mfm = modulate(msg,fc,fs,'fm',2*pi*beta*fm/fs);

figure(1)
plot(t,mfm); grid minor
hold on
plot(t,msg,'LineWidth',2)
hold off
title('FM Signal')
xlabel('Time (sec)')
ylabel('Amplitude')
xlim([0 0.03])
ylim([-1.5 1.5])
legend('\beta = 2','Message')

%% Part 2
% Compute the sprectrum of the signal and display with proper labels.

G = fft(mfm);
n = length(G);
G = fftshift(G);

df = fs/n;
F = fs/2;
f = -F:df:F-df; % Ensuring frequency label is accurate
G = G./n;
GM = abs(G);

figure(2)
plot(f, GM); grid
title('FM Signal Spectrum')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
legend('\beta = 2')

%% Part 3
% Repeat parts 2 and 3 for beta = 5

beta = 5;
mfm = modulate(msg,fc,fs,'fm',2*pi*beta*fm/fs);

figure(3)
plot(t,mfm); grid minor
hold on
plot(t,msg,'LineWidth',2)
hold off
title('FM Signal')
xlabel('Time (sec)')
ylabel('Amplitude')
xlim([0 0.03])
ylim([-1.5 1.5])
legend('\beta = 5','Message')

G = fft(mfm);
n = length(G);
G = fftshift(G);
G = G./n;
GM = abs(G);

figure(4)
plot(f, GM); grid
title('FM Signal Spectrum')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
legend('\beta = 5')
