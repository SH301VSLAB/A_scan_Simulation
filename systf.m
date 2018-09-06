function y = systf (setup)
% systf(setup) models the system function by a Gaussian window function
% of amplitude amp centered at frequency fc and with a bandwidth bw defined to
% be the spread in frequency at the half amplitude point in the Gaussian.
% The Gaussian is tapered to zero at frequencies below fc with a sine function to
% guarantee the dc value is always zero.
% For small fc and large bw, this tapering will distort the Gaussian
%
f =setup.f;
amp = setup.trans.amp;
fc = setup.trans.fc;
bw = setup.trans.bw;
a = sqrt(log(2))/(pi*bw);
s1 = exp(-(2*a*pi*(f - fc)).^2).*(f > fc);
s2 = exp(-(2*a*pi*(f - fc)).^2).*sin(pi*f/(2*fc)).*(f <= fc);
y = amp*(s1 + s2);
