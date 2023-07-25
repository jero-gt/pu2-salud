%TP UTILITARIO 2 - BIO SE�ALES
addpath(genpath('.'));
clc; close all; clearvars;
%%
load('eeg.mat');
eeg=x;
clear x
fs=256;

t=(0:length(eeg)-1)./fs;
plotCompleto([0 t(end) (min(eeg) - 10) (max(eeg) + 10)], 't[s]', 'Amplitud', 'Encefalograma', 20, 'r', 1.5, t, eeg);

[EEG,EEG_shift,f]=fft_kit(eeg,fs);
stemCompleto([-fs/2 fs/2 abs(min(EEG)) 6.5e4],'f [Hz]', '', '|EEG|', 20, 'b.-', 1, f, abs(EEG_shift));
stemCompleto([-fs/2 fs/2 abs(min(EEG)) 3e6],'f [Hz]', '', '|EEG|', 20, 'b.-', 1, f, abs(EEG_shift));
%revisar si los ponemos en una misma figura o no

%% Filtro pasabanda y ritmo alfa
% save('.\filtros\filtroBP_8-13.mat','BP');
load('./filtros/filtroBP_8-13.mat');

eeg_f=filter(BP,eeg);
plotCompleto([0 t(end) (min(eeg_f) - 10) (max(eeg_f) + 10)], 't[s]', 'Amplitud', 'Encefalograma filtrado', 20, 'r-', 1, t, eeg_f);

EEG_f=fft(eeg_f);
stemCompleto([-fs/2 fs/2 abs(min(EEG_f)) 6.5e4],'f [Hz]', '', '|EEG_f|', 20, 'b.-', 1, f, abs(fftshift(EEG_f)));


%% RITMO ALFA
% e_eeg_f=eeg_f.^2;
% plotCompleto([0 t(end) 0 max(e_eeg_f)+5], 't[s]', 'Amplitud', 'Energ�a del encefalograma', 20, 'r-', 1, t, e_eeg_f);
% 
% [E_Y,E_Y_s]=fft_kit(eeg_f.^2,fs);
% stemCompleto([-fs/2 fs/2 abs(min(E_Y)) abs(max(E_Y))],'f [Hz]', '', '|E_Y|', 20, 'b.-', 1, f, abs(E_Y_s));
dz=16; %muestras de diezmado
e_y=decimate(eeg_f.^2,dz);
t_d = ((0:length(e_y) - 1)./fs).*dz;
plotCompleto([0 t_d(end) -1 (max(e_y) + 5)], 't[s]', 'Amplitud', 'Energ�a del encefalograma diezmado', 20, 'r', 1.5, t_d, e_y);
 
vent=80; %ventana de promedio movil
z = filter(ones(1,vent),1,e_y);
plotCompleto([0 t_d(end) -1 (max(z) + 5)], 't[s]', 'Amplitud', 'Energ�a EEG filt + dz (80)', 20, 'r', 1.5, t_d, z);

