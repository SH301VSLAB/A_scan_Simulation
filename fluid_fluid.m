function [R,T] =fluid_fluid(iangd, d1, d2, c1, c2)
% [R,T] = fluid_fluid(iangd, d1, d2, c1, c2) returns (R,T) the reflection
% and transmission coefficients (based on velocity ratios) for a
% plane wave incident on a plane interface between two fluids at an angle
% iangd (in degrees).(d1,c1) and (d2, c2) are the densities and wave speeds
% in the first and second fluids. The units of these quantities are
% arbitrary but must be consistent.

iang = (iangd.*pi)./180; % incident angle in radians
sint =(c2/c1)*sin(iang); % sine of transmitted angle from Snell's law

% cosine of transmitted angle can be imaginary beyond the critical angle
cost = sqrt(1-sint.^2).*(sint <= 1) + i.*sqrt(sint.^2 -1).*(sint > 1);

% reflection and transmission coefficients
R = ((c2*d2).*cos(iang) - (c1*d1).*cost)./ ...
((c2*d2).*cos(iang) + (c1*d1).*cost);
T = ((2*d1*c1).*cos(iang))./((c2*d2).*cos(iang) + (c1*d1).*cost);
