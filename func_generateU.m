% Generates N samples of u
function [uV] = func_generateU(N)

    M = 1/8 * [7 1;1 7]; 

    % Vector with all v
    uV = zeros(1,N);

    % Initial value
    uV(1) = 1;

    for i=2:N
        dist = M(uV(i-1),:);
        cumul_dist = cumsum(dist);
        r = rand();
        uV(i) = find(cumul_dist > r, 1);
    end

end