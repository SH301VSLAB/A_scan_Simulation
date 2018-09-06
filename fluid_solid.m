function T12 = fluid_solid(setup)
% fluid_solid(setup) computes the P-P (tpp)
% and P-S (tps) transmission coefficients based on velocity ratios
% for a plane fluid-solid interface. It obtains the necessary input
% parameters from the setup structure and then returns the
% appropriate transmission coefficient
% get setup parameters
type1 =setup.type1;
type2 =setup.type2;
inc= setup.geom.i_ang;
d1 = setup.matl.d1;
d2 =setup.matl.d2;
cp1 = setup.matl.cp1;
cs1 =setup.matl.cs1;
cp2 =setup.matl.cp2;
cs2 =setup.matl.cs2;
% consistency check (if material one is not a fluid
% then can't use this fluid-solid trans. coefficient)
if strcmp(type1, 's') | cs1 ~=0
error('wrong wave type or wave speed for medium 1')
end
% calculate transmission coefficients

iang = (inc.*pi)./180;
sinp = (cp2/cp1)*sin(iang);
sins =(cs2/cp1)*sin(iang);
len = length(sinp);
for j=1:len
if sinp(j) >= 1
cosp(j) = i*sqrt(sinp(j)^2 - 1);
else
cosp(j) = sqrt(1 - sinp(j)^2);
end
end
for j=1:len
if sins(j) >= 1
coss(j) = i*sqrt(sins(j)^2 - 1);
else
coss(j) =sqrt(1 - sins(j)^2);
end
end
denom = cosp + (d2/d1)*(cp2/cp1)*sqrt(1-sin(iang).^2).*(4.*((cs2/cp2)^2)...
.*(sins.*coss.*sinp.*cosp) + 1 - 4.*(sins.^2).*(coss.^2));
tpp = (2*sqrt(1 - sin(iang).^2).*(1 - 2*(sins.^2)))./denom;
tps = -(4*cosp.*sins.*sqrt(1 - sin(iang).^2))./denom;
%select appropriate coefficient
if strcmp(type2, 'p')
T12 = tpp;
elseif strcmp(type2, 's')
T12 = tps;
else
error('wrong wave type specification')
end
