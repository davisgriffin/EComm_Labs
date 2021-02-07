%% ECE 3770 - Lab 1
% G.Davis
% 2/5/2021

clc; clear; close all;

%% Part 1
% Create a discrete-time sine wave

t = 0:0.2:2;                % Array of time values from 0s to 2s in 0.02s increments

fun = @(x) 5*sin(x);        % Create a function that returns 5*sin(input)

v = fun(t);                 % Run the function with the time values as inputs and displays the data

v = fun(2*pi*t);            % Normalize so that 1s gives 1 cycle of the sine wave

%% Part 2
% Display our discrete-time sine wave

plot(t,v);                  % Plot the data

t = 0:0.02:2;               % Redefine t with a smaller increment for a smoother wave

v = fun(2*pi*t);            

plot(t,v);                  % Plot higher resolution sine wave

%% Adding Noise

snr = 10;                   % Signal to noise ratio

fprintf("Signal to Noise Ratio: %4.3f \n\n",snr);

v_noisy = awgn(v,snr);      % Uses predefined function awgn to add noise to signal v with ratio snr

plot(t,v_noisy);            % Plot noisy signal

%% Part 3
% Load in an audio sample file

whos('-file','abcnews.mat') % Displays .mat file information 

load abcnews;               % Loads .mat file into array m (from whos)

n = length(m);              % Length of .mat file

fs=22000;                   % Sampling frequency

T = n/fs;                   % Specifies the total time of the sample

dt = 1/fs;                  % Change in time, could also find T = n*dt

t = 0:dt:T-dt;              % Create the time array for this sample

figure(2)
plot(t,m); grid             % Plot the sample with gridlines

m2 = m*(1/4);               % Change amplitude to 1/4 the original

figure(3)
plot(t,m2); grid            % Plot new sample with gridlines

% sound(m,fs);                % Listen to the original audio sample
% pause(T);                   % Delay
% sound(m2,fs);               % Play quarter volume signal
% pause(T);

fun = @(x) abs(sin(x));     % Positive sine of a number

s = fun(2*pi*t);            % Create a sine wave

figure(4)
plot(t,s); grid             % Much higher resolution sine wave than before

m3 = m.*s;                  % Multiplies each value of the sample by the corresponding index in the sine wave

figure(5)
plot(t,m3); grid            % New audio sample combined with sine wave
% Creates "pulses" of volume along the audio sample

% sound(m3,fs);
% pause(T);

%% Part 4
% Clean up the last figure

set(gca,'fontsize',18)      % gca gives the handle of the currently active axes object
xlabel('Time (sec)')
ylabel('Amplitude')
title(['ABC News clip modulatated'])

%% Part 5
% Create a multiplot of the modulated signal and sine wave

multiPlot = figure(6);      % Stores figure(6)
ax1 = axes('Parent', multiPlot);
hold(ax1, 'on');            % Hold so that the following changes also apply to this figure
plot(t, m3, 'Color', 'blue');
plot(t, s,  'Color', 'red');
title(ax1, 'Example of a Multi-plot');
hold(ax1, 'off');

%% Part 6
% Create a subplot
figure(7)
subplot(3,1,1), plot(t,m);grid  % (3, 1, 1) denotes column 1, row 1 of 3 row plot
subplot(3,1,2), plot(t,s);grid
subplot(3,1,3), plot(t,m3);grid

