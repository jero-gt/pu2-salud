%TP UTILITARIO 2 - BIO SEÑALES
addpath(genpath('.'));
clc; close all; clearvars;

%% ecg
load('ecg.mat');
fs=500;
t1=(0:length(ecg_limpia)-1)./500;
plotCompleto([0 max(t1) min(ecg_limpia) 7e-4], 't [s]', '', 'ecg ideal', 20, 'r', 1.5, t1, ecg_limpia);
[ECGz_s,f_li]=fft_kit(ecg_limpia,fs);	%ECGz_s = fftshift(fft(ECGz)), de ahora en mas adoptaremos el sunindice _s para refernirnos a _shift
%stemCompleto([-fs/2 fs/2 abs(min(ECGz_s)) 0.2],'f [Hz]', '', '|ECG_l|', 20, 'b.-', 1, f_li, abs(ECGz_s));

load('ecg_contaminada.mat');
t2=((0:length(ecg_contaminada)-1)./fs);
plotCompleto([0 max(t2) min(ecg_contaminada) 7.5e-4], 't [s]', '', 'ecg contaminado', 20, 'r', 1.5, t2, ecg_contaminada);
[ECG_s, f_cont]=fft_kit(ecg_contaminada,fs);
%stemCompleto([-fs/2 fs/2 abs(min(ECG_s)) 0.2],'f [Hz]', '', '|ECG_{cont}|', 20, 'b.-', 1, f_cont, abs(ECG_s));

stemDoble([-fs/2 fs/2 abs(min(ECG_s)) 0.2],[-fs/2 fs/2 abs(min(ECG_s)) 0.2], 'f [Hz]', '', "ECG ideal", "ECG contaminado", 20, 'b.-', 1.5, f_li, abs(ECGz_s), f_cont, abs(ECG_s))
%
%
%%% FILTRO PASABAJOS
%load('filtroLP_100');
%plotFiltros(LP, f_cont, fs, [-fs/2 fs/2 0 1.5], "Filtro LP 100Hz");
%
%ecg_fLP = filter(LP, ecg_contaminada);
%[ECG_fLP_s, ~] = fft_kit(ecg_fLP,fs);
%stemCompleto([-fs/2 fs/2 abs(min(ECG_fLP_s)) 0.2],'f [Hz]', '', '|ECG_{fPB}|', 20, 'b.-', 1, f_cont, abs(ECG_fLP_s));
%
%%% FILTRO RECHAZABANDA
%load('filtroBS_49-53');
%plotFiltros(BS, f_cont, fs, [-100 100 0 1.5], "Filtro RB 49Hz-53Hz");
%
%ecg_fBS = filter(BS, ecg_fLP);
%[ECG_fBS_s, ~] = fft_kit(ecg_fBS,fs);
%stemCompleto([-fs/2 fs/2 abs(min(ECG_fBS_s)) 0.2],'f [Hz]', '', '|ECG_{fRB}|', 20, 'b.-', 1, f_cont, abs(ECG_fBS_s));
%
%plotCompleto([0 max(t2) min(ecg_fBS) 7e-4], 't [s]', '', 'ecg filtrado', 20, 'r', 1.5, t2, ecg_fBS);
