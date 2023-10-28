Fs = 10000;
time = tOscope; % Time vector
signal = vOscope;
% time = tArduino;
% signal = vArduino;
figure(1);
plot(time, signal,'-ob','LineWidth',2,'MarkerSize',4);
set(gca,'FontSize',22,'LineWidth',2);
xlabel('time (s)')
xlim([0 1])
ylabel('Amplitude (a.u.)');

[freq, amp]=MAE170fft(time, signal);

figure(2)
semilogy(freq, amp,'-ob','LineWidth',2,'MarkerSize',4);
set(gca,'FontSize',22,'LineWidth',2);
xlabel('frequency [Hz]')
ylabel('|FT|');

delta_t_avg= (tArduino(end)-0)/length(tArduino);
f_SAMP= 1/delta_t_avg;
f_nyquist = f_SAMP /2;

function [frequencyVar, amplitudeVar] = MAE170fft(tVar, yVar)
reps=length(tVar); % obtain number of samples
fs=1/mean(diff(tVar)); % calculate mean sampling rate
% calculate oscilloscope signal PSD
[PSD,f_psd] = periodogram(yVar,...
rectwin(reps),reps,fs,'onesided');
frequencyVar = f_psd;
amplitudeVar = sqrt(PSD);
end

