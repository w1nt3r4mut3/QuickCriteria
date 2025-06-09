function [H] = criterion_error(seria, Rcrit)
  
    N = length(seria);
    
    Xsr = sum(seria) / N;
    Xmax = max(abs(max(seria) - Xsr), abs(min(seria) - Xsr));
    
    Sx = 0;
    for i = 1 : N
        Sx = Sx + (seria(i) - Xsr) ^ 2;
    end
    Sx = sqrt(1 / (N - 1) * Sx);
    
    R = (Xmax - Xsr) / Sx;
    
    if R > Rcrit
        H = 0
    else 
        H = 1
    end

end
