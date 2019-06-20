% function [t1, vuv] = corr_func(s,fs)
[s, fs] = audioread('test.wav');
left_s = s(:,1);

s = resample(left_s,8000,fs);

t1 = buffer(s,20*fs/1000,20*fs/1000-1);
t3 = var(t1);
t3 = filtfilt(hamming(20*length(fs/1000)),1,t3);

th = mean(t3);



vuv=s-s;

vuv(t3>th)=1;

vuv=vuv(:);

%ec=t3(:);

% plot(s)
% hold on
% plot(vuv)

% end