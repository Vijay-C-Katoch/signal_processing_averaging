InitFcn;
RefZ = 1;
Nfrms = 1;
tvec = [0:1/Fs:Nfrms*M/Fs-1/Fs];
fvec = [0:Fs/M:Fs/2]; % single-sided
y = A1*sin(2*pi*F1*tvec);
y = y'; % yt is a real signal, transpose has impact on numbers themselves
% apply window
%w = blackmanharris(M,'periodic');
w = hann(M,'periodic');
yw = y.*w;
yf = fft(yw);
select = 1:(M/2+1);
yf1 = yf(select);
yf2 = yf1.*conj(yf1)/sum(w)^2;
% Convert to single-sided spectrum, use factor of 2 except @ DC & Nyq
yf2 = [yf2(1); 2*yf2(2:end-1); yf2(end)];
yf3 = yf2/RefZ;
ps = 10*log10(abs(yf3));
figure;plot(fvec,ps);grid on;
