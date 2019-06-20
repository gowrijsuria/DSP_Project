clc;
close all;
clear all;
%%

[X,fs] = audioread('test.wav');
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
ACF = zeros(41,10);
ACF_fft = zeros(41,10);
ACF_energy = zeros(41,10);

for i=1:10
    subplot(10,1,i);
    %autocorr(imfl(:,i));
    ACF(:,i) = autocorr(imfl(:,i),'NumLags',40,'NumSTD',3);
    ACF_fft(:,i) = fft(ACF(:,i));
    ACF_energy(:,i) = ACF_fft(:,i) .* conj(ACF_fft(:,i));
end

figure
for i=1:10
    subplot(10,1,i);
    plot(ACF(:,i));
end
figure

for i=1:10
    subplot(10,1,i);
    plot(ACF_energy(:,i));
end

decision_factor = 0;
fractional_energy = zeros(10,1);
summ = zeros(10,1);
summ(1) = ACF_energy(1);
fractional_energy(1) = summ(1)/1; 

for m=2:10
    summ(m) = summ(m-1) + ACF_energy(m);    
    fractional_energy(m) = summ(m)/m; 
end

decision_factor = sum(fractional_energy)/10;


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