function y = attenuate(setup)
% atten(setup) generates a frequency dependent attenuation factor
% as a function of the frequency, f, and the distances z1, z2 in (mm)
% traveled in two media
% For water at room temp for the first medium , take p1(1) = p1(2) = p1(4)
% =p1(5)=0,
% and p1(3) = 25.3E-06 if f is in MHz, distances are in mm
f=setup.f;
type1=setup.type1;
type2=setup.type2;
z1 =setup.geom.z1;
z2 =setup.geom.z2;
p1 =setup.matl.p1;
s1 =setup.matl.s1;
p2=setup.matl.p2;
s2=setup.matl.s2;
if strcmp(type1, 'p')
a1 =p1;
elseif strcmp(type1, 's')
a1 =s1;
else
error('wrong wave type')
end
if strcmp(type2, 'p')
a2 =p2;
elseif strcmp(type1, 's')
a2 =s2;
else
error('wrong wave type')
end
d1 = a1(1) + a1(2)*f + a1(3)*f.^2 + a1(4)*f.^3 + a1(5)*f.^4;
d2 = a2(1) + a2(2)*f + a2(3)*f.^2 + a2(4)*f.^3 + a2(5)*f.^4;
y = exp(-d1.*z1).*exp(-d2.*z2);
