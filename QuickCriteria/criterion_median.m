function [ret] = criterion_median(seria)

    N = length(seria);
    mas_sort = sort(seria);
    if rem(N,2)==0
        median = (mas_sort(N/2) + mas_sort(N/2 + 1)) / 2;
    else 
        median = mas_sort(ceil(N/2));
    end
    
    x_med = median;
    
    x_temp = zeros(1, N);
    
    for i=1:N
        if seria(i) > x_med
            x_temp(i) = -1;
        elseif seria(i) < x_med
            x_temp(i) = 1;
        end
    end
    
    v_seria = [];
    flag = 1;
    k = 1;
    
    for i=1:N-1
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
    
    
    
    if v > (0.5*(N + 1 - 1.96 * sqrt(N - 1))) && (t < (3.3 * log10(N + 1)))
        ret = 1;
    else
        ret = 0;
    end

end
