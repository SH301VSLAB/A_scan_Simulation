clear all;
close all;
clc;

load('crck_flaw_wo_noise');
load('noise_time');


len_of_ascan=1024;
fpn=[];
for i=1:size(fvt)(1)
tvt=fvt(i,:);
for j=1:len_of_ascan
noise(j)=mean_tnf(j)+(std_tnf(j).*randn(1,1));
end
fpn(i,:)=noise+tvt;
end

save('crck_flaw_w_noise.txt','fpn');

%for i=1:size(fpn)
%figure;
%subplot(2,1,1);
%plot(fvt(i,:));
%subplot(2,1,2);
%plot(fpn(i,:));

%pause(2);
%close all;
%end
