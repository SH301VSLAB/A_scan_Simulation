clear all;
clc;
close all;


load('crck_flaw_wo_noise');
fvt=circshift(fvt,200,2);

load('crck_flaw_w_noise.txt');
fpn=circshift(fpn,200,2);

ann=[];
for i=1:size(fvt)(1)
max_ind=max(find(abs(fvt(i,:))>0.1));
min_ind=min(find(abs(fvt(i,:))>0.1));
temp_ann=zeros(1,1024);
temp_ann(1,min_ind:max_ind)=ones(1,(max_ind-min_ind+1));
ann(i,:)=temp_ann;
figure;
subplot(3,1,1)
plot(fvt(i,:));
subplot(3,1,2)
plot(fpn(i,:));
subplot(3,1,3)
plot(ann(i,:));

pause(2)
close all;
clear temp_ann;
end



save('shifted_crck_wo_noise.txt','fvt');
save('shifted_crck_w_noise.txt','fpn');
save('annotation_crck.txt','ann');
