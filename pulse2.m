% pulse2 is a script which generates the wave form generated at an on-axis
% point in water by a circular planar transducer. It uses the 
% multi-Gaussian beam model MG_beam2 and  the function spectrum to generate
% the pulse.

clear
fs = 100; % sampling frequency (MHz)
f = s_space(0, fs, 1024); % generate sampled frequencies
ft =f(f <= 20); % choose subset of frequencies to calculate field values
[nr, nc] =size(ft); % determine size of frequency subset

% place paramters into structure setup
setup.f = ft;
setup.type1 = 'p';  % P-wave in medium 1
setup.type2 = 'p';  % P-wave in medium 2 ( = medium 2)
setup.int = 'fs';   % fluid-solid interface (reduces to single fluid) 

setup.trans.d = 12.7;   % transducer diameter (mm)
setup.trans.fl =inf;    % planar probe

% on-axis point in single medium
D = 0;
y3 = 135;
y1 = 0.;
y2 = 0. ;
setup.geom.D = D;      
setup.geom.y3 = y3;
setup.geom.y1 = y1;
setup.geom.y2 = y2;

% normal incidence, no interface curvatures
setup.geom.i_ang = 0;   
setup.geom.R1 = inf;
setup.geom.R2 = inf;
% material properties for single fluid (water) medium
setup.matl.d1 = 1.0;
setup.matl.d2 = 1.0;
setup.matl.cp1 =1480;
setup.matl.cs1 = 0;
setup.matl.cp2 = 1480;
setup.matl.cs2 = 0;
% wave speeds in mm/microsec
c1 = setup.matl.cp1/1000;
c2 = setup.matl.cp2/1000;

% get on-axis normalized velocity over the subset of frequencies
v= MG_beam2(setup);
% multiply by the subset spectrum for a 5 MHz, 4 MHz bandwidth transducer
vf = v.*spectrum(ft, 1, 5, 4);
% extend velocity back to full set of sampled positive frequency values
% only (negative frequency values are zero)
ve =[vf zeros(nr, 1024-nc)];
%compute inverse FFT of these positive frequency values
dt = 1/fs;  %sampling time interval
ve(1) = ve(1)/2;
vt =2*real(IFourierT(ve, dt));
% generate time axis, add in time delay of D/cp1 + y3/cp2 which is missing
% in MG_beam2
df = f(2) - f(1);
T = 1/df;
t = s_space(0, T, 1024) ; % time window in microseconds
t = t + D/c1 +y3/c2;
% plot waveform with shifting to center it in plot window
plot(t_shift(t,500) , c_shift(vt, 500))
