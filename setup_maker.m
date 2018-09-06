function setup =setup_maker( )
%setup parameters
f = 5;
type1 = 'p';
type2 ='p';
% system function parameters
sysf = ' systf ' ;
amp = 5.0E-02;
fc = 5;
bw = 4.;
z1r = 0.0;
en =0.01;
ref_file = ' empty ' ;
% transducer parameters
d = 9.535;
fl= inf;
%geometry parameters
z1 = 0;
z2 = linspace(0,200,512);
x2 = 0.0;
y2 =0.0;
i_ang = 0;
R1 = inf;
R2 = inf;
p_ang = 0;
% material parameters
d1 = 1.0;
d2 = 1.0;
cp1 =1480;
cs1 = 0;
cp2 =1480;
cs2 = 0;
p1 = zeros(1,5);
s1 = zeros(1,5);
p2 = zeros(1,5);
s2 = zeros(1,5);
%flaw parameters
b =0.0;
f_ang = 0.0;

Afunc = ' empty ' ;
%wave parameters
c1 =1480;
c2 = 1480;
T12 =1.0;
%system function 
amp=0.05;
fc=5.0;
bw=3.0;

% put setup in a structure
setup.f = f;
setup.type1 = type1;
setup.type2 = type2;
setup.system.sysf = 'systf';
setup.system.amp =amp;
setup.system.fc = fc;
setup.system.bw = bw;
setup.system.z1r =z1r;
setup.system.en =en;
setup.system.ref_file = ref_file;
setup.trans.d = d;
setup.trans.fl =fl;
setup.trans.amp=amp;
setup.trans.fc=fc;
setup.trans.bw=bw;
setup.geom.z1 = z1;
setup.geom.z2 = z2;
setup.geom.x2 = x2;
setup.geom.y2 = y2;
setup.geom.i_ang = i_ang;
setup.geom.R1 =R1;
setup.geom.R2 = R2;
setup.geom.p_ang = p_ang;
setup.matl.d1 =d1;
setup.matl.d2 = d2;
setup.matl.cp1 =cp1;
setup.matl.cs1 = cs1;
setup.matl.cp2 = cp2;
setup.matl.cs2 =cs2;
setup.matl.p1 = p1;
setup.matl.s1 =s1;
setup.matl.p2 = p2;
setup.matl.s2 = s2;
setup.flaw.b = b;
setup.flaw.f_ang = f_ang;
setup.flaw.Afunc = Afunc;
setup.wave.c1 = c1;
setup.wave.c2 = c2;
setup.wave.T12 = T12;
