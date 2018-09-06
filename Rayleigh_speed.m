function y = Rayleigh_speed(cp, cs)
% cr = Rayleigh_speed(cp,cs) returns the Rayleigh wave speed, cr, at a free
% surface of a solid where (cp,cs) are the P-wave and S-wave speeds,
% respectively. The units of the wave speeds are arbitrary but must be
% consistent.

y = fzero( @(x) Rayleigh(x, cp, cs), [0.8*cs, cs]);
end

% the Rayleigh function
function y = Rayleigh(x, cp, cs)
y =(2-x.^2/cs.^2).^2 -4*sqrt(1-x.^2./cp.^2).*sqrt(1-x.^2./cs.^2);
end