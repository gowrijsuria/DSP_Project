 %function [label_matrix] = auto_corr(s,fs)
%s

[s, fs] = audioread('test.wav');
left_s = s(:,1);

s = resample(left_s,8000,fs);


t1 = buffer(s,20*fs/1000,20*fs/1000-1);
t3 = zeros(11,1);
distance = 100; %100 samples
label_matrix = s - s;
df = s - s;

for i = 1:length(s)
t3(:,i) = autocorr(t1(:,i),'NumLags',10,'NumSTD',3);

t3(:,i) = filtfilt(hamming(20*length(fs/1000)),1,t3(:,i));

z = peaks(t3(:,i));

plot(z);

df(i) = t3(0,i) - t3(distance,i);

if(df(i) > 1)
    %more damping, so unvoiced
    label_matrix(i) = 0;
else
    label_matrix(i) = 1;
end
    
end

% end