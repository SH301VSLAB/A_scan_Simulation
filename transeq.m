function y = transeq(x, zmin, zmax, k)
% y = transeq(x, zmax, zmin, k) returns the values y of the 
% equation y = f(x, zmin, zmax, k), where (zmin, zmax) are measured
% values (in mm)of the on-axis min and max response of a focused 
% transducer and k is the wave number (rad/mm).The function f is a 
% supporting function needed to determine the effective parameters of a
% spherically focused transducer. 

% form up y = f(x, zmin, zmax, k) function
t1 = x.*cos(x).*( pi -x + (pi^2 -x.^2)/(k*zmin));
t2 = sin(x).*(pi -x*zmax/zmin + (pi^2 - x.^2)/(k*zmin));
t3 = 2*(1 +2*x/(k*zmax))./(2 + 2*x/(k*zmax));
y = t1 -t2.*t3;