 function [ec, vuv] = energy_cont(s,fs)
%s
t1=buffer(s,20*fs/1000,20*fs/1000-1);

%t3=var(t1);

%t3=sum(t1.^2);
t3 = xcorr(t1);

t3=filtfilt(hamming(20*length(fs/1000)),1,t3);

th=mean(t3);



vuv=s-s;

vuv(t3>th)=1;

vuv=vuv(:);

ec=t3(:);

% plot(s)
% hold on
% plot(vuv)

 end