% We are not doing fixed-point or quantization of the data.
% However, we are still assuming some "number of bits" upon which to
% compute an FFT size and analysis frequency.

A1 = 1;
Nbits = 8; % make up some integer
M = round(pi*2^Nbits)
Fs = 20e6;
% Try a J factor
J = 101;
if gcd(J,M) == 1
    F1 = Fs*J/M;
else
    disp('Try a different J!!');
    disp('This is a message from the model PreLoadFcn...')
end

%F1 = 2.5e6;