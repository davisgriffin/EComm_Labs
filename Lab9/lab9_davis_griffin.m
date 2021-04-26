%% ECE 3770 - Lab 9 - DTMF Tones
%  G.Davis
%  4/26/2021

clc; clear; close all; % clear screen, variables, functions, close figures

%% Plotting Keypresses

load('dtmf.mat')
fs = 8000;
t = 0:1/fs:.04*20-1/fs;
figure
plot(t,dtmf)
title('DTMF Phone Number Signal')
xlabel('Time (sec)')
ylabel('Amplitude')
sound(dtmf,fs)

%% Determining Tone Frequencies

% I helped Ryan Haack formulate his for loop similarly to this one

digits = ones(320,1,10); G = digits; GM = G;
freq = ones(10,2);
n = length(G);
df = fs/n;
F = fs/2;
f = -F:df:F-df;

for i = 0:9
    digits(:,:,i+1) = dtmf(fs*.04*i*2 + 1: fs*.04*i*2 + 0.04*fs);
    G(:,:,i+1) = fft(digits(:,:,i+1));
    G(:,:,i+1) = fftshift(G(:,:,i+1));
    G(:,:,i+1) = G(:,:,i+1)./n;
    GM(:,:,i+1) = abs(G(:,:,i+1));
    [pks, locs] = findpeaks(GM(:,:,i+1));
    freq(i+1,:) = [f(locs(3)) f(locs(4))];
    
    figure
    plot(f,GM(:,:,i+1))
    hold on
    scatter(f(locs),pks,'filled')
    text(f(locs(3)+10), pks(3)+.02, sprintf("f = %d Hz",f(locs(3))))
    text(f(locs(4)+10), pks(4)-.02, sprintf("f = %d Hz",f(locs(4))))
    hold off
    ylim([0 0.6])
    title(strcat("FFT of Digit ",string(i+1)))
    ylabel("Amplitude")
    xlabel("Frequency (Hz)")
end

%% Look Up Phone Number

nums = [ 697 1209 ; 697 1336 ; 697 1477 ; ...
         770 1209 ; 770 1336 ; 770 1477 ; ...
         852 1209 ; 852 1336 ; 852 1477 ; 941 1366];

number = "";

for i = 1:10
    for j = 1:10
        if (all(~find((freq(i,:) > nums(j,:)-15)==0)) && (all(~find((freq(i,:) < nums(j,:)+15)==0))))
            number = strcat(number,string(j));
            break;
        end
    end
end

%% Plot with Phone Number

figure
plot(t,dtmf)
title(strcat("Phone Number: ",number))
xlabel("Time (sec)")
ylabel("Amplitude")