
clear
setup = setup_maker;
% setup parameters that need to be specified for this example
f =s_space(0, 10, 100);
cp1 = 1484.;
d2 = 7.9;
cp2 = 5900;
cs2 = 3200;
zl1 = [10. 15. 20. 30. 40.,50.];
zl2 = [4. 8. 16. 19. 24. 28.];
amp =10;
cap_ampl=10^0.5*amp;
bw = 4.;
z1r =50.8;
p1 = [ 0 0 0.02479E-03 0 0];
p2 = [ 0 0 50E-06 0 0.125E-12];
bl =[0.5 0.75 1 1.25 1.5 1.75 2 2.25 2.5 2.75 3];
%f_ang=20;



setup.system.amp = amp;
setup.system.bw = bw;
setup.system.z1r =z1r;

setup.matl.cp1 = cp1;
setup.matl.d2 = d2;
setup.matl.cp2 = cp2;
setup.matl.cs2 = cs2;
setup.matl.p1 = p1;

flaw_name = 'A_crack';
setup.f =f;
setup.flaw.Afunc = flaw_name;

fvt=[];
ind=1;
for i1=1:length(zl1)
z1=zl1(i1);
for i2=1:length(zl2)
z2=zl2(i2);
for i3=1:length(bl)
b=bl(i3);

setup.flaw.b = b;
%setup.flaw.f_ang = f_ang;


setup.geom.z1 = z1;
setup.geom.z2 = z2;
nR= 10; % use 9 rings (10 points)
rm = linspace(0, b, nR); %ring edges
rmu = rm(2:nR); %upper edges
rml =rm(1:nR-1); %lower edges
rc =(rmu-rml)/2 + rml; %ring centroids
rc(1) = 0; %make first centroid at origin
Vf = zeros(size(f));
% calculate received voltage
for nd = 1:nR-1
setup.geom.x2 = rc(nd);
setup.flaw.b =rm(nd);
[Vf1, setup] = TG_PE_MM(setup);
setup.flaw.b = rm(nd+1);
[Vf2, setup] = TG_PE_MM(setup);
Vf = (Vf2-Vf1) +Vf;
end



df = f(2)-f(1);
dt = 1/(1024*df);
t = s_space(0, 1024*dt, 1024);
Vfe = [Vf zeros(1,1024-length(Vf))];
Vfe(1) = Vfe(1)/2;
vt =2*real(IFourierT(Vfe, dt));


vt=vt.*cap_ampl*(z2+z1)/z2;
shif=floor(z2/(z2+z1)*1024);


if max(vt)<=1
m_vt=mean(vt);
s_vt=std(vt);
vt=vt-m_vt;
if s_vt!=0
vt=vt./s_vt;
end
vt=(vt./max(vt)).*1.5;
end

fvt(ind,:)=c_shift(vt,shif);
ind=ind+1;
end
end
end

save('fb_flawd_wo_noise','fvt');
ind=ind-1;
for i1=1:ind
tvt=fvt(i1,:);
figure;
plot(tvt);

pause(2);
close all;
end
