 function [ec_eng, ec_var, vuv_eng, vuv_var] = energy_cont_ol(s,fs,df)
%s
t1=buffer(s,20*fs/1000,20*fs/1000-1);

t3 = var(t1);
t3 = filtfilt(hamming(20*length(fs/1000)),1,t3);
th1 = mean(t3);
%th1 = df;
vuv_var = s-s;
vuv_var(t3>th1) = 1;
vuv_var = vuv_var(:);
ec_var = t3(:);

t2 = sum(t1.^2);
t2 = filtfilt(hamming(20*length(fs/1000)),1,t2);
th2 = mean(t2);
%th2 = df;
vuv_eng = s-s;
vuv_eng(t2>th2) = 1;
vuv_eng = vuv_eng(:);
ec_eng = t2(:);
 
 end