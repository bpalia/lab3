% Example of Kalman filter
clearvars
close all


% process simulation
% y = func_generateU(1000); % wrong
y = load('tar2.dat');
a = load('thx.dat');
N = length(y);


% State space equation definition
A = [1.5 -0.7; 1 0];
Re = [0 0; 0 1]; % Hiden state noise covariance matrix
Rw = 1.25; % Observation variance
% usually C should be set here to, but in this case C is a function of time

% set initial values
Rxx_1 = 10 * eye(2); % initial variance
xtt_1 = [-1 -2]'; % initial state

% vector to store values in
xsave = zeros(2,N);

% Kalman filter. Start from k=3, because we need old values of y
for k = 3:N
    % C is, in our case, a function of time
    C = [1 0];
    
    yt = y(k-1:-1:k-2)';
%     yt = y(k);
    % Update
    Ryy = C*Rxx_1*C' + Rw;
    Kt = Rxx_1*C'/Ryy;
    xtt = xtt_1+Kt*(yt-C*xtt_1);
    Rxx = (eye(2)-Kt*C)*Rxx_1;
    
    % Save
    xsave(:,k) = xtt_1;
    
    % Predict
    Rxx_1 = A*Rxx*A'+Re;
    xtt_1 = A*xtt;  
end

figure
plot(xsave(:,:)')
hold on
plot(a)

figure
plot(y)