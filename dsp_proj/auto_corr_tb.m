%% vuv detection using raw speech signal
clc;
clear all;
close all;
%%
[s, fs] = audioread('test.wav');
left_s = s(:,1);

%left_s = resample(left_s,8000,fs);

t = 0:length(left_s)-1/fs;

[imfl,residual,info] = emd(left_s,'Interpolation','pchip');

figure;
plot(left_s);
emd(left_s,'Interpolation','pchip');
lm = imfl(:,1) - imfl(:,1);
lm = auto_corr(imfl(:,1),fs);

% for i=1:10
%     subplot(10,1,i);
%     ACF(:,i) = autocorr(imfl(:,i),'NumLags',40,'NumSTD',3);
% end
% 
% figure
% for i=1:10
%     subplot(10,1,i);
%     plot(ACF(:,i));
% end







% 
% [ec_eng,ec_var,vuv_eng,vuv_var] = energy_cont_ol(left_s,fs); 
% %[ec_eng,vuv_eng] = energy_cont(left_s,fs); 
% 
% 
% 
% vuv_imf_eng = s-s;
% ec_imf_eng = s-s;
% 
% vuv_imf_var = s-s;
% ec_imf_var = s-s;
% 
%  for i=3:5
%      
%      [temp_ec_eng,temp_ec_var, temp_vuv_eng,temp_vuv_var] = energy_cont_ol(imfl(:,i),fs);
%      
%      ec_imf_eng(:,i-2)=temp_ec_eng;
%      vuv_imf_eng(:,i-2)=temp_vuv_eng;
%      
%      ec_imf_var(:,i-2)=temp_ec_var;
%      vuv_imf_var(:,i-2)=temp_vuv_var;
%           
%  end
%  
% EC_avg = mean(ec_imf_eng)
% th = mean(EC_avg)/3;
% vuv_imf_eng(EC_avg > th) = 1;
% 
% EC_avg1 = mean(ec_imf_var); 
% th1 = mean(EC_avg1)/3;
% vuv_imf_var(EC_avg1>th1) = 1;

%% Plots and Results 
%figure(2);
figure;
% subplot(311);
% plot(left_s);
% subplot(312);
% plot(ec_eng);
% subplot(313);
plot(lm,'r');
hold on;
plot(left_s);
ylabel("eng");

% figure;
% subplot(311);
% plot(left_s);
% subplot(312);
% plot(ec_var);
% subplot(313);
% plot(vuv_var.*max(left_s),'r');
% hold on;
% plot(left_s./max(left_s));
% ylabel("var");