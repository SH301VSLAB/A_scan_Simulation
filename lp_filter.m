function  Vf =lp_filter(f, fstart, fend)
% >> y = lp_filter(f, fstart, fend). A function which returns a low-pass 
% filter, y, at the frequencies contained in the vector f. The filter has 
% values of 1.0 below the frequency value fstart and tapers to zero at 
% frequencies above the value fend with a cosine function. An error is
% returned if fend is outside the range of values contained in the vector 
% f or if fend is less than fstart.

if fend > f(end)
    error( 'fend exceeds max frequency')
end
if fend < fstart
    error(' fend must be greater than fstart')
end
const = ones(size(f)).*(f < fstart);
taper = cos(pi.*(f-fstart)./(2*(fend-fstart))).*(f >= fstart & f <= fend);
Vf = const + taper;