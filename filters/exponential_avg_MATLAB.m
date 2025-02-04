USE_SQUARE_WAVE_INPUT = 0;
FF = 0.99; % forgetting factor
w(1) = 1; % by definition
L = 3200;
for k = 2:L
    w(k) = FF*w(k-1) + 1;
end
w =reshape(w,[L 1])
%% iteration number, weighting for new sample, weighting for prev avg
[[1:L]' 1./w 1-1./w];

% time varying weights for the new input sample and the previous average
% respectively.
w1 = 1./w; % time-varying weight for new input sample
w2 = 1-w1; % time-varying weight for previous average

% create a square wave to test the moving exponential averager
N = 200;
if USE_SQUARE_WAVE_INPUT
    x = [ones(1,N) zeros(1,N)];
    x = [x x x x x x x x];
else
    x = ones(L,1) + rand(L,1) + [zeros(L/2,1);ones(L/2,1)];
end
xma1(1) = x(1);
xma2(1) = (1-FF)*x(1);
for k = 2:length(x)
    xma1(k) = w1(k)*x(k) + w2(k)*xma1(k-1);
    xma2(k) = (1-FF)*x(k) + FF*xma2(k-1);
end
t = 1:length(x);
figure;plot(t,x,'r',t,xma1,'b',t,xma2,'g');grid on;
legend('X','XMA1','XMA2')

%% the conclusion is that the time-varying exponential averager, XMA1 has an
% advantage over the fixed-coefficient exp avg'r, XMA2 in one specific scenario
% which is a fairly common one, at startup. If the input signal x hovers
% around it's average value starting from time 0, which would be common in 
% many situations, the time-varying weights on XMA1
% allow it converge faster to the true mean as compared to XMA2. 
% It takes a while for XMA2 to converge to the average value. 
% The larger the forgetting factor FF, the slower it
% forgets the old average...which is counter-intuitive based on the naming
% convention.




