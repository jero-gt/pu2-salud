%TP UTILITARIO 2 - BIO SEÑALES
addpath(genpath('.'));
clc; close all; clearvars;
%%
load('eeg.mat');
eeg=x;
clear x
fs=256;
t=(0:length(eeg)-1)./fs;
plotCompleto([0 max(t) min(eeg) max(eeg)], 't', 'eeg', 'Encefalograma', 20, 'r', 1.5, t, eeg);

[EEG,EEG_shift,f]=fft_kit(eeg,fs);
stemCompleto([-fs/2 fs/2 abs(min(EEG)) 6.5e4],'f [Hz]', '', '|EEG|', 20, 'b.-', 1, f, abs(EEG_shift));
stemCompleto([-fs/2 fs/2 abs(min(EEG)) 3e6],'f [Hz]', '', '|EEG|', 20, 'b.-', 1, f, abs(EEG_shift));
%revisar si los ponemos en una misma figura o no

%% Filtro pasabanda y ritmo alfa
%save('filtroBP_8-13.mat','BP');
load('filtroBP_8-13.mat');

eeg_f=filter(BP,eeg);
EEG_f=fft(eeg_f);
stemCompleto([-fs/2 fs/2 abs(min(EEG_f)) 6.5e4],'f [Hz]', '', '|EEG_f|', 20, 'b.-', 1, f, abs(fftshift(EEG_f)));


%engy_alfa=eeg_f.^2;
engy_alfa=decimate(eeg_f.^2,16);
z=filter(ones(1,80),1,engy_alfa);
tt=(0:length(z)-1).*(16/256);
plotCompleto([0 tt(end) 0 max(z)], 't', '', 'Ritmo \alpha', 20, 'r', 1.5, tt, z);

