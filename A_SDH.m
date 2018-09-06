function A =A_SDH(setup)
% A_SDH calculates the pulse-echo 3-D normalized far-field scattering
% amplitude,A/L, of a side-drilled hole in the Kirchhoff approximation
% using the frequency f in setup.f, the radius b in setup.flaw.b,
% and the wave speed for the wave type in setup.wave.c2.
% The calling sequence is A = A_SDH(setup). The scattering
% amplitude, A, (in mm) is returned. In the calculation of the
% Struve function, an integration routine is used. Thus, the
% frequency, f, must be at most a vector to use this function
% effectively. It is not vectorized for f being a matrix.
f =setup.f;
b =setup.flaw.b;
c=setup.wave.c2;
kb =2000*pi*b.*f./c;
A =(kb./2).*(besselj(1, 2*kb)-i*struve(2*kb)) +i*kb./pi;
function y = struve(z)
num = length(z);
y=zeros(1,num);
for k = 1:num
y(k) = quadl(@struve_arg, 0, 1, [ ],[ ], z(k));
end
function y = struve_arg(x, z)
y = (4./pi).*z.*x.^2.* sin(z.*(1-x.^2)).*sqrt(2-x.^2);
