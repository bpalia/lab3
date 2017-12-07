close all
clearvars
clc
fnum = 0;


load svedala94
y = svedala94;

T = linspace(datenum(1994,1,1),datenum(1994,12,31),length(y));
fnum = fnum + 1;
figure(fnum)
plot(T,y);datetick('x');title('temperature')

A6 = [1 zeros(1,5) -1];
ydiff = filter(A6,1,y);

fnum = fnum + 1;
figure(fnum)
plot(T,ydiff);datetick('x');title('differentiated temperature')

%%
% notice that we are not excluding the first values
th = armax(ydiff,[2 2]);
th_winter = armax(ydiff(1:540),[2 2]);
th_summer = armax(ydiff(907:1458),[2 2]);
present(th)
present(th_winter)
present(th_summer)
%%
th0 = [th_winter.A(2:end) th_winter.C(2:end)];
[thr,yhat] = rarmax(ydiff,[2 2],'ff',0.99,th0);

fnum = fnum + 1;
figure(fnum)
subplot(311); plot(T,y);datetick('x');title('temperature')
subplot(312); plot(thr(:,1:2)); 
hold on
plot(repmat(th_winter.A(2:end),[length(thr) 1]),'b:');
plot(repmat(th_summer.A(2:end),[length(thr) 1]),'r:');
legend('a_1','a_2','a_1 w','a_2 w','a_1 s','a_2 s')
axis tight
hold off
subplot(313); plot(thr(:,3:end)); 
hold on
plot(repmat(th_winter.C(2:end),[length(thr) 1]),'b:');
plot(repmat(th_summer.C(2:end),[length(thr) 1]),'r:');
legend('c_1','c_2','c_1 w','c_2 w','c_1 s','c_2 s')
axis tight
hold off
