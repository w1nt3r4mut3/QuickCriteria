function [result] = criterion_goodness(mas)
    N = length(mas);
    alf = 0.05;
    if alf == 0.01
        column = 1;
    elseif alf == 0.025
        column = 2;
    elseif alf == 0.05
        column = 3;
    elseif alf == 0.95
        column = 4;
    elseif alf == 0.975
        column = 5;
    elseif alf == 0.89
        column = 6;
    end
    
    % Estimation of the parameters of normal distribution:
    mu = sum(mas)/N;
    sig_sum = zeros(1, N);
    for i=1:N
        sig_sum(i) = (mas(i)-mu)^2;
    end
    sig = sqrt(sum(sig_sum)/N);
    
    % Sturges
    k=1+floor(log2(N)); 
    max_m = max(mas);
    min_m = min(mas);
    h = (max_m - min_m)/k; 
    
    % Create an array with interval boundaries (Sturges)
    borders = zeros(1, k+1);
    borders(1) = min_m;
    for i=2:k+1
        borders(i) = borders(i-1) + h; 
    end    
    
    % Probability according to normal distribution for each interval
    P = zeros(1, k);
    for i=1:k
        P(i) = normcdf(borders(i+1), mu, sig) - normcdf(borders(i), mu, sig);
    end
    
    % Expected number of observations in the interval
    E = zeros(1, k);
    for i=1:k
        E(i) = ceil(N * P(i));
    end
    
    % Observed number of observations in the interval
    O = zeros(1,k);
    for i=1:N
        for j = 1:k
          
            if (mas(i) > min_m+(j-1)*h) && (mas(i) <= min_m+j*h)
                O(j)=O(j)+1;
            end
        end
    end
    
    
    hi_sum = zeros(1, k);
    for i=1:k
        hi_sum(i) = (O(i)-E(i))^2/E(i);
    end    
    HiQrt = sum(hi_sum);
    
    HiQrtCrit = [
    6.6	5 3.8 0.0039 0.00098 0.00016
    9.2	7.4	6	0.103	0.051	0.02
    11.3	9.4	7.8	0.352	0.216	0.115
    13.3	11.1	9.5	0.711	0.484	0.297
    15.1	12.8	11.1	1.15	0.831	0.554
    16.8	14.4	12.6	1.64	1.24	0.872
    18.5	16	14.1	2.17	1.69	1.24
    20.1	17.5	15.5	2.73	2.18	1.65
    21.7	19	16.9	3.33	2.7	2.09
    23.2	20.5	18.3	3.94	3.25	2.56
    24.7	21.9	19.7	4.57	3.82	3.05
    26.2	23.3	21	5.23	4.4	3.57
    27.7	24.7	22.4	5.89	5.01	4.11
    29.1	26.1	23.7	6.57	5.63	4.66
    30.6	27.5	25	7.26	6.26	5.23
    32	28.8	26.3	7.96	6.91	5.81
    33.4	30.2	27.6	8.67	7.56	6.41
    34.8	31.5	28.9	9.39	8.23	7.01
    36.2	32.9	30.1	10.1	8.91	7.63
    37.6	34.2	31.4	10.9	9.59	8.26
    38.9	35.5	32.7	11.6	10.3	8.9
    40.3	36.8	33.9	12.3	11	9.54
    41.6	38.1	35.2	13.1	11.7	10.2
    43	39.4	36.4	13.8	12.4	10.9
    44.3	40.6	37.7	14.6	13.1	11.5
    45.6	41.9	38.9	15.4	13.8	12.2
    47	43.2	40.1	16.2	14.6	12.9
    48.3	44.5	41.3	16.9	15.3	13.6
    49.6	45.7	42.6	17.7	16	14.3
    50.9	47	43.8	18.5	16.8	15
    ];
    
    if HiQrt <= HiQrtCrit(k-1-2, column)  
        result = true;
    else
        result = false;
    end

end