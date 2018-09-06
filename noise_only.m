clear all;
close all;
clc;

load('noise_time');

len_of_ascan=1024;
a_scan_noise=[]
for i=1:396
for j=1:len_of_ascan
noise(j)=mean_tnf(j)+(std_tnf(j).*randn(1,1));
end
a_scan_noise(i,:)=noise;
end

save('noise_ascan.txt','a_scan_noise');
