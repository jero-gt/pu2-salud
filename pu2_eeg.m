%TP UTILITARIO 2 - BIO SE�ALES
addpath(genpath('.'));
clc; close all; clearvars;
%%
load('eeg.mat');
eeg=x;
clear x
fs=256;

t=(0:length(eeg)-1)./fs;
plotCompleto([0 t(end) (min(eeg) - 10) (max(eeg) + 10)], 't[s]', '', 'Encefalograma', 20, 'r', 0.5, t, eeg);

[EEG_s,f]=fft_kit(eeg,fs);	%EEG_s = fftshift(fft(EEG)), de ahora en mas adoptaremos el sunindice _s para refernirnos a _shift

stemCompleto([-fs/2 fs/2 abs(min(EEG_s)) 3e6],'f [Hz]', '', '|EEG|', 20, 'b.-', 1, f, abs(EEG_s));

stemCompleto([-fs/2 fs/2 abs(min(EEG_s)) 6.5e4],'f [Hz]', '', '|EEG|', 20, 'b.-', 1, f, abs(EEG_s));
xticks([-100, -50, -13, 0, 13, 50, 100]);xticklabels({'-100', '-50','-13', '0', '13', '50', '100'})


%% Filtro pasabanda y ritmo alfa
load('.\filtros\filtroBP_8-13.mat');

eeg_f=filter(BP,eeg);

plotFiltros(BP, f,fs,[-25 25 0 1.2], 'Filtro PB 8Hz-13Hz');
xticks([-25, -13, -8, 0, 8,13, 25]);xticklabels({'-25','-13','-8', '0', '8','13', '25'});xlabel("f[Hz]");

[EEG_f_s, ~] = fft_kit(eeg_f, fs);
stemCompleto([-fs/2 fs/2 0 5e4],'f [Hz]', '', '|EEG_f|', 20, 'b.-', 1, f, abs(EEG_f_s));


%% RITMO ALFA

%Energ�a
e_eeg_f=eeg_f.^2;

plotDoble([0 t(end) min(eeg_f)*1.1 max(eeg_f)*1.1],[0 t(end) 0 max(e_eeg_f)+5],'t[s]', '','EEG filtrado','Energia EEG filtrado',20, 'r-', 0.5, t, eeg_f,t,e_eeg_f);

%Diezmado en 16
dz=16; %muestras de diezmado
e_y=decimate(eeg_f.^2,dz);
t_d = ((0:length(e_y) - 1)./fs).*dz;

%Promedio movil de 80 muestras
vent=80; %ventana de promedio movil
z = filter(ones(1,vent),1,e_y);

plotDoble([0 t_d(end) 0 max(e_y)*1.1],[0 t_d(end) 0 max(z)*1.1 ],'t[s]', '', 'Energ�a EEG diezmado', 'Parpadeos',20, 'r', 1.5, t_d, e_y,t_d, z);





