function [mas_a] = lsm(x, y, m) % least squares method
    N = length(x);
    X = zeros(m + 1, m + 1);
    Y = zeros(m + 1, 1);

    for i=0:m
        for j=0:m
            sum = 0;
            for k=1:N
                sum = sum + x(k)^(i + j);
            end
            X(i+1, j+1) = sum;
        end
    end
    
    X(1, 1) = N;

    for i=1:m+1
        sum = 0;
        for k=1:N
            sum = sum + y(k)*x(k)^(i-1);
        end
        Y(i, 1) = sum;
    end    

    mas_a = linsolve(X, Y);
end