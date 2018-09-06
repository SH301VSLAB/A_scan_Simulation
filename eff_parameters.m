function  [aeff, Reff] = eff_parameters(c,f,zmin,varargin)
% [aeff, Reff] = eff_parameters(c,f,zmin, zmax) computes the effective
% radius (aeff) and effective focal length (Reff) from measurements
% of zmin and zmax (both in mm),the on-axis min and max locations 
% in the frequency domain response of the transducer,at a frequency f 
% (in MHz) where the wave speed c is in meters/sec. If zmax is not 
% specified, Reff =inf (planar transducer)and only aeff is calculated.
% This function calls a supporting function, transeq.

cm = c/1000;  % put c in mm/microsec
lamba = cm/f;           % wave length (mm)
if nargin == 4 
    zmax = varargin{1};  
    k = 2*pi/lamba;         % wave number (rad/mm)
    
    % solve for intermediate parameter x as the root of transeq
    x = fzero(@transeq,[.01, pi/2],[],  zmin, zmax, k);
    
    %form up Reff, aeff expressions
    n = pi -x +(pi^2 - x^2*zmin/zmax)/(k*zmin);
    d = pi - x*zmax/zmin + (pi^2 - x^2)/(k*zmin);
    Reff = zmax*n/d;
    aeff = sqrt(2*zmin*lamba*Reff/(Reff-zmin));
    
else

    aeff =sqrt(2*lamba*zmin);
    Reff =inf;
    
end



