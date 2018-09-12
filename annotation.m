clear all;
clc;
close all;


load('sdh_flaw_wo_noise.txt');
fvt=circshift(fvt,100,2);

load('sdh_flaw_w_noise.txt');
fpn=circshift(fpn,100,2);

ann=[];
for i=1:size(fvt)(1)
max_ind=max(find(abs(fvt(i,:))>0.1));
min_ind=min(find(abs(fvt(i,:))>0.1));
temp_ann=zeros(1,1024);
temp_ann(1,min_ind:max_ind)=ones(1,(max_ind-min_ind+1));
ann(i,:)=temp_ann;
figure;
subplot(2,1,1)
plot(fvt(i,:));
subplot(2,1,2)
plot(ann(i,:));
pause(2)
close all;
clear temp_ann;
end



save('shifted_sdh_wo_noise.txt','fvt');
save('shifted_sdh_w_noise.txt','fpn');
save('annotation_sdh.txt','ann');
