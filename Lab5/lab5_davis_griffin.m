%% ECE 3770 - Lab 5 - Creating the "Red Alert" Alarm
%  G.Davis
%  3/17/21

clc; clear; close all; clear sound;

%% Part 1
% Download .wav file

%% Part 2
% Import the first three seconds and one channel, plot and play

[g, fs] = audioread('625msljet.wav');

% Transpose and create mono channel for faster operation
g = 0.5*transpose(g(:,1));
g = g(1:3*fs);

sound(g,fs);
pause(3);

T = 1/fs;
t = 0:T:3-T;

figure(1)
plot(t,g)
title('Jettison Alarm')
xlabel('Time (sec)')
ylabel('Amplitude')

%% Part 3
% Analyzing the spectrogram of the file

figure(2)
spectrogram(g,256,250,256,fs,'yaxis')
fprintf("The spectrogram shows many chirps, but 6-7 prominent ones, sweeping in half second intervals");

%% Part 4
% Recreating the alarm based on the spectrogram values

% Creating the half second time array
ta = 0:T:0.5;
f1 = [ 2000, 4000, 6500, 9000, 11000 ]; % different chirp final frequencies

% Using logarithmic to more closely match the spectrogram
chirp1 = chirp(ta,20,0.5,f1(1),'li');
chirp2 = chirp(ta,20,0.5,f1(2),'li');
chirp3 = chirp(ta,20,0.5,f1(3),'li');
chirp4 = chirp(ta,20,0.5,f1(4),'li');
chirp5 = chirp(ta,20,0.5,f1(5),'li');

chirpt = chirp1 + chirp2 + chirp3 + chirp4 + chirp5;

alarm = [chirpt chirpt chirpt chirpt chirpt];
alarm = 0.1*alarm;
sound(alarm, fs);

figure(3)
spectrogram(alarm,256,250,256,fs,'yaxis')

% Logarithmic component of the original signal difficult to reproduce,
% this reproduced signal can still serve for an alarm, however