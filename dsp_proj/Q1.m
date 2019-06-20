%% vcv detection using raw speech signal
clc;
clear all;
close all;
%%
% [s, fs] = audioread('test.wav');
% left_s = s(:,1);
% 
% %left_s = resample(left_s,8000,fs);
% 
% t = 0:length(left_s)-1/fs;
% 
% [imfl,residual,info] = emd(left_s,'Interpolation','pchip');
% 
% figure;
% plot(left_s);
% emd(left_s,'Interpolation','pchip');

[s,fs] = audioread('test.wav');
left_s = s(:,1);
%left_s = resample(left_s,8000,fs);
right_s = s(:,1);
t = 0:length(left_s)-1/fs;

[imfl,residual,info] = emd(left_s,'Interpolation','pchip');
figure(1);
plot(t,left_s);
xlabel('Time(s)');
figure(2);
hht(imfl,fs);
figure(3);
plot(left_s);
emd(left_s,'Interpolation','pchip');
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

fractional_energy = zeros(10,1);
summ = zeros(10,1);
summ(1) = ACF_energy(1);
fractional_energy(1) = summ(1)/1; 

for m=2:10
    summ(m) = summ(m-1) + ACF_energy(m);    
    fractional_energy(m) = summ(m)/m; 
end

decision_factor = sum(fractional_energy)/10;


[ec_eng,ec_var,vuv_eng,vuv_var] = energy_cont_ol(left_s,fs,decision_factor); 
%[ec_eng,vuv_eng] = energy_cont(left_s,fs); 

vuv_imf_eng = s-s;
ec_imf_eng = s-s;

vuv_imf_var = s-s;
ec_imf_var = s-s;

 for i=3:5
     
     [temp_ec_eng,temp_ec_var, temp_vuv_eng,temp_vuv_var] = energy_cont_ol(imfl(:,i),fs,decision_factor);
     
     ec_imf_eng(:,i-2)=temp_ec_eng;
     vuv_imf_eng(:,i-2)=temp_vuv_eng;
     
     ec_imf_var(:,i-2)=temp_ec_var;
     vuv_imf_var(:,i-2)=temp_vuv_var;
          
 end
 
EC_avg = mean(ec_imf_eng)
th = mean(EC_avg)/3;
vuv_imf_eng(EC_avg > th) = 1;
%vuv_imf_eng(EC_avg > decision_factor) = 1;


EC_avg1 = mean(ec_imf_var); 
th1 = mean(EC_avg1)/3;
vuv_imf_var(EC_avg1>th1) = 1;
%vuv_imf_var(EC_avg1 > decision_factor) = 1;

%% Plots and Results 
%figure(2);
figure;
subplot(311);
plot(left_s);
subplot(312);
plot(ec_eng);
subplot(313);
plot(vuv_eng.*max(left_s),'r');
hold on;
plot(left_s./max(left_s));


figure;
subplot(311);
plot(left_s);
subplot(312);
plot(ec_var);
subplot(313);
plot(vuv_var.*max(left_s),'r');
hold on;
plot(left_s./max(left_s));