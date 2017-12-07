function [y,x] = func_generateY(u, sigma_e, sigma_v, b)
    N = length(u);
    y = zeros(1,N);
    e = sqrt(sigma_e) * randn(1,N); 
    v = sqrt(sigma_v) * randn(1,N); 
    x = zeros(1,N);
    x(1) = e(1);
    for n = 2:N
        x(n) = x(n-1) + e(n);
    end
    y = x + b*u + v;
end