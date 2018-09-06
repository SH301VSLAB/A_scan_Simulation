function A = A_crack_pe(f, b, c, angd)
% A = A_crack_pe(f,b,c,angd) returns the pulse-echo scattering amplitude
% A (in mm)for a circular crack of radius b ( in mm) at a frequency f 
% (in MHz) in a material with a wave speed c (in m/sec) and at an angle 
% angd(in degrees) using the Kirchhoff approximation 

f = f + eps*(f == 0);   % prevent division by zero at zero frequency
kb = 2000*pi*b*f/c;      % wave number times b
A = 1i*kb.*b.*cosd(angd).* ...
    (besselj(1, 2*kb.*sind(angd))./(2*kb.*sind(angd)));