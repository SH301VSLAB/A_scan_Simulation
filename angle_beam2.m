% angle_beam2 is a script which generates an image of the wave field of a 45
% degree angle beam shear wave transducer in the plane of incidence. The
% script uses the multi-Gaussian beam model MG_beam.

% generate (zt, xt) values where xt is along the interface, zt normal to
% the interface pointing into the solid being inspected
zt = linspace (0, 40, 300);
xt = linspace( -20, 30, 400);

% generate a matrix of values, rotate to get coordinates (y1t, y3t) needed 
% for the multi_Gaussian transducer beam model 
[xx, zz] =meshgrid(xt, zt);
y3t = cosd(45)*zz +sind(45)*xx;
y1t = -sind(45)*zz +cosd(45)*xx;

setup.f = 10;       % 10 MHz
setup.type1 = 'p';  % P-wave in wedge
setup.type2 = 's';  % SV-wave in solid
setup.int = 'ss';   % solid-solid interface in smooth contact
% 12.7 mm diameter planar transducer
setup.trans.d = 12.7; 
setup.trans.fl =inf;
% 20 mm path length in wedge, calculate in plane of incidence.

setup.geom.D = 20;
setup.geom.y3 = y3t;
setup.geom.y1 = y1t;
setup.geom.y2 = 0;
% incident angle in Lucite wedge to generate 45 degree shear wave in the 
% aluminum for planar interface
setup.geom.i_ang = 38.91;
setup.geom.R1 = inf;
setup.geom.R2 = inf;
% material properties for Lucite wedge, aluminum solid
setup.matl.d1 = 1.15;
setup.matl.d2 = 2.7;
setup.matl.cp1 =2700;
setup.matl.cs1 = 1100;
setup.matl.cp2 = 6420;
setup.matl.cs2 = 3040;
% generate normalized velocity wave field and display image
v = MG_beam2(setup);
imagesc(xt, zt, abs(v))
colormap(jet)