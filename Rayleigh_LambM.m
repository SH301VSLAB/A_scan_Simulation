function y=Rayleigh_LambM(c, cp, cs, fh, type)
% y = Rayleigh_LambM(c, cp, cs, fh, type) returns the Rayleigh-Lamb
% function values for symmetrical or unsymmetrical plate waves. The input
% parameter, c, is the wave speed of the plate wave, while (cp, cs) are the
% compressional and shear wave speeds of the plate, respectively. The wave 
% speed values are arbitrary but must be consistent. The parameter fh is the
% frequency times the half width of the plate. The parameter, type, is a
% string,('s' or 'a')for symmetrical or ant-symmetrical modes,
% respectively.


kh=(2*pi.*fh./c);
qh =kh.*sqrt(c.^2/(cs^2) -1);
ph = kh.*sqrt(c.^2/(cp^2) -1);

num0 = (c.^2/(cs^2)-2 ).^2;
num1 = sqrt(c.^2/(cs^2) -1);
num2 = sqrt(c.^2/(cp^2) -1);
if type == 's' 
y = num0.*sin(qh).*cos(ph) + 4.*num1.*num2.*sin(ph).*cos(qh);
y = y.*(imag(y) == 0)- i.*y.*(imag(y)~= 0);  
    
elseif type == 'a'
y = num0.*sin(ph).*cos(qh) + 4.*num1.*num2.*sin(qh).*cos(ph);
y = y.*(imag(y) == 0)- i.*y.*(imag(y)~= 0);
else
    error( 'type must be ''s'' or ''a'' ')
end