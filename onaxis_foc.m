function [p] = onaxis_foc(z, f, a, R, c)
% [p]= onaxis_foc(z, f, a, R, c) calculates the on-axis pressure,p, at the
% locations z(in mm)of a spherically focused transducer of radius a 
% (in mm) and focal length R(in mm) radiating into a fluid with wave speed  
% c(in m/sec), using the O'Neil model. If R = inf, the function returns the
% on-axis pressure of a planar transducer of radius a. 

% define O'Neil model parammeters h, k, q0
if R == inf
    h = 0 ;
else
h=R-sqrt(R^2 -a^2);
end

k= 2000*pi*f/c; % wave number (rad/mm)
q0 = 1 - z/R;
re = sqrt((z-h).^2 + a^2);

% calculate on-axis pressure
p = (1./q0).*(exp(1i*k.*z)- exp(1i*k.*re));
 
