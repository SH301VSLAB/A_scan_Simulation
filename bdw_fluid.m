function p = bdw_fluid(x, y, z, a, c, f, varargin)
% >> p = bdw_fluid(x, y, z, a, c, f, N). A function which returns the 
% normalized pressure, p, for a planar circular piston transducer of 
% radius, a,(in mm), radiating into a fluid of wave speed, c, (in m/sec), 
% at a frequency, f,(in MHz). The pressure is calculated at the points 
% (x, y, z) (in mm), where (x, y, z) can be scalars, vectors, or matrices.
% N, is an optional input parameter that specifies the number of line 
% segments used to approximate the edge integral in a boundary diffraction
% wave model. If N is not specified, N is determined automatically so that
% the line segment length is no larger than one tenth of a wavelength.  
% This function calls the supporting function bdw_model which implements 
% the boundary diffraction wave model of the transducer.



if nargin == 7
    N=varargin{1};
else 
    N = round( 20000*pi*f*a/c);
end

rho = sqrt(x.^2 + y.^2);

[nrz, ncz] = size(z);
[nrR, ncR] =size(rho);

% if rho is a row vector, z a scalar
if ncR > 1 && nrR ==1 && nrz  ==1 && ncz ==1
     Q = ncR;
     p = zeros(1, ncR);

        for qq = 1:Q
            p(1,qq) = bdw_model(rho(1, qq), z, a, c, f, N);
        end
% if rho is a column vector, z a scalar
elseif nrR >1 && ncR == 1 && nrz == 1  && ncz == 1
    P = nrR;
    p =zeros(nrR, 1);
    for pp = 1:P
        p(pp, 1) = bdw_model(rho(pp, 1), z, a,c,f,N);
    end
% if z is row vector, rho a scalar
elseif ncz > 1 && nrz ==1 && ncR ==1 && nrR ==1
    Q = ncz;
    p = zeros(1, ncz);
    for qq = 1:Q
        p(1, qq) = bdw_model( rho, z(1,qq), a,c,f,N);
    end
% if z is a column vector, rho a scalar
elseif nrz > 1 && ncz == 1 && ncR == 1 && nrR == 1
    P = nrz;
    p = zeros(nrz, 1) ;
    for pp = 1:P
            p(pp, 1) = bdw_model( rho, z(pp, 1), a,c,f,N);
    end
% if z and rho are equal size matrices vectors, or scalars
elseif nrz == nrR && ncz == ncR
    P = nrz;
    Q = ncz;
    p =zeros(nrz, ncz);
    for pp = 1:P
        for qq = 1:Q
            p(pp, qq) = bdw_model(rho(pp, qq),z(pp,qq), a,c,f,N);
        end
    end
else error('rho and z combinations not supported')
end
      
          
end
