clear all;
clc;
close all;

load('fb_flawd_wo_noise.txt');

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


save('annotation_fbh.txt','ann');
