function [mas_sort] = DelHardErr(mas, R_cr)
% Checks for gross error and removes measurements with gross error
% Output is a cleared array

% true – gross error is present
% false – gross error is absent

    % Initial data
    mas_sort = sort(mas);
    N = length(mas_sort);
    
    % Array mean (mathematical expectation)
    m_sr = sum(mas_sort)/N;
    
    % Finding the standard deviation
    sum_sig  = zeros(1, N);
    for i=1:N
        sum_sig(i) = (mas_sort(i)-m_sr)^2;
    end
    sig = sqrt(sum(sum_sig)/(N-1));
    
    ok = 0;
    while ok ~= 2
        % Finding the distance (R) from the maximum measurement result by modulus
        % to the average value of a series of measurements
        R_max = abs((max(mas_sort)-m_sr)/sig);
        R_min = abs((min(mas_sort)-m_sr)/sig);
        % Testing hypotheses true and false
        if R_max > R_cr
            mas_sort(end) = [];
            a = 0;
        else
            a = 1;
        end
        if R_min > R_cr
            mas_sort(1) = [];
            b = 0;
        else
            b = 1;
        end
        ok = a+b;
    end
end