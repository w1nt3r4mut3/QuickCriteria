function [F] = Faf(mass_coef, x) % Approximating function
   F = 0;
   for i = 1:length(mass_coef)
        F = F + (mass_coef(i) * (x.^(i-1)));
   end
end