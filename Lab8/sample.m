%% ECE 3770 - Lab 8 - Matched Fitlering - Info
%  E.Berde
%  4/12/2021

clc; clear; close all; % clear screen, variables, functions, close figures

%% xcorr vs conv
% conv automatically flips a signal before the process
% xcorr does not flip

x = [ 0 1 2 3 4 5 6 7 8 9 ];
h = fliplr(x);
y = xcorr(x,h);
figure(1)
plot(y)
title('Flip & xcorr')

y = conv(x,x);
figure(2)
plot(y)
title('Conv')
% They are the same!

%% Adding Noise to a signal

fs=5000;                   % Specify a sample rate (samples/sec).  I'll use 5000 samples per second.

dt=1/fs;                   % Calculate the sample time (delta time) for one sample.

T = .1;                    % We use big T to specify the total time of our signal in seconds.

t=0:dt:T-dt;               % Create a time array.

g = .8*sin(2*pi*39*t);    % Create an input message.  I'll use a 39Hz tone.

c = 3*sin(2*pi*520*t);    % Create a carrier signal.  I'll use a 520Hz carrier freqency.

s = (1+g).*c;              % DSB-FC modulation (Matlab calls this 'amdsb-tc' for 'Amplitude modulation, double sideband, transmitted carrier')

figure(3);
plot(t,s);

% for SNR=10:5:20
SNR=5;
    x_n=awgn(s,SNR,'measured');
    noise=x_n-s;
    figure
    plot(t,s);
    title(strcat('SNR db: ',string(SNR)))
    hold on
    plot(t,x_n);
    hold on
    plot(t,noise);
    hold off
% end