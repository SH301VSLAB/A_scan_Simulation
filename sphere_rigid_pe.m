function A = sphere_rigid_pe(f,b,c) 
% >> A = sphere_rigid_pe(f, b, c). A function which calculates the 
% pulse-echo scattering amplitude, A, (in mm) for a rigid sphere of radius
% b (in mm) in a fluid with wave speed, c, (in m/sec). This function uses
% the method of separation of variables.  


kb = 2000*pi*f*b/c;

% break wave number into two regions: kb < 2 and kb >= 2
indc = find(kb < 2.);      
kbd =kb(indc);
ind2 =find(kb >= 2.);
kbu = kb(ind2);

% use relatively small, fixed number of terms for kb <2
num = 10;
% compute scattering amplitude over kb <2 
A1 =sca(kbd,num);

% use much larger number of terms for kb >= 2
num2= 10 + round(kbu(end));
% compute scattering amplitude over kb >= 2 
A2 = sca(kbu, num2);

% combine two ranges
A= [A1  A2];
% force zero frequency scattering amplitude to zero exactly
A(1) =0;




function A = sca(x, numb)
x = x + eps*(x == 0); 
A = zeros(size(x)); 
c0 = sphJ(1, x)./sphH(1,x); 

for k = 1:numb 
c = (k*sphJ(k,x) - x.*sphJ(k+1,x))./(k*sphH(k, x) - x.*sphH(k+1,x)); 
A = A + ((-1.)^k)*(2.*k +1)*c; 
end 
A = 1i*(A +c0)./x; 