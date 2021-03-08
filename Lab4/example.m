%% ECE 3770 - Lab 4 - Sample Exercises
%  E.Berde
%  3/1/2021

clc; clear; close all; clear sound; % clear screen, variables, functions, close figures
%% Part 1 - First I'll create a DSB signal manually without using the modulate function
% Note that I'm using an AM signal for this demo, but in the lab you'll create an FM signal.
% You do NOT have to create that FM signal manually, I'm just doing this for a demo comparison!

fs=5000;                   % Specify a sample rate (samples/sec).  I'll use 5000 samples per second.

dt=1/fs;                   % Calculate the sample time (delta time) for one sample.

T = .1;                    % We use big T to specify the total time of our signal in seconds.

t=0:dt:T-dt;               % Create a time array.
g = .8*sin(2*pi*39*t);    % Create an input message.  I'll use a 39Hz tone.

c = 3*sin(2*pi*520*t);    % Create a carrier signal.  I'll use a 520Hz carrier freqency.

s = (1+g).*c;              % DSB-FC modulation (Matlab calls this 'amdsb-tc' for 'Amplitude modulation, double sideband, transmitted carrier')
g(1)
s(1)
t(1)
length(g)
length(s)
figure(1);
plot(t,s);                 % should range from Amax=5.4 to Amin=.6

%% Part 2 - Explore the matlab modulate function
% I'll use the matlab modulate function to produce an AM signal, but in 
% the lab you'll use it to create an FM signal.

mfm = 3*modulate(g,520,5000,'amdsb-tc',-1);  % message signal, carrier frequency, sample rate, method, options (for amdsb-tc the option 'Subtracts a scalar' from the message signal before using it to modulate the carrier)
mfm(1)
length(mfm)
length(s)
figure(2);
plot(t,mfm);                 % Should be identical to Part 1

%% Part 3 - FFT Analysis of our royalty free mp3
% An Epic Story by MaxKoMusic | https://maxkomusic.com/
% Music promoted by https://www.free-stock-music.com
% Creative Commons Attribution-ShareAlike 3.0 Unported
% https://creativecommons.org/licenses/by-sa/3.0/deed.en_US

[g,fs] = audioread("epic.mp3",[1,10*44100]);
fs
%sound(g,fs)
g=g(:,1);                  % Isolating only one Left/Right Channel
sz = size(g)
g = transpose(g);
sz = size(g)
n=length(g);                
T = n/fs;                  % We use big T to specify the total time of our signal.  It can be calculated from the number of samples divided by the samples/sec.
dt=1/fs; T = n*dt;         % Alternately, we could have calculated the sample time (delta time) for one sample, then multiplied by the number of samples to find the total time.
t=0:dt:T-dt;               % Let's create a corresponding time array.  Be careful, array size needs to match or you'll get an error when plotting the data.
sz = size(t)
figure(3)
plot(t,g); grid

%% Part 4 - Let's run an FFT

G = fft(g);       % run an fft on the data
n = length(G);    
G = fftshift(G);  % Shift the negative frequencies of the FFT.  
df = fs/n;        % Calculate the frequency difference (delta frequency) for one bin.
F = fs/2;         % I'll use big F to specify the Nyquist frequency (the maximum frequency in our output)
f=-F:df:F-df;     % Create a frequency array for the axis.  Notice how for an even number of bins, Nyquist ends up on the negative side.
G = G./n;         % Divide by the number of samples (this is a byproduct of the fft algorithm)
GM = abs(G);      % GM contains the magnitudes of G
figure(4)
plot(f,GM)

%% Part 5 - Let's look at the power spectrum
% pwelsh plots the power spectral density as a function of frequency
% Note that pwelsh plots the one-sided power spectral density

figure(5)
pwelch(g,[],[],[],fs)              % pwelch shows power spectral density, displays output in dB/Hz, and labels the frequency axis - very convenient!
                                   % 1st input is your signal
                                   % 2nd input is the window length - increase to get better resolutions
                                   % 3nd input is the overlap between segments - Matlab defaults to 50% overlap between segments
                                   % 4nd input is a list of frequencies to evaluate - defaults from 0 to Nyquist  
                                   % 5th input is the sample frequency
