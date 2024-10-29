clc
clear variables
close all

%% SEGNALE SINUSOIDALE NON-STAZIONARIO AD AMPIEZZA E FREQUENZA VARIABILI

% carico i dati del secondo esperimento
load FINAL_G2_2.mat

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
title('Prova 2 - Dominio del tempo')
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
title('Prova 2 - Dominio del tempo', 'Eccitazione (C17)')
hold on
zoom on
legend('C17 - Eccitazione')

% segnale di risposta
subplot(2,1,2)
plot(x_17,y_18,'r')
grid on
xlabel('Tempo [s]')
ylabel('Accelerazione [g]')
title('Prova 2 - Dominio del tempo', 'Risposta (C18)')
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

%% ANALISI NEL DOMINIO TEMPO-FREQUENZA - STFT - SPETTROGRAMMA - C18

% frequenza di campionamento [Hz]
Fs = 4096;

% divideremo il segnale in segmenti;
% numero di campioni di cui sono composti i vari segmenti
seg = round(C18_A_G2.x_values.number_of_values/(32*1));

% plottiamo lo spettrogramma del segnale (cioè il risultato della 
% Short-Time Fourier Transform STFT)
figure(4)
spectrogram(y_18, hanning(seg), floor(seg*0.95), seg, Fs, 'yaxis');
hold on
% crea un puntatore per la figura
hfig = gcf;
% definisco i limiti dell'asse z (tra -100 e 20 dB)
hfig.CurrentAxes.CLim = [-100 20];  
% cambia i colori del grafico
colormap('jet')
title('Prova 2 - Dominio tempo-frequenza', 'STFT - Spettrogramma - Risposta (C18)')

%% ANALISI NEL DOMINIO TEMPO-FREQUENZA - CWT - SCALOGRAMMA - C18

% plottiamo i risulati della Continuous Wavelet Transform (CWT)
figure(5)
cwt(y_18, Fs)
hold on
% crea un puntatore per la figura
hfig = gcf;
% definisco i limiti dell'asse z (tra 0 e 5 dB)
hfig.CurrentAxes.CLim = [0 5];  
% cambia i colori del grafico
colormap('jet')
title('Prova 2 - Dominio tempo-frequenza', 'CWT - Scalogramma - Risposta (C18)')

%% ANALISI NEL DOMINIO TEMPO-FREQUENZA - STFT - SPETTROGRAMMA - C17

% frequenza di campionamento [Hz]
Fs = 4096;

% divideremo il segnale in segmenti;
% numero di campioni di cui sono composti i vari segmenti
seg = round(C18_A_G2.x_values.number_of_values/(32*1));

% plottiamo lo spettrogramma del segnale (cioè il risultato della 
% Short-Time Fourier Transform STFT)
figure(6)
spectrogram(y_17, hanning(seg), floor(seg*0.95), seg, Fs, 'yaxis');
hold on
% crea un puntatore per la figura
hfig = gcf;
% definisco i limiti dell'asse z (dB)
hfig.CurrentAxes.CLim = [-120 20];  
% cambia i colori del grafico
colormap('jet')
title('Prova 2 - Dominio tempo-frequenza', 'STFT - Spettrogramma - Eccitazione (C17)')

%% ANALISI NEL DOMINIO TEMPO-FREQUENZA - CWT - SCALOGRAMMA - C17

% plottiamo i risulati della Continuous Wavelet Transform (CWT)
figure(7)
cwt(y_17, Fs)
hold on
% crea un puntatore per la figura
hfig = gcf;
% definisco i limiti dell'asse z (dB)
hfig.CurrentAxes.CLim = [0 5];  
% cambia i colori del grafico
colormap('jet')
title('Prova 2 - Dominio tempo-frequenza', 'CWT - Scalogramma - Eccitazione (C17)')