function [profit] = bertrand(p,v)
    
    profit = exp(v-p)/sum(exp([v-p;0]));
    
end