close all
clearvars

N = 1000;
sigma_e = 1;
sigma_v = 4;
b = 20;
[u] = func_generateU(N);
[y,x] = func_generateY(u, sigma_e, sigma_v, b);

figure
plot(u)
hold on
plot(y)

% State space equation definition
A = [1 0; 0 1];
Re = [sigma_e 0; 0 0.01]; % Hiden state noise covariance matrix
Rw = sigma_v; % Observation variance
% usually C should be set here to, but in this case C is a function of time

% set initial values
Rxx_1 = 1 * eye(2); % initial variance
xtt_1 = [0 0]'; % initial state

% vector to store values in
xsave = zeros(2,N);

% Kalman filter. Start from k=3, because we need old values of y
for k = 2:N
    % C is, in our case, a function of time
    C = [1 u(k)];
    
%     yt = y(k-1:-1:k-2)';
    yt = y(k);
    % Update
    Ryy = C*Rxx_1*C' + Rw;
    Kt = Rxx_1*C'/(C*Rxx_1*C'+Rw);
    xtt = xtt_1+Kt*(yt-C*xtt_1);
    Rxx = Rxx_1-Rxx_1*C'/(C*Rxx_1*C'+Rw)*C*Rxx_1;
    
    % Save
    xsave(:,k) = xtt_1;
    
    % Predict
    Rxx_1 = Rxx+Re;
    xtt_1 = xtt;  
end

figure
subplot(211);plot([1:N],b*ones(1,N),[1:N],xsave(2,:)); ylim([0 21]); title('Parameter b')
subplot(212);plot([1:N],x,[1:N],xsave(1,:));title('Drift')

