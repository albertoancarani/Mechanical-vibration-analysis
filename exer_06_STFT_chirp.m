clear, clc, close all

ts = 0:1/1e3:2;
f0 = 100;
f1 = 200;
xx = chirp(ts,f0,1,f1,"quadratic",[],"concave");

[pxx,freq]=pwelch(xx);
figure,plot(freq,10*log10(pxx))
% return

figure, plot(xx)
d = seconds(1e-3);
win = hamming(100,"periodic");
figure
stft(xx,d,Window=win,OverlapLength=98,FFTLength=128);

return
%% CWT
figure
Fs=1000;
cwt(xx,Fs)
% hold on
% hfig = gcf;
% % set parameters
% hfig.CurrentAxes.CLim = [-1 5];  % for scale between -20dBm and 30dBm
colormap('jet')
ylim([0 600])
return

print -dtiff -r300 stft_chirp