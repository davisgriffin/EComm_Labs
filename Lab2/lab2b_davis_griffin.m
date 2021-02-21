%% ECE 3770 - Lab 2b
% G.Davis
% 2/15/2021

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
fty = fty/n;
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

%% Part 3
% Design bandpass filter for each frequency to isolate tones and plot the
% frequency response

[b,a] = butter(2,[95 105]/(fs/2),"bandpass");
g100 = filter(b,a,y);

figure(3)
plot(t,g100)
title('100 Hz Bandpass Filter of Noisy Data')
ylabel('Amplitude')
xlabel('Time (sec)')

[h,w] = freqz(b,a);
HM = abs(h);
n=length(HM);
f = 0:F/n:F-F/n;
figure(4)
plot(f,20*log10(HM))
title('Frequency Response of 100 Hz Filter')
ylabel('Amplitude (dB)')
xlabel('Frequency (Hz)')

% ---------------------------------------

[b,a] = butter(2,[495 505]/(fs/2),"bandpass");
g500 = filter(b,a,y);

figure(5)
plot(t,g500)
title('500 Hz Bandpass Filter of Noisy Data')
ylabel('Amplitude')
xlabel('Time (sec)')

[h,w] = freqz(b,a);
HM = abs(h);
n=length(HM);
f = 0:F/n:F-F/n;
figure(6)
plot(f,20*log10(HM))
title('Frequency Response of 500 Hz Filter')
ylabel('Amplitude (dB)')
xlabel('Frequency (Hz)')

% ---------------------------------------

[b,a] = butter(2,[895 905]/(fs/2),"bandpass");
g900 = filter(b,a,y);

figure(7)
plot(t,g900)
title('900 Hz Bandpass Filter of Noisy Data')
ylabel('Amplitude')
xlabel('Time (sec)')

[h,w] = freqz(b,a);
HM = abs(h);
n=length(HM);
f = 0:F/n:F-F/n;
figure(8)
plot(f,20*log10(HM))
title('Frequency Response of 900 Hz Filter')
ylabel('Amplitude (dB)')
xlabel('Frequency (Hz)')

%% Part 4
% Filter the noisy data with the filters from part 3

g = g100 + g500 + g900;
figure(9)
plot(t,g)
title('100, 500, and 900 Hz tones combined')
ylabel('Amplitude')
xlabel('Time (sec)')