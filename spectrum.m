function V = spectrum(f, B, fc, bw)
% V = spectrum(f, B, fc, bw) returns a Gaussian-shaped spectrum,V, for a 
% pulse whose time domain waveform is v = B*cos(2*pi*fc*t)*exp(-t^2/4a^2), 
% where fc is the center frequency (in MHz when t is in microseconds), and
% bw is the -6dB bandwidth (in MHz). Note that this is a function defined 
% only for positive frequencies so to recover the real time domain
% waveform, v, we must let V(1) = V(1)/2, and take twice the real part of
%  the inverse FFT.

a = sqrt(log(2))/(pi*bw); 
V = B*a*sqrt(pi)*exp(-4*(pi^2)*(a^2)*(f -fc).^2);
