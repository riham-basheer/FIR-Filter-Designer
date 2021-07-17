%%% Applying Designed filter to a signal with
% a high frequency background noise.
% First, you need to run the program put the following parameters
% and click save. Save the filter with the name hd and then run this
% file

%%% Parameters: no.of taps = 54
%%% fs = 44100 Hz .. fc = 11665 Hz
%%% Design Method: windowed-sinc .. window type: Blackman

close all;
[y, fs] = audioread('noisy_signal.wav');
soundsc(y, fs);                         % Play the noisy signal
pause(4)

% Plotting fd before filtering
l = length(y);
n = 2^(nextpow2(l));
y_fft = abs(fft(y, n));
freq = fs/2000*linspace(0, 1, n/2+1);
figure
subplot(2, 1, 1)
plot(freq, y_fft(1:length(freq)));
axis tight;
xlabel('Frequency (Hz)');  ylabel('Magnitude');
title('Frequency-Domain Diagram Before Filtering');

% Plotting fd after filtering
out = filtfilt(hd, 1, y);
sound(out, fs)                           % Play filtered signal
audiowrite('filtered_signal.wav', out, fs);
out_fft = abs(fft(out, n));
subplot(2, 1, 2)
plot(freq, out_fft(1:length(freq)));
axis tight;
xlabel('Frequency (Hz)');  ylabel('Magnitude');
title('Frequency-Domain Diagram After Filtering');







% This is filter coeff.:
% hd = [    0   -0.0000    0.0000    0.0002   -0.0001   -0.0005    0.0004    0.0010 
%     -0.0011   -0.0018    0.0025    0.0026   -0.0051   -0.0033    0.0092    0.0032
%     -0.0154   -0.0016    0.0244   -0.0031   -0.0375    0.0136    0.0585   -0.0381
%     -0.1042    0.1265    0.4695    0.4695    0.1265   -0.1042   -0.0381    0.0585
%      0.0136   -0.0375   -0.0031    0.0244   -0.0016   -0.0154    0.0032    0.0092
%     -0.0033   -0.0051    0.0026    0.0025   -0.0018   -0.0011    0.0010    0.0004
%     -0.0005   -0.0001    0.0002    0.0000   -0.0000         0]