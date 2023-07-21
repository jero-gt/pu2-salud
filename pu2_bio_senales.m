%TP UTILITARIO 2 - BIO SEÑALES
addpath(genpath('.'));
clc; close all; clearvars;
%%
load('eeg.mat');
eeg=x;
clear x
t=0:length(eeg)-1;
plotCompleto([0 (length(eeg)/256) min(eeg) max(eeg)], 't', 'eeg', 'Encefalograma', 20, 'r', 1.5, t, eeg);
EEG=fft(eeg);
k=0:length(EEG)-1;
%graficamos la TDF "al derecho"
fs=256;
N=length(EEG);
% Si N es par
if(mod(N,2)==0)
f = (-fs/2 : (fs/N) : ((N-1)/N)*(fs/2));
else
% Si N es impar
f = (((N-1)/N)*(-fs/(2)) : (fs/N) : ((N-1)/N)*(fs/2));
end

stemCompleto([-fs/2 fs/2 abs(min(EEG)) 1e5],'f [Hz]', '', '|EEG|', 20, 'b.-', 1, f, abs(fftshift(EEG)));
hold on
stemCompleto([-fs/2 fs/2 abs(min(EEG)) 3e6],'f [Hz]', '', '|EEG|', 20, 'b.-', 1, f, abs(fftshift(EEG)));



figure, plot(f,abs(fftshift(EEG)),'-.')

