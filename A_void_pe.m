function A = A_void_pe(f, b, c)
% A = A_void_pe(f, b, c) returns the pulse-echo scattering amplitude A 
% (in mm)of a spherical void of radius b (in mm) at frequency f (in MHz) 
% in a solid or fluid with wave speed c (in m/sec)using the Kirchhoff
% approximation.

f = f +eps*(f == 0); % prevent division by zero at zero frequency
kb = 2000*pi*b*f/c;  % wave number of the host material times b
A = (-b/2)*exp(-1i*kb).*(exp(-1i*kb) - sin(kb)./kb);