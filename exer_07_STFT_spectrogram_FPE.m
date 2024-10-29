clear, clc, close all

load('M1_R003.mat');

aa=C8_P6.y_values.values;
Fs=1/C8_P6.x_values.increment;
tim=(0:1/Fs:(length(aa)-1)/Fs);

figure(1), hold on
xlabel('Time [s]')
ylabel('Acceleration [g]')

plot(tim,aa)
grid, box on
print -dtiff -r300 FPE_RAMP
%% PSD
NFFT=round(length(aa)/50);
[pxx,freq]=pwelch(aa,hanning(NFFT),round(NFFT/5),NFFT,Fs);
figure(2),plot(freq,10*log10(pxx))
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')
grid, box on

% return
%% STFT
seg=round(size(aa,1)/(32*1));
figure
spectrogram(aa,hanning(seg),floor(seg*0.95),seg,Fs,'yaxis');
% spectrogram(aa,hanning(seg),floor(seg*0.5),seg,Fs,'yaxis');
hold on
hfig = gcf;
% set parameters
hfig.CurrentAxes.CLim = [-35 -5];  % for scale between -20dBm and 30dBm
% xlim([10 12])
colorbar off
colormap('jet')

return
figure
cwt(aa,Fs)
hold on
hfig = gcf;
% set parameters
hfig.CurrentAxes.CLim = [-1 5];  % for scale between -20dBm and 30dBm
% xlim([10 12])
colormap('jet')




