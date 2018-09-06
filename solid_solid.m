function [tp, ts, rp ,rs]= solid_solid(iangd, d1, d2, cp1, cs1, cp2, cs2, type)
% [ tp, ts, rp, rs] = solid_solid(iangd, d1, d2, cp1, cs1, cp2, cs2, type)
% returns the transmitted P-wave (tp), transmitted SV-wave (ts), reflected
% P-wave (rp), and reflected SV-wave (rs) transmission/reflection 
% coefficients (based on velocity ratios) for two solids in welded contact.
% The inputs are the incident angle(s),iangd,(in degrees), (d1, d2), the
% densities of the two media, (cp1, cs1), the compressional and shear wave
% speeds of the first medium, and (cp2, cs2) the compressional and shear
% wave speeds of the second medium. type is a string ('P' or 'S')
% indicating the type of incident wave in medium one. If cs1 =0 and
% type = 'P' the function returns the coefficients for a fluid-solid 
% interface with rs = 0. The wave speed cs2 cannot be set equal to zero.

if cs2 == 0
    error(' cs2 must be greater then zero')
end

iang = (iangd.*pi)./180;  %change degrees to radians

if strcmp(type, 'P')
%calculate sines and cosines of all incident and refracted angles
sinp1 = sin(iang);
sins1 = (cs1/cp1)*sin(iang);
sinp2 = (cp2/cp1)*sin(iang);
sins2 =(cs2/cp1)*sin(iang);
elseif strcmp(type, 'S')
    if cs1 == 0
        error('cs1 must be geater than zero for incident S-wave')
    end
sins1 = sin(iang);
sinp1 = (cp1/cs1)*sin(iang);
sinp2 = (cp2/cs1)*sin(iang);
sins2 =(cs2/cs1)*sin(iang);   
else
    error('type must be ''P'' or ''S'' only')
end
% take into account cosines may be imaginary beyond
% critical angles 
cosp1= (1i*sqrt(sinp1.^2 - 1)).*(sinp1 >= 1) + ...
    (sqrt(1 - sinp1.^2)).*(sinp1 < 1);
coss1= (1i*sqrt(sins1.^2 - 1)).*(sins1 >= 1) + ...
    (sqrt(1 - sins1.^2)).*(sins1 < 1);
cosp2= (1i*sqrt(sinp2.^2 - 1)).*(sinp2 >= 1) + ...
    (sqrt(1 - sinp2.^2)).*(sinp2 < 1);
coss2 = (1i*sqrt(sins2.^2 - 1)).*(sins2 >= 1) + ...
    (sqrt(1 - sins2.^2)).*(sins2 < 1);
%double angle functions
sin2s1 = 2*sins1.*coss1;
sin2s2 = 2*sins2.*coss2;
sin2p1 = 2*sinp1.*cosp1;
sin2p2 = 2*sinp2.*cosp2;

cos2s1 = 1 - 2*sins1.^2;
cos2p1 = 1 - 2*sinp1.^2;
cos2s2 = 1 - 2*sins2.^2;
cos2p2 = 1 - 2*sinp2.^2;

% form up terms
den1 = (cs1/cp1)*sin2s1.*sinp1 +cos2s1.*coss1;
den2 = (cs1/cp1)*sin2p1.*sins1 + cos2s1.*cosp1;
l1 = (cs1/cp2)*sin2s1.*sinp2 +(d2/d1)*cos2s2.*coss1;
m1 = (cs1/cs2)*sin2s1.*coss2 - (d2/d1)*sin2s2.*coss1;
l2 = (cs1/cp2)*cos2s1.*sinp2 -(d2/d1)*cos2s2.*sins1;
m2 = (cs1/cs2)*cos2s1.*coss2 +(d2/d1)*sin2s2.*sins1;
l3 = (cp1/cp2)*cos2s1.*cosp2 +(d2*cs2^2/(d1*cp2^2))*sin2p2.*sinp1;
m3 = -(cp1/cs2)*cos2s1.*sins2 +(d2/d1)*cos2s2.*sinp1;
l4 = -(cs1^2/(cp1*cp2))*sin2p1.*cosp2 +(d2*cs2^2/(d1*cp2^2))*sin2p2.*cosp1;
m4 = (cs1^2/(cp1*cs2))*sin2p1.*sins2 +(d2/d1)*cos2s2.*cosp1;

den = (l2./den1 + l4./den2).*(m1./den1 + m3./den2) - ...
    (l1./den1 +l3./den2).*(m2./den1 +m4./den2);

%calculate potential ratios
atai = -2*(m2./den1 + m4./den2)./den;
btai = 2*(l2./den1 + l4./den2)./den;
arai = ((l2./den1 + l4./den2).*(m1./den1 - m3./den2) - ...
    (l1./den1 - l3./den2).*(m2./den1 + m4./den2))./den;
brai = (2*(l2./den1).*(m4./den2) - 2*(m2./den1).*(l4./den2))./den;
atbi = 2*(m1./den1 + m3./den2)./den;
btbi = -2*(l1./den1 + l3./den2)./den;
brbi = ((l4./den2 - l2./den1).*(m1./den1 + m3./den2) - ...
    (l1./den1 + l3./den2).*(m4./den2 - m2./den1))./den;
arbi = (2*(l1./den1).*(m3./den2) - 2*(m1./den1).*(l3./den2))./den;

%calculate velocity ratios
if strcmp(type, 'P')
tp = (cp1/cp2)*atai;
ts =(cp1./cs2)*btai;
rp= arai;
    if cs1 > 0
    rs = (cp1/cs1)*brai;
    else
    rs =0;
    end
end
if strcmp( type, 'S')
tp = (cs1/cp2)*atbi;
ts = (cs1/cs2)*btbi;
rp= (cs1/cp1)*arbi;
rs = brbi;

end
