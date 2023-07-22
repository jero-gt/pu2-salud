%TP UTILITARIO 2 - BIO SEÑALES
addpath(genpath('.'));
clc; close all; clearvars;
%%
load('eeg.mat');
eeg=x;
clear x
fs=256;

t=(0:length(eeg)-1)./fs;
plotCompleto([0 t(end) (min(eeg) - 10) (max(eeg) + 10)], 't[s]', 'Amplitúd', 'Encefalograma', 20, 'r', 1.5, t, eeg);

[EEG,EEG_shift,f]=fft_kit(eeg,fs);
stemCompleto([-fs/2 fs/2 abs(min(EEG)) 6.5e4],'f [Hz]', '', '|EEG|', 20, 'b.-', 1, f, abs(EEG_shift));
stemCompleto([-fs/2 fs/2 abs(min(EEG)) 3e6],'f [Hz]', '', '|EEG|', 20, 'b.-', 1, f, abs(EEG_shift));
%revisar si los ponemos en una misma figura o no

%% Filtro pasabanda y ritmo alfa
%save('filtroBP_8-13.mat','BP');
load('filtroBP_8-13.mat');

eeg_f=filter(BP,eeg);
plotCompleto([0 t(end) (min(eeg_f) - 10) (max(eeg_f) + 10)], 't[s]', 'Amplitúd', 'Encefalograma filtrado', 20, 'r-', 1, t, eeg_f);

EEG_f=fft(eeg_f);
stemCompleto([-fs/2 fs/2 abs(min(EEG_f)) 6.5e4],'f [Hz]', '', '|EEG_f|', 20, 'b.-', 1, f, abs(fftshift(EEG_f)));

engy_alfa_d=decimate(eeg_f.^2,8);
t_d = ((0:length(engy_alfa_d) - 1)./fs).*8;
plotCompleto([0 t_d(end) (min(engy_alfa_d) - 10) (max(engy_alfa_d) + 10)], 't[s]', 'Amplitúd', 'Encefalograma diezmado', 20, 'r', 1.5, t_d, engy_alfa_d);

z = filter(ones(1,16),1,engy_alfa_d);
plotCompleto([0 t_d(end) min(z) max(z)], 't', '', 'Ritmo \alpha filt+diez', 20, 'r', 1.5, t_d, z);
