clc
clear variables
close all

%% SEGNALE RANDOM STAZIONARIO

% carico i dati del primo esperimento
load FINAL_G2_1.mat

%% PLOT NEL DOMINIO DEI TEMPI

% calcolo l'asse dei tempi
x_17 = (C17_A01.x_values.start_value:C17_A01.x_values.increment:(C17_A01.x_values.number_of_values-1)*C17_A01.x_values.increment)';

% salvo le misure di accelerazione lette dal sensore di eccitazione
y_17 = C17_A01.y_values.values;

% salvo le misure di accelerazione lette dal sensore di risposta
y_18 = C18_A_G2.y_values.values;

% plotto i segnali misurati nel dominio dei tempi sovrapposti uno
% sull'altro
figure(1)
plot(x_17,y_17,'b')
grid on
xlabel('Tempo [s]')
ylabel('Accelerazione [g]')
title('Prova 1 - Dominio del tempo')
hold on
zoom on
plot(x_17,y_18,'r')
legend('C17 - Eccitazione', 'C18 - Risposta')

% plotto i segnali del dominio dei tempi separatamente
figure(2)
% segnale di eccitazione
subplot(2,1,1)
plot(x_17,y_17,'b')
grid on
xlabel('Tempo [s]')
ylabel('Accelerazione [g]')
title('Prova 1 - Dominio del tempo', 'Eccitazione (C17)')
hold on
zoom on
legend('C17 - Eccitazione')

% segnale di risposta
subplot(2,1,2)
plot(x_17,y_18,'r')
grid on
xlabel('Tempo [s]')
ylabel('Accelerazione [g]')
title('Prova 1 - Dominio del tempo', 'Risposta (C18)')
hold on
zoom on
legend('C18 - Risposta')

%% ANALISI NEL DOMINIO DEL TEMPO

% analisi del segnale di eccitazione C17
disp(['Media del segnale C17: ', num2str(mean(y_17)), ' g'])
disp(['Valore efficace del segnale C17: ', num2str(rms(y_17)), ' g'])
disp(['Deviazione standard del segnale C17: ', num2str(std(y_17)), ' g'])
disp(['Skewness standardizzata del segnale C17: ', num2str(skewness(y_17))])
disp(['Curtosi standardizzata del segnale C17: ', num2str(kurtosis(y_17))])

% analisi del segnale di risposta C18
disp(' ')
disp(['Media del segnale C18: ', num2str(mean(y_18)), ' g'])
disp(['Valore efficace del segnale C18: ', num2str(rms(y_18)), ' g'])
disp(['Deviazione standard del segnale C18: ', num2str(std(y_18)), ' g'])
disp(['Skewness standardizzata del segnale C18: ', num2str(skewness(y_18))])
disp(['Curtosi standardizzata del segnale C18: ', num2str(kurtosis(y_18))])

% calcolo la cross-correlazione tra l'uscita e l'ingresso
[Rxy, lag] = xcorr(y_18, y_17);

% plotto la cross-correlazione
figure(3)
plot(lag, Rxy)
hold on
grid on
xlabel('Lag')   % generico sfasamento (tau) tra i 2 segnali
title('Cross-correlazione')
ylabel('R_{xy}')

%% DOMINIO DELLE FREQUENZE - PSD

% frequenza di campionamento [Hz]
Fs = 4096;
% numero di campioni che compongono i segmenti del segnale
NFFT = round(C18_A_G2.x_values.number_of_values/4);

% eseguiamo la power spectral density (PSD) del segnale risposta (C18)
[y_psd_18, ~] = pwelch(y_18, hanning(NFFT), NFFT/2, NFFT, Fs);

% eseguiamo la power spectral density (PSD) del segnale eccitazione (C17)
[y_psd_17, freq] = pwelch(y_17, hanning(NFFT), NFFT/2, NFFT, Fs);

% plotto la PSD dell'eccitazione (C17) in un grafico semilogaritmico
figure(4)
plot(freq, 10*log10(y_psd_17),'b')
grid on
hold on
zoom on
title('Prova 1 - Dominio della frequenza', 'Periodogramma - PSD - Eccitazione (C17)')
xlabel('Frequenza [Hz]')
ylabel('Ampiezza [dB]')
legend('C17 - Eccitazione')

% plotto la PSD della risposta (C18) in un grafico semilogaritmico
figure(5)
plot(freq, 10*log10(y_psd_18),'r')
grid on
hold on
zoom on
title('Prova 1 - Dominio della frequenza', 'Periodogramma - PSD - Risposta (C18)')
xlabel('Frequenza [Hz]')
ylabel('Ampiezza [dB]')
legend('C18 - Risposta')