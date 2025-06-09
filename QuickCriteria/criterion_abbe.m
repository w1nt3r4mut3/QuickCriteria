function [result] = criterion_abbe(seria, q_critical)
    % Check for minimum sample length
    n = length(seria);
    if n < 2
        result = 0;
        return
    end
    
    % Calculate the average value
    sum_x = 0;
    for i = 1:n
        sum_x = sum_x + seria(i);
    end
    x_mean = sum_x / n;
    
    % Calculating the variance (unbiased)
    variance = 0;
    for i = 1:n
        variance = variance + (seria(i) - x_mean)^2;
    end
    variance = variance / (n - 1);
    
      
    % Calculating the sum of squares of differences
    sum_diff_sq = 0;
    for i = 1:n-1
        diff = seria(i+1) - seria(i);
        sum_diff_sq = sum_diff_sq + diff^2;
    end
    Q_squared = sum_diff_sq / (2*(n-1));
    
    % Calculation of θ statistics
    theta = Q_squared / variance;
    

    if theta > q_critical
        result = 0;
    else 
        result = 1;
    end

end