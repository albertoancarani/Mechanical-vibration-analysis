clear, clc, close all
load('exer_03_xcorr.mat')
figure, hold on
grid, box on
plot(aa)
plot(bb)
[aa1,bb1,dd]=alignsignals(aa,bb,10000,'truncate');
dd
% return
figure, hold on
grid, box on
plot(aa1)
plot(bb1)

