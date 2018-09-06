
clear
setup = setup_maker;
% setup parameters that need to be specified for this example
f =s_space(0, 20, 200);
cp1 = 1484.;
d2 = 7.9;
cp2 = 5900;
cs2 = 3200;
z1 = 50.8;
z2 = 19;
amp =0.08;
bw = 4.;
z1r =50.8;
p1 = [ 0 0 0.02479E-03 0 0];
p2 = [ 0 0 50E-06 0 0.125E-12];
b =5;
flaw_name = 'A_void';
setup.f =f;
setup.system.amp = amp;
setup.system.bw = bw;
setup.system.z1r =z1r;
setup.geom.z1 = z1;
setup.geom.z2 = z2;
setup.matl.cp1 = cp1;
setup.matl.d2 = d2;
setup.matl.cp2 = cp2;
setup.matl.cs2 = cs2;
setup.matl.p1 = p1;

setup.flaw.b = b;
setup.flaw.Afunc = flaw_name;
% calculate received voltage
[Vf, setup] = TG_PE_MM(setup);
% extend frequency components to permit
% taking FFT
df = f(2)-f(1);
dt = 1/(1000*df);
t = s_space(0, 1000*dt, 1000);
Vfe = [Vf zeros(1,800)];
Vfe(1) = Vfe(1)/2;
vt =2*real(IFourierT(Vfe, dt));
m_vt=mean(vt);
s_vt=std(vt);
vt=vt-m_vt;
if s_vt!=0
vt=vt./s_vt;
end
vt=vt./max(vt);
figure;
plot(t_shift(t,400), c_shift(vt,400))
