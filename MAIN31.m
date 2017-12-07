close all
clearvars

y = load('tar2.dat');
a = load('thx.dat');

fnum = 0;
fnum = fnum + 1;
figure(fnum)
subplot(211); plot(y); title('data')
subplot(212); plot(a); title('parameters'); legend('a_1','a_2')

model = [2];
lambda = .95;
[Aest,yhat,~,~] = rarx(y,model,'ff',lambda);

fnum = fnum + 1;
figure(fnum)
subplot(211); plot(a); title('true parameters'); legend('a_1','a_2')
subplot(212); plot(Aest); title('estimated parameters'); legend('a_1','a_2')

n = 100;
lambda_line = linspace(.85,1,n);
ls2 = zeros(n,1);
for i = 1:length(lambda_line)
    [Aest,yhat,~,~] = rarx(y,model,'ff',lambda_line(i));
    ls2(i) = sum((y-yhat).^2);
end

fnum = fnum + 1;
figure(fnum)
plot(lambda_line,ls2); title('Optimal \lambda')