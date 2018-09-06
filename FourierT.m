function y = FourierT(x, dt)
% FourierT(x,dt) computes forward FFT of x with sampling time interval dt
% FourierT approximates the Fourier transform  where the integrand of the
% transform is x*exp(2*pi*i*f*t)
% For NDE applications the frequency components are normally in MHz, 
% dt in microseconds 
[nr, nc] = size(x);
if nr == 1
N = nc;
else 
	N = nr;
end
y = N*dt*ifft(x);
