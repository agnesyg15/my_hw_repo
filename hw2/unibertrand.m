function [profit] = unibertrand(p,para)
    profit = exp(2-p)/(1 + exp(2-p) + exp(2-para));
    
end