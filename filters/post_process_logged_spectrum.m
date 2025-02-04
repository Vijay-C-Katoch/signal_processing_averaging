%%
P = out.logsout{2}.Values.Data;
P = squeeze(P);
[a b] = size(P);
Psum = sum(P,2);
Pavg = Psum/b;
figure;plot(Pavg);grid on
%%
U = out.logsout{1}.Values.Data;
U = squeeze(U);
[a b] = size(U);
Usum = sum(U,2);
Uavg = Usum/b;
figure;plot(Uavg);grid on