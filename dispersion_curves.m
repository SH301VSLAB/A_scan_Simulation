% script dispersion_curves
% This script, like the script dispersion_plots, generates a 2_D set of
% non-dimensional frequency and wavespeed values at which the plate wave
% dispersion relations for symmetrical or anti-symmetrical plate waves are
% evaluated. The dispersion curves are then plotted with the MATLAB
% function contour. Individual dispersion curves are then extracted and 
% ordered in frequency. The fundamental flexural mode values for small
% frequencies where the contour values are unreliable are modified with 
% analytical results. The specific dispersion curve specified by the user 
% is then plotted.
clear
% input parameters
% minimum amd maximum fh and c values (keep minimums small, non-zero)
fhmin=.02;
cmin = 0.1;
fhmax = 10;
cmax = 20;
%generrate matrix of values
fh = linspace(fhmin, fhmax, 700);
c = linspace (cmin, cmax, 1000);
[ff, cc] =meshgrid(fh, c);
[nr, nc] =size(cc);
% give compressional and shear wave speeds
cp = 6.42;
cs = 3.04;
%give types of curves sought
type = input( ' give input type as ''s'' or ''a''  '  );
% evaluate dispersion function and plot contours
yy=Rayleigh_LambM(cc, cp, cs,ff, type);
%plot contours
[con, h]=contour(ff,cc,real(yy),[0,0], 'b');

% get curve data, order in frequency
indx =find( con(1,:) == 0 ) ;% index of zeros
indfp =indx+1 ;%index of first data point in a curve
numcurves = size(indx, 2);%number of curves
numpts = con(2,indx); % number of points in a curve
[firstpts, ind] =sort(con(1, indx+1)); % ind gives order of curves in freq

%put fh, c data for each mode curve in cells of dimensions numpts x 2
for nn = 1:numcurves
    x{nn, 1} = con(1, indfp(ind(nn)): indfp(ind(nn))+numpts(ind(nn)) -1);
    x{nn, 2}=con(2, indfp(ind(nn)): indfp(ind(nn))+numpts(ind(nn)) -1);
end

% num is value input by user to give mode number or end script
num = 0;

% check that fhmin is 0.02 if flexural mode (value can be changed, but
% low frequency extension of flh below must be changed)
if strcmp(type,'a')
   if fhmin ~= 0.02
       warning(' smallest fh value should be 0.02')
   end
   
% form up low frequency values, use analytical expressions to fill
% in fundamental flexural mode values (note:may have different spacing than
% other points in the curve above fhmin)
flh=linspace(0,0.02,20);
K=(4*(cp^2 -cs^2)*cs^2/3)^0.25;
cl= K*(2*pi*flh/cp).^0.5;
x1 =x{1,1};
y1 =x{1,2};
indl = find( x1 >0.02);
x{1,1} =[flh x1(indl)];
x{1,2} =[cl  y1(indl)];
end

%plot specific dispersion curve specified by num, continue to allow
% plots until num = 'd' or num is non-numeric
figure(2)
while isnumeric(num)
    num = input(' mode number or ''d'' when done    ');
    if isnumeric(num)
        plot(x{num,1}, x{num, 2})
        axis( [0, fhmax, 0, cmax])
    end

end

