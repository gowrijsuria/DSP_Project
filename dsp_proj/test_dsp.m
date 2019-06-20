[s, fs] = audioread('test.wav');
left_s = s(:,1);

s = resample(left_s,8000,fs);

A = corrcoef(s)