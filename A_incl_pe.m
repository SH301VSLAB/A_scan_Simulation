function A = A_incl_pe(f, b, c1, d1, c0, d0)
% A = A_incl_pe(f,b,c1,d1,c0,d0) calculates the pulse-echo scattering 
% amplitude A(in mm) for a spherical inclusion of radius b (in mm) where 
% (c1,d1) and (c0, d0) are the wave speeds and densities of the flaw and
% host materials, respectively. Wave speeds are in m/sec and densities
% are in arbitary but consistent units. The function uses the modified Born
% approximation where the wave travels in the flaw at the flaw wave speed
% and the amplitude of the front and back responses are in terms
% of the reflection coefficient without making the weak scattering
% approximation. A phase correction puts the front and back responses at
% the correct times.

f = f + eps*( f == 0); % prevent division by zero at zero frequency
kbf = 2000*pi*f*b/c1;   % wave number for the flaw times b
R = (d1*c1-d0*c0)/(d1*c1 + d0*c0); % reflection coefficient
A =-2*b*R.*(exp(1i*2*kbf*(1-c1/c0)))...
    .*(sin(2*kbf)-2*kbf.*cos(2*kbf))./(2*kbf);