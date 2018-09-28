function [p] = update(p,v)
    maxit  = 1000;
    tol    = 1e-8;
    
    for it = 1:maxit
        fval = bertrand_foc(p,v);
        if norm(fval,inf) < tol
            break
        else
            p_A = 1 / (1 - unibertrand(p(1), p(2)));
            p_B = 1 / (1 - unibertrand(p(2), p_A));
            p = [p_A; p_B];
        end
    end