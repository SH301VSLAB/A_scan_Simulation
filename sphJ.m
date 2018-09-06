function y = sphJ(n, x)
% >> y = sphJ(n,x). A function which  returns the spherical Bessel function
% of order n at x, where x is a non-dimensional argument. It is used in
% separation of variables solutions.

x = x + eps*(x == 0);
y = besselj(n+1/2, x).*sqrt(pi./(2*x));