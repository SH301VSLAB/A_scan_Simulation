function [v, vp] = onaxis_interface(z1, z2, f, a, d1, d2,cp1, cp2, cs2)
% >> [v, vp] = onaxis_interface(z1, z2, f, a, d1, d2, cp1, cp2, cs2). 
% A function which computes the on-axis velocity of a circular piston 
% transducer of radius a (in mm)radiating at a frequency f (in MHz) through
% a planar fluid-solid interface at normal incidence. The distances z1, z2
% (in mm) are in the fluid and solid, respectively, whose densities are 
% d1, d2. The compressional wave speed of the fluid is cp1 and the 
% compressional and shear wave speeds of the solid are cp2, cs2. All the 
% wave speeds are measured in m/sec. The units of the densities are 
% arbitrary but must be consistent. The function returns both the 
% normalized on-axis velocity, v, and the corresponding paraxial 
% approximation, vp, for the on-axis velocity of the transmitted P-wave.
% The distance z1 in the fluid must be a scalar.

% number of evaluation points in the solid and corresponding array needed
% for the intersection points on the inreface of the transmitted rays 
[nr, nc] = size(z2);
x = zeros(nr,nc);
% wave speeds, wave numbers of the compressional waves and the wave speed
% ratio, cr.
c1 = cp1;
c2 = cp2;
k1 = 2000*pi*f/c1;
k2 = 2000*pi*f/c2;
cr =c2/c1;
% compute ray intersection points, x, on the interface with Snell's law
for nn = 1:nr
    for mm = 1:nc
      x(nn, mm) = fzero(@interface, [0, a], [], cr, z1, z2(nn,mm),a);  
      
    end
end
% compute geometry parameters for beam expression
sint1 = (a-x)./sqrt(z1.^2+ (a - x).^2);
sint2 = x./sqrt(x.^2 + z2.^2);
cost1 = sqrt(1- sint1.^2);
cost2 =sqrt(1-sint2.^2);
iangd = asind(sint1);   % edge wave angles
iang0 =zeros(size(z2)); % direct wave angles
D1 = sqrt(z1.^2 +(a-x).^2);
D2 = sqrt(x.^2 + z2.^2);
% compute P-wave transmission coefficients for direct and edge waves
[tpp, tps] = fluid_solid(iangd, d1, d2, cp1, cp2, cs2);
T12 =tpp; 
[tpp0 , tps0] =fluid_solid(iang0, d1, d2, cp1, cp2, cs2);
T0 = tpp0;
% edge wave amplitude term
arg = (sqrt(D1 + cr.*D2).*cost2)./sqrt(D1 +cr.*cost1.^2.*D2./cost2.^2);

% on-axis velocity
v = T0.*exp(1i.*(k1.*z1 + k2.*z2)) -arg.*T12.*exp(1i.*(k1.*D1 +k2.*D2));

% paraxial approximation
vp = T0.*exp(1i.*(k1.*z1 + k2.*z2)).*(1 - exp(1i*k1.*a^2./(2*(z1+cr*z2))));

% Snell's law written in terms of the intersection point, xi, on the
% interface
function y = interface(xi, cr, z1, z2, a)
y = cr*(a-xi)*sqrt(xi^2 +z2^2) - xi*sqrt(z1^2 + (a - xi)^2);