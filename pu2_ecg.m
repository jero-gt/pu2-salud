%TP UTILITARIO 2 - BIO SEÑALES
addpath(genpath('.'));
clc; close all; clearvars;
%% ecg
load('ecg.mat');
fs=500;
t1=(0:length(ecg_limpia)-1)./500;
plotCompleto([0 max(t1) min(ecg_limpia) 7e-4], 't [s]', 'Amplitud', 'Electrocardiograma ideal', 20, 'r', 1.5, t1, ecg_limpia);
% [ECGz,ECGz_shift,f_li]=fft_kit(ecg_limpia,fs);
% stemCompleto([-fs/2 fs/2 abs(min(ECGz)) 0.2],'f [Hz]', '', '|ECG_l|', 20, 'b.-', 1, f_li, abs(ECGz_shift));

load('ecg_contaminada.mat');
t2=((0:length(ecg_contaminada)-1)./fs);
plotCompleto([0 max(t2) min(ecg_contaminada) 7.5e-4], 't [s]', 'Amplitud', 'Electrocardiograma contaminado', 20, 'r', 1.5, t2, ecg_contaminada);
[ECG,ECG_shift,f_cont]=fft_kit(ecg_contaminada,fs);
stemCompleto([-fs/2 fs/2 abs(min(ECG)) 0.2],'f [Hz]', 'Amplitud', '|ECG_{cont}|', 20, 'b.-', 1, f_cont, abs(ECG_shift));

%% FILTRO PASABAJOS
load('filtroLP_100');
ecg_fLP = filter(LP, ecg_contaminada);
[ECG_fLP, ECG_fLP_shift] = fft_kit(ecg_fLP,fs);
stemCompleto([-fs/2 fs/2 abs(min(ECG_fLP)) 0.2],'f [Hz]', 'Amplitud', '|EEG_{fLP}|', 20, 'b.-', 1, f_cont, abs( ECG_fLP_shift));

%% FILTRO RECHAZABANDA
load('filtroBS_49-53');
ecg_fBS = filter(BS, ecg_fLP);
[ECG_fBS, ECG_fBS_shift] = fft_kit(ecg_fBS,fs);
stemCompleto([-fs/2 fs/2 abs(min(ECG_fBS)) 0.2],'f [Hz]', 'Amplitud', '|EEG_fBP|', 20, 'b.-', 1, f_cont, abs( ECG_fBS_shift));


%plotCompleto([0 max(t2) min(ecg_fBS) 7e-4], 't [s]', 'Amplitud', 'Electrocardiograma filtrado', 20, 'r', 1.5, t2, ecg_fBS);







