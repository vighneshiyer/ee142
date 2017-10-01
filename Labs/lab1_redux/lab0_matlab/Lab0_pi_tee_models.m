%% 
clear; 
clc;
close all;
%%

s2pfile_A = 'tline_LC_ckt.s2p';
s2pfile_B = 'CapInShunt_ckt.s2p';

%%
% Read in a .s2p file, s2pfile_A, and model as a pi model.
% First, plot its S-parameters.
% Make sure to set the Matlab path first before running this script.
%  
% An s2p file gives, for every freq, the S11 S21 S12 & S22 parameterss
% in one of 3 formats(real/imag, mag/ang or dB/ang).  A header line in 
% the .s2p file says which.  Use the sparameters() function to get them.
% RF Toolbox also includes the functions yparameters() and zparameters().  
% All 3 functions take a .s2p file for an argument, and create an
% object from which you can extract the S, Y  or Zparameters (and also the
% list of frequencies), respectively, into a Matlab handle object. The 
% rfparam() function then extracts the parameters from the object
% (e.g. S11 S21 S12 or S22 from the S-param object or Y11 Y21 Y12 Y22 
% from the Y-param object, etc.).

Z0 = 0;
S = sparameters(s2pfile_A);  % Create a handle for this S param object
freqs = S.Frequencies;   % Returns a vector of all the freqs (same for S & Y objects)  
omegas = 2*pi*freqs;     % Convert this vector of all the sampled freqs to omegas

S11 = rfparam(S,1,1);    % Returns S11 as a vector of complex numbers
S21 = rfparam(S,2,1);    % Returns S21 as a vector of complex numbers

figure;
subplot(4,1,1);
plot(freqs, 20*log10(abs(S11)), '-r');
ylabel('|S11| (dB)');
title('Magnitude and Phase of S11 and S21');

subplot(4,1,2);
plot(freqs, (180/pi)*angle(S11), '--r');   % Convert to degrees.
ylabel('S11 (deg)');

subplot(4,1,3);
plot(freqs, 20*log10(abs(S21)),'-b');
ylabel('|S21| (dB)');

subplot(4,1,4);
plot(freqs, (180/pi)*angle(S21), '--b');   % Want to plot phase in degrees.
ylabel('S21 (deg)');
xlabel('Frequency (Hz)');

%%  Extract Y-parameters from the .s2p file

Y = yparameters(s2pfile_A);  % Create a handle for this Y param object
freqs = Y.Frequencies;       % Extract a vector of all the freqs (same for S & Y objects)  
omegas = 2*pi*freqs;         % Convert this vector of all thte sampled freqs to omegas

Y11 = rfparam(Y,1,1);
Y12 = rfparam(Y,1,2);
Y21 = rfparam(Y,2,1);
Y22 = rfparam(Y,2,2);

figure;
subplot(4,1,1);
plot(freqs, real(Y11), '-m');
ylabel('Re{Y11} (S)');
title('Real and Imag of Y11 and Y21');

subplot(4,1,2);
plot(freqs, imag(Y11), '--m');   
ylabel('Im{Y11} (deg)');

subplot(4,1,3);
plot(freqs, real(Y21), '-g');
ylabel('Re{Y21} (S)');

subplot(4,1,4);
plot(freqs, imag(Y21), '--g');
ylabel('Im{Y21} (S)');
xlabel('Frequency (Hz)');

%%
% Initialize 3 column vects for pi model (Y1 & Y2 shunt, Y3 across top)
N = length(freqs);
Y1=ones(N,1);
Y2=ones(N,1);
Y3=ones(N,1);

% Now make the pi model of Y1 (Y2 is the same as Y1) and Y3
Y1 = Y11 + Y12;
Y3 = -Y12;

% Calc the value for Im{Y1}, assuming it can be modeled as a capacitor.
G1 = real(Y1);
R1 = 1 ./ G1;
B1 = imag(Y1);         
C1 = B1 ./ omegas;

