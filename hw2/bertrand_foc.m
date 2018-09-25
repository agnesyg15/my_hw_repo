function [fval] = bertrand_foc(p,v)
 
    % Evaluate First Order Condition
     fval = exp([v-p])/sum(exp([v-p;0])) - diag(p) * diag(exp([v-p])/sum(exp([v-p;0])))...
        * (1 - exp([v-p])/sum(exp([v-p;0])));
    
end