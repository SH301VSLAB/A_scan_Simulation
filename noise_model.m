close all;
%clear all;
clc;

d=load('/home/kushal/Desktop/Simulation/POC/Ultrasonic_dataset_14/mar_22.txt');
ind=[0,2,6,8,164:166,184:187,215:222,226:228,246:255];
ind=ind+1;
no_flaw=d(ind,688:1712);
%alf=[];
nft=[];
for i=1:length(ind)
temp_mean=mean(no_flaw(i,:));
temp_std=std(no_flaw(i,:));
tnf=no_flaw(i,:)-temp_mean;
if temp_std!=0
tnf=tnf./temp_std;
end
tnf=tnf./max(tnf);

%figure;
%plot(tnf);
nft(i,:)=tnf;
end



mean_tnf=mean(nft);
std_tnf=std(nft);


%for i=1:length(ind)
%    f_data=fft(no_flaw(i,:));
%    alf(i,:)=f_data;
%end




%abalf=abs(alf);
%phalf=angle(alf);

%meanalf=mean(abalf);
%stdalf=std(abalf);

%figure;
%plot(meanalf);

%figure;
%plot(stdalf);

figure;
plot(mean_tnf);

figure;
plot(std_tnf);

save('noise_time','mean_tnf','std_tnf');


