function A = A_crack(setup)
% A_CRACK calculates the pulse-echo far-field scattering amplitude
% of a circular crack in the Kirchhoff approximation, using the
% frequency f in setup.f, the radius b in setup.flaw.b, the acute
% angle between the incident wave direction and the crack normal in
% setup.flaw.f_ang, and the wave speed for the wave type in
% setup.wave.c2.
% The calling sequence is A = A_crack(setup). The
% scattering amplitude,A, (in mm) is returned.
%get the parameters
f = setup.f;
c = setup.wave.c2;
b = setup.flaw.b;
ang = setup.flaw.f_ang;
% put the angle in radians, calculate the wave number
iang = ang.*pi./180;
kb = (2000*pi*b*f)./c;
% calculate the pulse-echo scattering amplitude
arg = 2*sin(iang).*kb;
% argument of bessel function
arg = arg + eps*(arg == 0); % prevent division by zero
A = i*kb.*b.*cos(iang).*(besselj(1, arg)./arg);
