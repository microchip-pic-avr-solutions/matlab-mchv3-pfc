 %% ************************************************************************
% Model         :   Mathematical model of Single-Stage Boost PFC
% Description   :   Set Parameters for Mathematical model of Single-Stage Boost PFC
% File name     :   PFC_Mathematicalmodel_MCHV3_data.m
% Copyright 2022 Microchip Technology Inc.

%%
 clc
 clear all
 close all
 s = tf('s');

%% Simulation Parameters
%% Set circuit parameters
Po = 1000;                          % Output Power of the converter
Vout = 380;                         % Output Voltage
Vin_rms = 230;                      % Inout Voltage rms value [ 90V - 250V range]
Vin_pk = Vin_rms*1.414;             % Input Voltage peak value 
Vrms_min = 140;                     % Minimum Inout Voltage rms value for Kmul
Vpk_min = Vrms_min*1.414;           % Minimum Input Voltage peak value for Kmul

L = 1e-3;                           % Inductance Value(Choose the proper value if it is swinging inductor based on load)
C = 3*470e-6;                       % Output Capacitance
R = (Vout^2)/Po;                    % Equivalent load Resistance

%% Set PWM Switching frequency
fsw = 80e3;                         % PWM frequency
T_pwm = 1/fsw;                      
%% Set Sample Ratio/Sample Times
Isr = 1;                            
Osr = 16;                           
Tsi = Isr / fsw;                  
Tsv = Osr / fsw;                    

%% Set Base Values for Gains
Ibase = 21.3;                       % Ibase
Vbase = 453;                        % Vbase 

KiL = 1/Ibase;                      
Kvo = 1/Vbase;                      
Kvin = 1/Vbase;                     
Kmul = Vpk_min/(2*Vbase);           

%% Set Control System Parameters
fc_i = fsw/10;                      
fc_v = 10;                          

%% Set up Soft Start/Ramping up the reference voltage for Voltage loop 
Vref = Vout;                        
Vout_init = Vin_pk;                 
T_rise = 0.20;                    
Slope = (Vref-Vout_init)/T_rise;    

%% Current Loop Control (Inductor current Transfer function)[ IL / d]
Gid = Vout/(s*L);

%% Current loop compensator calculation
fz_i = fc_i/10;                             

Gci = (2*pi*fc_i*L)/(KiL*Vout);            

Kp_i = Gci;                        
Ki_i = Kp_i*2*pi*fz_i;

Gic_comp = Kp_i+Ki_i/s;
Gicl = Gid*Gic_comp*KiL;

%% Voltage Loop Control (Inductor current Transfer function)[ IL / d]
Gvc = (2*Kmul)/(Kvin*KiL*C*Vout*s);
%% Voltage loop compensator calculation
fz_v = 1;                                            

Gcv = (C*Vout*2*pi*fc_v*Kvin*KiL)/(Kvo*2*Kmul);     

Kp_v = Gcv;
Ki_v = Kp_v*2*pi*fz_v;

Gvc_comp = Kp_v+Ki_v/s;
Gvcl = (Gvc*Gvc_comp*Kvo);

%% Bode plot settings
 P = bodeoptions;
 P.Grid = 'on';
 P.MagUnits = 'dB';
 P.FreqUnits = 'Hz'; 
 P.PhaseWrapping = 'on' ;   
 %% Bode Plots - Transfer Functions
figure('Name','Current Loop Plant(iL/d)','NumberTitle','off')  
bode(Gid,'b',{1e-2, 1e7},P);
legend('Gid');
title(sprintf('Bode plot of:  %s ', 'Current Loop Plant (Gid)'))

figure('Name','Gic_comp','NumberTitle','off')  
bode(Gic_comp,'b',{1e-2, 1e7},P);
legend('Gic_comp');
title(sprintf('Bode plot of:  %s ', 'Gic_comp'))

figure('Name','Current Loop Gain ','NumberTitle','off')  
bode(Gicl,'b',{1e-2, 1e7},P);
legend('Gic_loop gain');
title(sprintf('Bode plot of:  %s ', 'Current Loop Gain (Gicl)'))

figure('Name','Voltage Loop Plant(Vo/Vc)','NumberTitle','off')  
bode(Gvc,'b',{1e-2, 1e7},P);
legend('Gvc');
title(sprintf('Bode plot of:  %s ', 'Voltage Loop Plant (Gvc)'))

figure('Name','Gvc_comp','NumberTitle','off')  
bode(Gvc_comp,'b',{1e-2, 1e7},P);
legend('Gvc_comp');
title(sprintf('Bode plot of:  %s ', 'Gvc_comp'))

figure('Name','Voltage Loop Gain ','NumberTitle','off')  
bode(Gvcl,'b',{1e-2, 1e7},P);
legend('Gvc_loop gain');
title(sprintf('Bode plot of:  %s ', 'Voltage Loop Gain (Gvcl)'))
