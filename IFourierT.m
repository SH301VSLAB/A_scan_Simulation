function y = IFourierT(x, dt)
% IFourierT(x,dt) computes the inverse FFT of x, for a sampling time interval dt
% IFourierT assumes the integrand of the inverse transform is given by
% x*exp(-2*pi*i*f*t) 
% The first half of the sampled values of x are the spectral components for
% positive frequencies ranging from 0 to the Nyquist frequency 1/(2*dt)
% The second half of the sampled values are the spectral components for
% the corresponding negative frequencies. If these negative frequency
% values are set equal to zero then to recover the inverse FFT of x we must
% replace x(1) by x(1)/2 and then compute 2*real(IFourierT(x,dt))

[nr,nc] = size(x);
if nr == 1
	N = nc;
else
	N = nr;
end
y =(1/(N*dt))*fft(x);
