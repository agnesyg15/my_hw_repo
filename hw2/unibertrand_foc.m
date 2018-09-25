function [fval] = unibertrand_foc(p, para)

    fval = exp(2-p)/(1 + exp(2-p) + exp(2-para)) ...
        - p * (exp(2-p)/(1 + exp(2-p) + exp(2-para)))...
        * (1-(exp(2-p)/(1 + exp(2-p) + exp(2-para))));
         
end