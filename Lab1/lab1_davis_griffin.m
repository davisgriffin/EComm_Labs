%% ECE 3770 - Lab 1
% G.Davis
% 2/5/2021

clc; clear; close all;

%% Part 1
% Generating and plotting x(t)

t = 0:0.01:2;
fun = @(x) exp(-2*x).*cos(2*pi*3*x);
x = fun(t);

figure(1)
plot(t,x); grid
xlabel('Time (sec)')
ylabel('Amplitude')
title(['x(t) = e^{-2t}cos(2\pi3t)'])

%% Part 2
% Finding the power of x(t)

N = length(x);
Ts = 2/N;
P = 0;

for n = 1:N
    P = P + x(n)^2 * Ts;
end

fprintf("Power of Signal x(t): %4.3f W\n\n",P/2);

%% Part 3
% Adding noise to x(t) and plotting varying results

xm5 = awgn(x,-5);
x0 = awgn(x,0);
x10 = awgn(x,10);

figure(9)
subplot(3,1,1), plot(t, x, 'Color', 'blue'); title('x(t) with SNR = -5 dB'); hold on
plot(t, xm5,  'Color', 'red'); hold off
subplot(3,1,2), plot(t, x, 'Color', 'blue'); title('x(t) with SNR = 0 dB'); hold on
plot(t, x0,  'Color', 'red'); hold off
subplot(3,1,3), plot(t, x, 'Color', 'blue'); title('x(t) with SNR = 10 dB'); hold on
plot(t, x10,  'Color', 'red'); hold off
ax = axes('Parent',figure(9),'visible','off');
ax.XLabel.Visible='on';
ax.YLabel.Visible='on';
xlabel(ax,'Time (sec)')
ylabel(ax,'Amplitude');

%% Part 4
% Making the ABC News audio clip inaudible

load abcnews;
snr = -10;
fs = 22000;

m2 = awgn(m,snr);
sound(m2,fs);
