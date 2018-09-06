% script dispersion_plots
% The script dispersion_plots creates a 2-D set of normalized frequency and
% wave speed values at which the Rayleigh-Lamb dispersion function for
% symmetrical or anti-symmetrical plate waves is evaluated. The MATLAB
% function contour is then used to plot the dispersion curves for this 2-D
% region.Note that the fundamental anti-symmetrical mode plot is unrelaible
% at very small frequencies and must be replaced by the analytical results
% for this mode at those values.

% give input parameters
fh = linspace(.1, 10, 1000); % frequency time half plate widths
c = linspace (0.1, 20, 1000); % phase velocities

%form  grid of values
[ff, cc] = meshgrid(fh, c);
cp = 6.42; % compressional wave speed
cs = 3.04; % shear wave speed

% input type of mode,'s' = symmetrical, 'a' = anti-symmetrical

type = input( ' give input type as ''s'' or ''a''  '  );

% evaluate dispersion function 
yy = Rayleigh_LambM(cc, cp, cs,ff, type);

%plot contours
contour(ff,cc,real(yy),[0,0], 'b');