clear,clc,close all
load('LAV13.mat');
figure(1),plot(C5_27157_z_T1Z.y_values.values)
Fs=1/C5_27157_z_T1Z.x_values.increment
aa=(C5_27157_z_T1Z.y_values.values(7*1e4:13*1e4));
figure(2),plot(aa)

NFFT=round(length(aa)/10);
[pxx,freq]=pwelch(aa,hanning(NFFT),round(NFFT/5),NFFT,Fs);
figure(3),plot(freq,10*log10(pxx))


% return
Ftaglio1=1000; %Hz
[b,a]=butter(16,Ftaglio1/(Fs/2),"low");
figure
freqz(b,a,[],Fs);
yy1=filtfilt(b,a,aa);


figure(2), hold on
plot(yy1)
hold off

lpFilt = designfilt('lowpassfir','PassbandFrequency',Ftaglio1/(Fs/2), ...
         'StopbandFrequency',0.35,'PassbandRipple',0.5, ...
         'StopbandAttenuation',65,'DesignMethod','kaiserwin');
% fvtool(lpFilt)
yy2=filtfilt(lpFilt,aa);

figure(2), hold on
plot(yy2)
hold off

[pxx1,freq]=pwelch(yy1,hanning(NFFT),round(NFFT/5),NFFT,Fs);
[pxx2,freq]=pwelch(yy2,hanning(NFFT),round(NFFT/5),NFFT,Fs);

figure(3),hold on
plot(freq,10*log10(pxx1))
plot(freq,10*log10(pxx2))




