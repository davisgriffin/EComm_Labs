%% ECE 3770 - Lab 8 - Matched Fitlering
%  G.Davis
%  4/19/2021

clc; clear; close all; % clear screen, variables, functions, close figures

%% Square Pulse Filter

f = [ones(1,10) zeros(1,5)];
t1 = 0:1:length(f)-1;
figure
stem(t1, f)
title("Original Square Pulse")
ylabel("Amplitude")
xlabel("Time (sec)")
ylim([0 2])
% impulse response is the same as f
g = conv(f,f);
t2 = 0:1:length(g)-1;
figure
stem(t2,g)
title("Output of Matched Filter, Task 1")
ylabel("Amplitude")
xlabel("Time (sec)")
xlim([0 19])
% The peak is at (9,10) because when the pulses are one on
% top of the other, it will result in the sum of 1*1
% 10 times over, equaling 10, at the 10th point.
% (9th point because to = 0s)

%% Gaussian Noise on Pulse
i = 1;

for SNR= -5:5:25
    x_n= [awgn(f(1:10),SNR,'measured') zeros(1,5)];
    g_n=conv(x_n,x_n);
    
    noise = x_n-f;
    snrout(i) = snr(x_n,noise);
    i = i + 1;
    
    fig = figure;
    subplot(211); stem(t1,x_n)
    ylim([min(x_n)-1 max(x_n)+1])
    subplot(212); stem(t2,g_n)
    title("Output for Noisy Input Above")
    xlim([0 19])
    
    han=axes(fig,'visible','off'); 
    han.Title.Visible='on';
    han.XLabel.Visible='on';
    han.YLabel.Visible='on';
    ylabel(han,'Amplitude');
    xlabel(han,'Time (sec)');
    title(han,strcat("Task 2 SNR: ",string(SNR)));
end

%% Task 3 - SNR Ratio
snrin = -5:5:25;

figure
plot(snrin,snrout)
hold on
plot(snrin,snrin)
title("Input SNR vs. Matched Filter SNR")
xlabel("Input SNR")
ylabel("Output SNR")
legend("Output vs. Input","Guide")

%% Task 4 - SNR Improvement
improvement = snrout-snrin;

figure
plot(snrin,improvement)
title("Improved SNR vs. Input SNR")
xlabel("Input SNR")
ylabel("Improved SNR")