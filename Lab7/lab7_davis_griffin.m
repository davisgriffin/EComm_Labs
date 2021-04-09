%% ECE 3770 - Lab 7 - Nyquist
%  G.Davis
%  4/7/21

clc; clear; close all; clear sound;

%% Part 1 -- Sampled Data
load('sampled.mat');

figure(1)
scatter(t, x1,'filled','r'); grid minor
title("Undersampled Signal")
xlabel("Time (sec)")
ylabel("Amplitude")
xlim([0 1])
ylim([-3 3])

%% Part 2 -- Finding the Aliased Frequency
fs = 1 / ( t(2) - t(1) );
G = fft(x1);
n = length(G);
G = fftshift(G);
G = G./n;
GM = abs(G);

df = fs/n;
F = fs/2;
f = -F:df:F-df;

figure(2)
plot(f, GM); grid on
hold on
scatter([-2 2],[0.5 0.5],'filled','r')
hold off
title("Spectrum")
ylabel("Amplitude")
xlabel("Frequency (Hz)")
legend("Spectrum","f_a = 2 Hz")
% Plot shows fa = 2 Hz
% fa = |f - Nfs|, 2 = |f - 1*12|, f = 10 Hz

%% Part 3 -- Superimpose Original Signal

figure(3)
scatter(t, x1,'filled','r')
hold on
t = 0:1/60:3; % f = 60 Hz = 2*30 (fmax)
s = cos(2*pi*10*t) + cos(2*pi*30*t);
plot(t, s,'c'); grid minor
hold off
title("Signal s(t)")
ylabel("Amplitude")
xlabel("Time (sec)")
xlim([0 1])
ylim([-3 3])
legend("Undersampled","Original")
