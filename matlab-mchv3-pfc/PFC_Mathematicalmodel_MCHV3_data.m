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
T_pwm = 1/fsw;                      % PWM switching time period
%% Set Sample Ratio/Sample Times
Isr = 1;                            % Inner Loop Sampling Ratio
Osr = 16;                           % Outer Loop Sampling Ratio
Tsi = Isr / fsw;                    % Sampling time in sec for Current Loop
Tsv = Osr / fsw;                    % Sampling time in sec for Voltage Loop

%% Set Base Values for Gains
Ibase = 21.3;                       % Ibase
Vbase = 453;                        % Vbase 

KiL = 1/Ibase;                       % Current sensing gain
Kvo = 1/Vbase;                       % DC bus voltage sensing gain
Kvin = 1/Vbase;                      % Feed-forward voltage sensing gain
Kmul = Vpk_min/(2*Vbase);            % Multiplier gain

%% Set Control System Parameters
fc_i = fsw/10;                      % Inner Loop Desired crossover frequency in Hz 
fc_v = 10;                          % Outer Loop Cross over frequency in Hz

%% Set up Soft Start/Ramping up the reference voltage for Voltage loop 
Vref = Vout;                        % Reference Voltage
Vout_init = Vin_pk;                 % Initial Voltage
T_rise = 0.526;                     % Rise up time
Slope = (Vref-Vout_init)/T_rise;    % Slope 


%% Current Loop Control (Inductor current Transfer function)[ IL / d]
Gid = Vout/(s*L);

%% Current loop compensator calculation
fz_i = fc_i/10;                             % Zero frequency in Hz
Tz_i = 1/(2*pi*fz_i);

Gci = (2*pi*fc_i*L)/(KiL*Vout);             % Gain Value

Kp_i = Gci;                        
Ki_i = Kp_i/Tz_i;

Gic_comp = Kp_i+Ki_i/s;
Gicl = Gid*Gic_comp*KiL;

%% The coefficients for the discrete current controller
Kp_id = Kp_i;                        
Ki_id = Ki_i*Tsi;

%% Voltage Loop Control (Inductor current Transfer function)[ IL / d]
Gvc = (2*Kmul)/(Kvin*KiL*C*Vout*s);
%% Voltage loop compensator calculation
fz_v = 1;                                            % Zero frequency in Hz
Tz_v = 1/(2*pi*fz_v);

Gcv = (C*Vout*2*pi*fc_v*Kvin*KiL)/(Kvo*2*Kmul);      % Gain Value

Kp_v = Gcv;
Ki_v = Kp_v/Tz_v;

Gvc_comp = Kp_v+Ki_v/s;
Gvcl = (Gvc*Gvc_comp*Kvo);

%% The coefficients for the discrete voltage controller
Kp_vd = Kp_v;
Ki_vd = Ki_v*Tsv;

%% Display the Values

fprintf('Kp_v = %f\n', Kp_vd);
fprintf('Ki_v = %f\n', Ki_vd);
fprintf('Kp_i = %f\n', Kp_id);
fprintf('Ki_i = %f\n', Ki_id);
fprintf('Kmul = %f\n', Kmul*32767);

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
