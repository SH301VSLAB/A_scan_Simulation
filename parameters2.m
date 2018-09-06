% parameters2 script
% >> parameters2. A script which is used to define the input parameters 
% needed to model a planar or focused circular piston transducer radiating 
% through a curved interface. These parameters are then placed in a MATLAB
% structure called setup.  

%frequency (in MHz)and wave type in mediums 1 and 2 ( 'p' or 's')
f = 10;
type1 = 'p';
type2 ='p';

% type of interface (fluid-solid (fs) or smooth solid-solid (ss))
int = 'fs';

% transducer parameters: diameter (in mm) and focal length ( in mm)
d = 12.7;
fl= inf;

% geometry parameters: axial distances in media 1 and 2 ( D and y3) and 
% distances from central axis,y1, in plane of incidence, and distance, y2,
% normal to the plane of incidence. 
% All distances in mm. The incident angle of the transducer is
% iang (in degrees) and the principal curvatures of the interface, 
% R1 and R2, in and out of the plane of incidence (in mm) 
D = 10.0;
y3 = linspace(10,200,500);
y1 = 0.0;
y2 =0.0;
i_ang = 0;
R1 = inf;
R2 = inf;

% density, wave speed parameters. densities are arbitrary units, wave
% speeds are in m/sec
d1 = 1.0;
d2 = 7.9;
cp1 =1480;
cs1 = 0;
cp2 =5900;
cs2 = 3200;



% put parameters in a structure called setup
setup.f = f;
setup.type1 = type1;
setup.type2 = type2;
setup.int = int;

setup.trans.d = d;
setup.trans.fl =fl;

setup.geom.D = D;
setup.geom.y3 = y3;
setup.geom.y1 = y1;
setup.geom.y2 = y2;
setup.geom.i_ang = i_ang;
setup.geom.R1 =R1;
setup.geom.R2 = R2;

setup.matl.d1 =d1;
setup.matl.d2 = d2;
setup.matl.cp1 =cp1;
setup.matl.cs1 = cs1;
setup.matl.cp2 = cp2;
setup.matl.cs2 =cs2;



