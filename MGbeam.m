function [v,setup ]=MGbeam(setup)
% get setup parameters
f = setup.f;
type1 = setup.type1;
type2 = setup.type2; %frequency or frequencies (MHz)
% wave type in medium one
% wave type in medium two
a = setup.trans.d/2;
Fl = setup.trans.fl; % transducer radius (mm)
% transducer focal length (mm)
z1 = setup.geom.z1;
z2 = setup.geom.z2;
x2 =setup.geom.x2;
y2 = setup.geom.y2;
Rx = setup.geom.R1;
Ry =setup.geom.R2;
iang = setup.geom.i_ang;
d1 = setup.matl.d1;
d2 =setup.matl.d2;
cp1 = setup.matl.cp1;
% water path length (mm)
% path length in solid (mm)
% distance (mm) from ray axis in POI
% distance (mm) perpendicular to the POI
% interface radius of curvature (mm) in POI
% interface radius of curvature (mm) out of POI
% incident angle (deg)
% density (fluid)
% density (solid)
% compressional wave speed -fluid (m/sec)
cp2 = setup.matl.cp2;
cs2 = setup.matl.cs2; % compressional wave speed -solid (m/sec)
% shear wave speed -solid (m/sec)
[A, B] = gauss_c15; % Wen and Breazeale coefficients (15)
% update setup.wave wave speeds
if strcmp(type1, 'p')
setup.wave.c1 =cp1;
elseif strcmp(type1, 's')
setup.wave.c1 = cs1;
else
error('wrong wave type (must be p or s) ')
end
if strcmp(type2, 'p')
setup.wave.c2 =cp2;
elseif strcmp(type2, 's')
setup.wave.c2 = cs2;
else
error('wrong wave type (must be p or s)')
end
% calculate transmission coefficient, update setup
setup.wave.T12 = fluid_solid(setup);
% wave speeds and transmission coefficient for the beam model
c1 =setup.wave.c1;
c2 =setup.wave.c2;
% wave speed for wave type2
T = setup.wave.T12;
% transmission coefficient
% parameters appearing in beam model
cosi = cos(pi*iang/180);
% cosine of incident angle
sinr = (c2/c1)*sin(pi*iang/180);
% sine of refracted angle from Snell's law
if sinr >= 1
error('Beyond the Critical angle') % no transmitted wave of given wave type
else
cosr = sqrt( 1 - sinr^2);
end
h11 = 1/Rx; %curvature
h22 = 1/Ry; %curvature
zr = eps*(f == 0) + 1000*pi*(a^2)*f./c1; % "Rayleigh" distance
k1 = 2*pi*1000*f./c1;
% wave number in fluid
%initialize predicted velocity with zeros of a size
% compatible with largest array in f, z1, z2, x2, y2 parameters





v = init_z(setup);
%multi-Gaussian beam model
for j = 1:15 % form up multi-Gaussian beam model
b =B(j) + i*zr./Fl; % modify coefficients for focused probe
% Fl = inf for planar probe
q = z1 - i*zr./b;
K = q.*(cosi -(c1/c2)*cosr);
M1 = (cosi^2 +K.*h11)./cosr^2;
M2 =1 + K.*h22;
ZR1 = q./M1;
ZR2 =q./M2;
m11 = 1./(ZR1 +(c2/c1).*z2);
m22 = 1./(ZR2 +(c2/c1).*z2);
t1 = A(j)./(1 + (i.*b./zr).*z1);
t2 = t1.*T.*sqrt(ZR1).*sqrt(ZR2).*sqrt(m11).*sqrt(m22);
v = v + t2.*exp(i.*(k1./2).*(m11.*(x2.^2) + m22.*(y2.^2)));
end
