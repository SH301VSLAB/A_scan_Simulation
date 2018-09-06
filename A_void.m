function A = A_void(setup)
% A_VOID calculates the pulse-echo far-field scattering amplitude
% of a spherical void in the Kirchhoff approximation, using
% the frequency f in setup.f, the radius b in setup.flaw.b,
% and the wave speed for the wave type in setup.wave.c2.
% The calling sequence is A = A_void(setup). The scattering
% amplitude, A, (in mm) is returned.
%get the parameters
f =setup.f;
c = setup.wave.c2;
b = setup.flaw.b;
%calculate the wave number kb (f in MHz, b in mm, c in m/sec)
kb = (2000*pi*b*f)./c;
%calculate the pulse-echo scattering amplitude
kb = kb + eps*(kb == 0); % prevent division by zero
A =(-b/2)*exp(-i*kb).*(exp(-i*kb)-sin(kb)./(kb));
