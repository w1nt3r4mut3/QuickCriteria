function [res] = criterion_seria(seria)
    N = length(seria);

    if N <= 26
        t0 = 5;
    elseif (N > 26) & (N <= 153)
        t0 = 6;
    elseif (N > 153) & (N <= 1170)
        t0 = 7;
    end
    
    x_temp = zeros(1, N-1);
    
    for i=1:N-1
        if seria(i) > seria(i+1)
            x_temp(i) = -1;
        elseif seria(i) < seria(i+1)
            x_temp(i) = 1;
        end
    end
    
    v_seria = [];
    flag = 1;
    k = 1;
    
    for i=1:N-2
        if x_temp(i) == x_temp(i+1)
            flag = flag + 1;
        else
            v_seria(k) = flag;
            flag = 1;
            k = k + 1;
        end
    end
    
    t = max(v_seria);
    v = length(v_seria);
    
    v_theory = (0.3 * (2 * N - 1) - 1.96 * sqrt((16 * N - 29) / 90));
    
    if v > v_theory & t < t0
        res = 1;
    else
        res = 0;
    end
end