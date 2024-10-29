clear, clc, close all
Fs=8192;
tt=(0:1/Fs:(10-1/Fs))';
f0=11; %[Hz]
f0bis=linspace(11,50,Fs*10)';
f1=133; %[Hz]
phi1=0.13; %[rad]
f2=203; %[Hz]
phi2=0.1; %[rad]
f3=711; %[Hz]
phi3=0.33; %[rad]
xx=(1.5*sin(2*pi*f1*tt+phi1));
rumore=(rand([8192*10,1])-0.5)*0.005;

figure(1), hold on
plot(tt,xx);

NFFT=length(xx)/5;
[Pxx,freq]=pwelch(xx,hanning(NFFT),NFFT/2,NFFT,Fs);

figure(2), hold on
% plot(freq,(Pxx))
plot(freq, 10*log10(Pxx))

yy=xx+0.3*sin(2*pi*f2*tt+phi2);
figure(1)
plot(tt,yy)

[Pxx,freq]=pwelch(yy,hanning(NFFT),NFFT/2,NFFT,Fs);
figure(2)  % PSD con finestratura di hanning
% plot(freq,(Pxx))
plot(freq, 10*log10(Pxx))

yy2=yy+0.13*sin(2*pi*f3*tt+phi3); %*0.13 perchè freq elevate hanno ampiezze minori
figure(1)
plot(tt,yy2)

[Pxx,freq]=pwelch(yy2,hanning(NFFT),NFFT/2,NFFT,Fs);% aggiungo altre 2 frequenze
figure(2)
% plot(freq,(Pxx))
plot(freq, 10*log10(Pxx))
% return

%% RUMORE + MODULAZIONE SEMPLICE --> ABILITA MODULAZIONE SEMPLICE
% modulazione=0;
% modulazione=0.09*cos(2*pi*f0*tt);
modulazione=0.09*cos(2*pi*f0bis.*tt);
yy3=(1+modulazione).*yy2+rumore;
figure(1)
plot(tt,yy3)
%aggiungo il rumore
[Pxx,freq]=pwelch(yy3,hanning(NFFT),NFFT/2,NFFT,Fs);
figure(2)
plot(freq, 10*log10(Pxx)) %plotto il logaritmo con gli assi lineari
%potevo plottare in un diagramma logaritmico
figure(3)
plot(yy3)
xlim([0 0.7e4])

% return

%noto che ora ho 3 bande le 2 bande laterali sono dovute alla modulazione

%% modulazione con RAMPA --> MODIFICA MODULAZIONE
% yy3bis=sin(2*pi*f0bis.*tt);
yy3bis=(1+modulazione).*yy2+rumore+sin(2*pi*f0bis.*tt);
figure, plot(tt,yy3bis)

[Pxx,freq]=pwelch(yy3bis,hanning(NFFT),NFFT/2,NFFT,Fs);
figure(2)
plot(freq, 10*log10(Pxx))




