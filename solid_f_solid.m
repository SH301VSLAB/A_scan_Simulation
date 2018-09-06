function [tpp,tps]= solid_f_solid(iangd,d1, d2, cp1, cs1, cp2, cs2)% [tpp, tps] = solid_f_solid(iangd, d1, d2, cp1, cs1, cp2, cs2) returns the% P-P (tpp)and P-S (tps) transmission coefficients based on velocity ratios% for two solids in smooth contact through an intermediate fluid layer of% zero thickness. (d1, cp1, cs1) are the density, P-wave speed, and S-wave% speed for the first solid while (d2, cp2, cs2) are the corresponding% parameters for the second solid. The units of these parameters are% arbitrary but must be consistent%% Note: If cs1 = 0  the values returned are for a fluid-solid interface.iang = (iangd.*pi)./180;  %change degrees to radians%calculate sines and cosines of all incident and refracted anglessinp1 = sin(iang);cosp1 = sqrt(1-sinp1.^2);sins1 = (cs1/cp1)*sin(iang);coss1= sqrt(1-sins1.^2);sinp2 = (cp2/cp1)*sin(iang);sins2 =(cs2/cp1)*sin(iang);% take into account cosines of refracted angles may be imaginary beyond% critical angles cosp2= (1i*sqrt(sinp2.^2 - 1)).*(sinp2 >= 1) + ...    (sqrt(1 - sinp2.^2)).*(sinp2 < 1);coss2 = (1i*sqrt(sins2.^2 - 1)).*(sins2 >= 1) + ...    (sqrt(1 - sins2.^2)).*(sins2 < 1);%calculate transmission coefficientsdenom1 = (cp1/cp2).*(cosp2./cosp1).*...    (4.*((cs1/cp1)^2).*(sins1.*coss1.*sinp1.*cosp1) + ...    1 - 4.*(sins1.^2).*(coss1.^2));denom2 = (d2/d1).*(4.*((cs2/cp2)^2).*(sins2.*coss2.*sinp2.*cosp2) ...		+ 1 - 4.*(sins2.^2).*(coss2.^2));    denom = denom1 + denom2;   tpp = ((2*cp1/cp2).*(1-2*sins1.^2).*(1-2*sins2.^2))./denom;tps = -((4*cp1*cs2/(cp2^2)).*sinp2.*cosp2.*(1-2*sins1.^2))./denom;