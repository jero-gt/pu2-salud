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
xticks([-100, -50, -13, 0, 13, 50, 100])
xticklabels({'-100', '-50','-13', '0', '13', '50', '100'})


%% Filtro pasabanda y ritmo alfa
% save('.\filtros\filtroBP_8-13.mat','BP');
load('.\filtros\filtroBP_8-13.mat');

eeg_f=filter(BP,eeg);
plotCompleto([0 t(end) min(eeg_f)*1.1 max(eeg_f)*1.1], 't[s]', '', 'Encefalograma filtrado', 20, 'r-', 0.5, t, eeg_f);

plotFiltros(BP, f,fs,[-25 25 0 1.2],'Filtro PB 8-13');
[EEG_f_s, ~] = fft_kit(eeg_f, fs);
stemCompleto([-fs/2 fs/2 0 5e4],'f [Hz]', '', '|EEG_f|', 20, 'b.-', 1, f, abs(EEG_f_s));


%% RITMO ALFA
% e_eeg_f=eeg_f.^2;
% plotCompleto([0 t(end) 0 max(e_eeg_f)+5], 't[s]', '', 'Energ�a del encefalograma', 20, 'r-', 1, t, e_eeg_f);
% 
% [E_Y_s,f]=fft_kit(eeg_f.^2,fs);
% stemCompleto([-fs/2 fs/2 abs(min(E_Y_s)) abs(max(E_Y_s))],'f [Hz]', '', '|E_Y|', 20, 'b.-', 1, f, abs(E_Yshift));

dz=16; %muestras de diezmado
e_y=decimate(eeg_f.^2,dz);
t_d = ((0:length(e_y) - 1)./fs).*dz;
plotCompleto([0 t_d(end) 0 max(e_y)*1.1], 't[s]', '', 'Energ�a del encefalograma diezmado', 20, 'r', 1.5, t_d, e_y);
 
vent=80; %ventana de promedio movil
z = filter(ones(1,vent),1,e_y);
plotCompleto([0 t_d(end) 0 max(z)*1.1 ], 't[s]', '', 'Parpadeos', 20, 'r', 1.5, t_d, z);







