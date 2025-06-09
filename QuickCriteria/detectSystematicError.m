function H = detectSystematicError(data)
      
    N = length(data);
    sortedData = sort(data);

    % Calculating the median
    if mod(N, 2) == 0
        medianVal = (sortedData(N/2) + sortedData(N/2 + 1)) / 2;
    else
        medianVal = sortedData(ceil(N/2));
    end

    % Create a temporary array of labels
    tempLabels = zeros(1, N);
    for i = 1:N
        if data(i) > medianVal
        tempLabels(i) = -1;
    elseif data(i) < medianVal
        tempLabels(i) = 1;
        end
    end

    % Series analysis
    series = [];
    currentLength = 1;

    for i = 1:N-1
        if tempLabels(i) == tempLabels(i+1)
            currentLength = currentLength + 1;
        else
            series(end+1) = currentLength;
            currentLength = 1;
        end
    end
    % Add latest episode
    series(end+1) = currentLength;

    maxSeriesLength = max(series);
    numSeries = length(series);

    % Check criteria
    criterion1 = numSeries > 0.5*(N + 1 - 1.96*sqrt(N - 1));
    criterion2 = maxSeriesLength < 3.3*log10(N + 1);

    H = criterion1 && criterion2;
end