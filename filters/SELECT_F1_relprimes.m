%% Based on ENOB_Technical Paper, 
% The effective number of bits (ENOB) of my R&S Digital Oscilloscope%
% There are a number of key requirements when it comes to selecting
% a test sine frequency for the ADC. 
% 1. The input frequency should lie exactly on an FFT bin. This avoids
% the need to do windowing as windowing adds its own distortion.
% 2. The input frequency and FFT size should be chosen such that it
% includes many phases of the input signal
 
Fs = 10e6; % Hz
Nbits = 12;
M = round(pi*2^Nbits); % minimum sequence length
% select J to be relatively primed to M, 
% If 2 numbers are relatively primed, it means their
% greatest commopn divisor is 1, i.e. GCD = 1
n = 1;
for k = 1:M
    if gcd(k,M) == 1
        Jvec(n) = k;
        % This equation comes from the R&S ENOB technical paper
        % "Further, for reliable measurements, as many phases of the input signal as possible
        % should be sampled, and all output codes of the ADC should 
        % be activated. Using the notation of section 5.4.1 of [1], 
        % the optimal test frequencies are given by
        % Fopt = Fs*J/M
        % where J is the number of input signal periods within the
        % test sequence, and 
        % M is the number of samples in the test sequence"
        % Essentially, if you have say J=11 cycles of a sine wave in a
        % given test sequence, you want the ADC to sample each cycle
        % at different points in each cycle. If you sample each cycle
        % at say 0, 45, 90, 135, 180, 225, 270, and 315 degrees, then
        F1_vec(n) = Fs * k/M;
        if (F1_vec(n) > Fs/2)
            disp('breaking...');
            break;
        end
        n = n + 1;
    else
        disp(['n = ',num2str(n), ' Jvec(n) = ',num2str(k),' is not co-prime with M = ',num2str(M)])
    end
end

%% factors of an integer
N=M
K=1:M;
D = K(rem(N,K)==0)