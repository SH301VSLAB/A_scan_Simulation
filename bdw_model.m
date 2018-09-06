function p =bdw_model(rho, z, a, c, f, N)
% p =bdw_model(rho, z, a, c, f, N) computes the normalized pressure for
% a circular transducer of radius, a,(in mm), radiating into a fluid of
% wave speed, c, (in m/sec), at a frequency, f,(in MHz). The pressure is
% calculated at the radial distance rho (in mm) and axial distance, z, 
% (in mm) in the fluid. N is the number of line segments used to 
% approximate the edge integral in a boundary diffraction wave model.
% All input and output parameters must be scalars.
% This is a supporting function which called multiple times by the 
% function bdw_fluid.

% define wave number
k = 2000*pi*f/c;
% generate N+1 (x,y) values on transducer edge
dang = 2*pi/N;
ang = linspace(-dang/2 , 2*pi-dang/2, N+1);
xn = a*cos(ang);
yn = a*sin(ang);

% define start values (xns, yns) and finish values (xnf, ynf) for
% the N segments
xns = xn(1:end-1);
xnf = xn(2:end);
yns = yn(1:end-1);
ynf = yn(2:end);

% define distances, d1, from point yo to the start of the segments,and
% the distances, d2, from point yo to the end of the segments,
% and le, the lengths of the segments 
d1 =sqrt((xns - rho).^2 + yns.^2);
d2 =sqrt((xnf -rho).^2 + ynf.^2);
le = sqrt((xnf -xns).^2 +(ynf- yns).^2);
% dphi are the angles subtended by segments as measured from point yo
dphi=acos((d1.^2 +d2.^2 -le.^2)./(2*d1.*d2));
% xc and yc are the (x,y) values of the centroids of the segments
xc = (xnf + xns)/2;
yc = (ynf + yns)/2;
% rhoe are the distances from point yo to the segment centroids
rhoe = sqrt((xc -rho).^2 +yc.^2);
% re are the distances from the point in the fluid 
% to the segment centroids
re =sqrt(z^2 +rhoe.^2);  

% define the angles, angc, to the segment centroids, as measured from the
% center of the transducer. Note that xc(1) = yc(1) =0 so to compute the 
% angle increment,da, we can use the xc(2) and yc(2) values only.
da =acos(xc(2)/sqrt(xc(2)^2 +yc(2)^2));  %angle increment
num =0:1:N-1;                            % N values, starting from zero
angc =num*da;                            % angles to the centroids

% form up the beam model
 if rho <= a  % if inside or on the main beam, compute normalized pressure
    p =exp(1i*k*z) -(1/(2*pi))*sum(exp(1i*k*re).*dphi);
 else  %else, if outside the main beam
    % define angle limits of C+ and C- as measured from center of 
    %the transducer  
    ang1 =acos(a/rho);
    ang2 = 2*pi - ang1;
    %define logical mask, rep, for C+, and logical mask, rem, for C-
    rep =( angc >= ang1 & angc <= ang2);
    rem = (angc < ang1 | angc > ang2);
    %compute normalized pressure
    p = (1/(2*pi))*sum(exp(1i*k*re).*dphi.*rem) - ...
        (1/(2*pi))*sum(exp(1i*k*re).*dphi.*rep);
 end
end