% Calc the value for Im{Y3}, assuming it can be modeled as an inductor.
G3 = real(Y3); 
R3 = 1 ./ G3;
B3 = -imag(Y3);       
L3 = 1 ./ (B3 .* omegas);

%%  Plots for components of C1 and L3 of pi model

figure;
subplot(2,1,1);
plot(freqs, C1, '-b');
ylabel('C1 (F)');
xlabel('Frequency (Hz)');
title('Capacitance of C1');

subplot(2,1,2);
plot(freqs, L3, '-b');   
ylabel('L3 (H)');
xlabel('Frequency (Hz)');
title('Inductance of L3');

%% Repeat for s2pfile_B, but model as a tee topology
% % First, plot its S-parameters.

S = sparameters(s2pfile_B);  % Create a handle for this S param object
freqs = S.Frequencies;   % Returns a vector of all the freqs (same for S & Y objects)  
omegas = 2*pi*freqs;     % Convert this vector of all the sampled freqs to omegas

S11 = rfparam(S,1,1);    % Returns S11 as a vector of complex numbers
S21 = rfparam(S,2,1);    % Returns S21 as a vector of complex numbers

figure;
subplot(4,1,1);
plot(freqs, 20*log10(abs(S11)), '-r');
ylabel('|S11| (dB)');
title('Magnitude and Phase of S11 and S21');

subplot(4,1,2);
plot(freqs, (180/pi)*angle(S11), '--r');   % Convert to degrees.
ylabel('S11 (deg)');

subplot(4,1,3);
plot(freqs, 20*log10(abs(S21)),'-b');
ylabel('|S21| (dB)');

subplot(4,1,4);
plot(freqs, (180/pi)*angle(S21), '--b');   % Want to plot phase in degrees.
ylabel('S21 (deg)');
xlabel('Frequency (Hz)');

%%  Extract Z-parameters from the .s2p file

Z = zparameters(s2pfile_B);  % Create a handle for this Z param object
freqs = Z.Frequencies;       % Extract a vector of all the freqs (same for S & Y objects)  
omegas = 2*pi*freqs;         % Convert this vector of all thte sampled freqs to omegas

Z11 = rfparam(Z,1,1);
Z12 = rfparam(Z,1,2);
Z21 = rfparam(Z,2,1);
Z22 = rfparam(Z,2,2);

figure;
subplot(4,1,1);
plot(freqs, real(Z11), '-m');
ylabel('Re{Z11} (ohms)');
title('Real and Imag of Z11 and Z21');

subplot(4,1,2);
plot(freqs, imag(Z11), '--m');   
ylabel('Im{Z11} (ohms)');

subplot(4,1,3);
plot(freqs, real(Z21), '-g');
ylabel('Re{Z21} (ohms)');

subplot(4,1,4);
plot(freqs, imag(Z21), '--g');
ylabel('Im{Z21} (ohms)');
xlabel('Frequency (Hz)');


%%
% Initialize 3 column vects for tee model (Z1 & Z2 series, Z3 shunt)
N = length(freqs);
Z1=ones(N,1);
Z2=ones(N,1);
Z3=ones(N,1);

% Now make the tee model of Z1 (Z2 is the same as Z1) and Z3
Z1 = Z11 - Z12;
Z3 = Z12;

% Calc the value for Im{Z1}, assuming it can be modeled as an inductor.
R1 = real(Z1);
X1 = imag(Z1);         
L1 = X1 ./ omegas;

% Calc the value for Im{Z3}, assuming it can be modeled as a capacitor.
R3 = real(Z3); 
X3 = imag(Z3);       
C3 = -1 ./ (X3 .* omegas);



%%  Plots for components of L1 and C3 of tee model

figure;
subplot(2,1,1);
plot(freqs, L1, '-b');
ylabel('L1 (H)');
xlabel('Frequency (Hz)');
title('Inductance of L1');

subplot(2,1,2);
plot(freqs, C3, '-b');   
ylabel('C3 (F)');
xlabel('Frequency (Hz)');
title('Capacitance of C3');





