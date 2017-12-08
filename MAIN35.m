close all
clearvars

load svedala94
y = svedala94(850:1100);
y = y - mean(y);

figure
plot(y),title('data')

t = (1:length(y))';
u = [sin(2*pi*t/6) cos(2*pi*t/6)];
z = iddata(y,u);
model = [3 [1 1] 4 [0 0]]; % [na [nb_1 nb_2] nc [nk_1 nk_2]]
thx = armax(z,model);
B = cell2mat(thx.b);

figure
plot(y)
hold on
plot(u.*B)

%%
u = [sin(2*pi*t/6) cos(2*pi*t/6) ones(size(t))];
z = iddata(y,u);
m0 = [thx.A(2:end) B 0 thx.C(2:end)];
Re = diag([0 0 0 0 0 1 0 0 0 0]);
model = [3 [1 1 1] 4 0 [0 0 0] [1 1 1]];
[thr,yhat] = rpem(z,model,'kf',Re,m0);
%%
m = thr(:,6);
a = thr(end,4);
b = thr(end,5);
y_mean = m + a*u(:,1) + b*u(:,2);
y_mean = [0; y_mean(1:end-1)];

figure
plot(y)
hold on
plot(y_mean)
legend('data','model')
title('part of the year')

%% All year
y = svedala94;
y = y - y(1);
t = (1:length(y))';
u = [sin(2*pi*t/6) cos(2*pi*t/6) ones(size(t))];
z = iddata(y,u);
m0 = [thx.A(2:end) B 0 thx.C(2:end)];
Re = diag([0 0 0 .5 .5 .5 0 0 0 0]);
model = [3 [1 1 1] 4 0 [0 0 0] [1 1 1]];
[thr,yhat] = rpem(z,model,'kf',Re,m0);
m = thr(:,6);
a = thr(end,4);
b = thr(end,5);
y_mean = m + a*u(:,1) + b*u(:,2);
y_mean = [0; y_mean(1:end-1)];

figure
plot(y)
hold on
plot(y_mean)
legend('data','model')
title('all year')
%%
a = thr(:,4);
b = thr(:,5);
y_mean = m + a.*u(:,1) + b.*u(:,2);
y_mean = [0; y_mean(1:end-1)];

figure
plot(y)
hold on
plot(y_mean)
legend('data','model')
title('all year')