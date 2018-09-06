function [pds, a] = K_sizing(c, theta, phi, dt)
% >> [pds, a] = K_sizing(c, theta, phi, dt). A function which returns 
% matrices containing the direction cosines, pds, and lengths of the 
% semi-major axes ,a,(in mm)of an equivalent flat elliptical crack in  a 
% solid with wave speed ,c, (in mm/microsec), based on measured times 
% between flashpoints, dt, (in microsec) at the spherical angles angles 
% (theta, phi), measured in degrees.  


%number of look angles
[nr, nc] = size(dt);
if nr == 1
    M = nc;
elseif nc == 1
    M = nr;
else
    error('data must be row or column vector')
end
                                                       
% calculate equivalent radius values and the square of those values
re=c*dt/4;
re2 =re.*re;
% calculate incident wave unit vectors e  for all the look angles
for mm=1:M
    e1(mm)=sin(theta(mm)*pi/180)*cos(phi(mm)*pi/180);
    e2(mm)=sin(theta(mm)*pi/180)*sin(phi(mm)*pi/180);
    e3(mm) =cos(theta(mm)*pi/180);
end
% setup 6x6 matrix of coefficients for C's 
%(note it is symmetric)
K=zeros(6,6);
K(1,1)= sum(e1.^2.*e1.^2);
K(1,2) =sum(e1.^2.*e2.^2);
K(1,3) =sum(e1.^2.*e3.^2);
K(1,4)=sum(e1.^2.*e1.*e2);
K(1,5) =sum(e1.^2.*e1.*e3);
K(1,6) =sum(e1.^2.*e2.*e3);
K(2,1)= sum(e2.^2.*e1.^2);
K(2,2) =sum(e2.^2.*e2.^2);
K(2,3) =sum(e2.^2.*e3.^2);
K(2,4)=sum(e2.^2.*e1.*e2);
K(2,5) =sum(e2.^2.*e1.*e3);
K(2,6) =sum(e2.^2.*e2.*e3);
K(3,1)= sum(e3.^2.*e1.^2);
K(3,2) =sum(e3.^2.*e2.^2);
K(3,3) =sum(e3.^2.*e3.^2);
K(3,4)=sum(e3.^2.*e1.*e2);
K(3,5) =sum(e3.^2.*e1.*e3);
K(3,6) =sum(e3.^2.*e2.*e3);
K(4,1)= sum(e1.*e2.*e1.^2);
K(4,2) =sum(e1.*e2.*e2.^2);
K(4,3) =sum(e1.*e2.*e3.^2);
K(4,4)=sum(e1.*e2.*e1.*e2);
K(4,5) =sum(e1.*e2.*e1.*e3);
K(4,6) =sum(e1.*e2.*e2.*e3);
K(5,1)= sum(e1.*e3.*e1.^2);
K(5,2) =sum(e1.*e3.*e2.^2);
K(5,3) =sum(e1.*e3.*e3.^2);
K(5,4)=sum(e1.*e3.*e1.*e2);
K(5,5) =sum(e1.*e3.*e1.*e3);
K(5,6) =sum(e1.*e3.*e2.*e3);
K(6,1)= sum(e3.*e2.*e1.^2);
K(6,2) =sum(e3.*e2.*e2.^2);
K(6,3) =sum(e3.*e2.*e3.^2);
K(6,4)=sum(e3.*e2.*e1.*e2);
K(6,5) =sum(e3.*e2.*e1.*e3);
K(6,6) =sum(e3.*e2.*e2.*e3);
% compute right side of least squares equations
b(1) =sum(re2.*e1.^2);
b(2)=sum(re2.*e2.^2);
b(3)=sum(re2.*e3.^2);
b(4) = sum(re2.*e1.*e2);
b(5) =sum(re2.*e1.*e3);
b(6)=sum(re2.*e2.*e3);
%solve for Cs, put in 3x3 matrix
x=K\b';
C(1,1) = x(1);
C(2,2) = x(2);
C(3,3) = x(3);
C(1,2) = x(4);
C(2,1) = C(1,2);
C(1,3) = x(5);
C(3,1) = C(1,3);
C(2,3) = x(6);
C(3,2) = C(2,3);
% compute principal values and directions, take square root to get 
% semi-major axis lengths of equivalent ellipsoid
[pds, pvals]=eig(C);

%take real part to eliminate imaginary values
a=real(sqrt(pvals));