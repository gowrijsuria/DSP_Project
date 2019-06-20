clc;
close all;
clear all;
%%

[X,fs] = audioread('test.wav');
%X = resample(y,1,4);
%fs
t = 0:length(X)-1/fs;
left_x = X(:,1);
right_x = X(:,1);
[imfl,residual,info] = emd(left_x,'Interpolation','pchip');
figure(1);
plot(t,left_x);
xlabel('Time(s)');
figure(2);
hht(imfl,fs);
figure(3);
plot(left_x);
emd(left_x,'Interpolation','pchip');
figure

[ec1,vuv1] = energy_cont(imfl(3),fs);
[ec2,vuv2] = energy_cont(imfl(4),fs);
[ec3,vuv3] = energy_cont(imfl(5),fs);

avg = (ec1+ec2+ec3)/3;
[ec_avg,vuv_avg] = energy_cont(avg,fs);

[ec_s,vuv_s] = energy_cont(avg,fs);
plo

        % 
% ACF = zeros(41,10);
% ACF_fft = zeros(41,10);
% ACF_energy = zeros(41,10);
% 
% for i=1:10
%     subplot(10,1,i);
%     %autocorr(imfl(:,i));
%     ACF(:,i) = autocorr(imfl(:,i),'NumLags',40,'NumSTD',3);
%     ACF_fft(:,i) = fft(ACF(:,i));
%     ACF_energy(:,i) = ACF_fft(:,i) .* conj(ACF_fft(:,i));
% end
% 
% figure
% for i=1:10
%     subplot(10,1,i);
%     plot(ACF(:,i));
% end
% figure
% 
% for i=1:10
%     subplot(10,1,i);
%     plot(ACF_energy(:,i));
% end
% fractional_energy=zeros(10,1);
% decision_factor=0;
% summ=0;
% 
% for i=1:10
%     summ = summ + ACF_energy(i);    
% end
% decision_factor=summ/10;
% 
% 
% no_of_frames = floor((18.5731*1000)/(20));
% u_v=zeros(1,no_of_frames);
% energy_frame=zeros(1,no_of_frames);
% frame_size = floor(length(X)/no_of_frames);
% frames = zeros(no_of_frames,frame_size);
% start=1;
% 
% for i=1:(no_of_frames)
%     if((start+frame_size-1) < length(X))
%         for j = 1:(frame_size-1)
%             frames(i,j)=X(start+j);     
%         end 
%         start = start + frame_size;
%         energy_frame(i) = fft(frames(i)) .* conj(fft(frames(i)));
%     end
% end
% 
% for i=1:no_of_frames
%     if(energy_frame > decision_factor)
%         u_v(i)=1;
%     end
% end 
% disp(u_v);