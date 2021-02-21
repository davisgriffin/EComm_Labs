%% example
close all; clear; clc;

%% Part 1 Create some Sine Waves and combine them
fs=22000;                  % Specify a sample rate (samples/sec).  I'll use 22000 samples per second.

dt=1/fs;                   % Calculate the sample time (delta time) for one sample.

T = 3;                     % We use big T to specify the total time of a sample in seconds.

t=0:dt:T-dt;               % Create a time array.
n = length(t);             % 66000 timepoints, so we'll have 66000 samples in g(t)

f1 = 10;                   % Create some frequency values for our sine waves (in Hertz)
f2 = 150;
f3 = 2000;

g1 = 2.0*sin(2*pi*f1*t);         % Calculate sine wave values
g2 = 0.5*sin(2*pi*f2*t);        % Calculate sine wave values
g3 = 0.2*sin(2*pi*f3*t);        % Calculate sine wave values

g = g1 + g2 + g3;

figure(1)
plot(t(1:2200),g(1:2200));grid;

%% Part 2 - Let's run an FFT, but this time, let's plot the negative side too

G = fft(g);       % run an fft on the data

n = length(G);     % 66000 frequency bins

G = fftshift(G);  % Shift the negative frequencies of the FFT.  I typically keep this in G, but you may prefer to use a new variable.
                  % We know that G(1) is 0Hz/DC so keep track of where it
                  % ends up! 
                  % [1 2 3 4 5 6]->[4 5 6 1 2 3]    [1 2 3 4 5 6 7]->[5 6 7 1 2 3 4]
                  
GM = abs(G);      % GM contains the magnitudes of G

df = fs/n;         % Calculate the frequency difference (delta frequency) for one bin.

F = fs/2;          % I'll use big F to specify the Nyquist frequency (the maximum frequency in our output)

f=-F:df:F-df;     % Create a frequency array for the axis.  Notice how for an even number of bins, Nyquist ends up on the negative side.

figure(2)
plot(f,GM)

%% Part 3 - Ok, time to fix the ftt output to correctly matches our input signal amplitudes

G = G./n;         % Divide by the number of samples (this is a byproduct of the fft algorithm)
GM = abs(G);      % GM contains the magnitudes of G

figure(3)
plot(f,GM)

%% Part 4 - What if it had been a DC Signal?

g = 0*t+100;
G = fft(g);       % run an fft on the data
G = fftshift(G);  % Shift the negative frequencies of the FFT.
G = G./n;         % Divide by the number of samples
GM = abs(G);      % GM contains the magnitudes of G
figure(4)
plot(f,GM)

%% Part 5 - Or just a single cosine curve?

g = 100*sin(2*pi*1000*t);
G = fft(g);       % run an fft on the data
G = fftshift(G);  % Shift the negative frequencies of the FFT.
G = G./n;         % Divide by the number of samples
GM = abs(G);      % GM contains the magnitudes of G
figure(5)
plot(f,GM)

%% Part 6 - Back to our original signals with time-domain amplitudes of 2, .5, .2 we correctly see frequency magnitudes of 1, .25, .1

g = g1 + g2 + g3;
G = fft(g);       % run an fft on the data
G = fftshift(G);  % Shift the negative frequencies of the FFT.
G = G./n;         % Divide by the number of samples
GM = abs(G);      % GM contains the magnitudes of G
figure(6)
plot(f,GM)

%% Part 7 - Let's create a lowpass butterworth filter and isolate our 10Hz Signal

fc = 50;                             % cutoff frequency of 50
order = 2;                           % 2nd order filter

Wn = fc/(fs/2);                      % For digital filters, the cutoff frequencies must lie between 0 and 1, 
                                     % where 1 corresponds to the Nyquist rate

[b,a] = butter(order,Wn,"low");      % create transfer function coefficients

y = filter(b,a,g);                   % apply the filter to our data

figure(7)
subplot(211);plot(t,g)
subplot(212);plot(t,y)

%% Part 8 - Plot the frequency response of the filter in decibels

% provides a normalized frequency
figure(8)
freqz(b,a);

% need to set up axes with actual frequencies
[h,w] = freqz(b,a);
HM = abs(h);
figure(9)
n=length(HM);
f=0:11000/n:11000-(11000/n);
%F = fs/2;
%f = 0:F/n:F-F/n
plot(f,20*log10(HM))

figure(10)
plot(f(1:5),20*log10(HM(1:5))); grid % can see 50 Hz at -3 db

