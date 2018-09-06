function [Rp, Rs] = stress_freeP(ang, cp, cs)
% >>[Rp, Rs] = stress_freeP(ang, cp, cs) returns the plane wave
% reflection coefficients (based on velocity ratios)
% for a plane P-wave incident on a plane,stress free surface
% of an elastic solid. ang is the incident angle (in degrees), 
% cp, cs are the P- and S-wave speeds, respectively,and Rp, Rs are
% the reflection coefficients for the reflected P-waves and S-waves,
% respectively. The units of the wave speeds are  arbitrary but must be
% consistent.
% Note that there are no critical angles for this case.

% incident angle in radians
iang =ang*pi/180;

% sines of reflected wave angles 
sinp1= sin(iang);
sins1 = (cs/cp).*sinp1;

% sines and cosines of 2 x reflected angles
sin2p1 = 2.*sinp1.*sqrt(1-sinp1.^2);
sin2s1 = 2.*sins1.*sqrt(1-sins1.^2);
cos2s1 = (1-2.*sins1.^2);

% the reflection coefficients
delta = sin2p1.*sin2s1 +((cp/cs)^2).*(cos2s1.^2);
Rp = (sin2p1.*sin2s1 -((cp/cs)^2).*cos2s1.^2)./delta;
Rs = -(2*(cp/cs).*sin2p1.*cos2s1)./delta;
