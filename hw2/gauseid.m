function [p] = gauseid(p,v)
    maxit  = 1000;
    tol    = 1e-8;
    
    % Give another inital value
    p_old = [1.5,1.5];
    for it = 1:maxit
        fval = bertrand_foc(p,v);
        if norm(fval,inf) < tol
            break
        else
            p_B = p(2);
            p_A = secant(p(1), p_old(1), p_B);
            p_B = secant(p(2), p_old(2), p_A);
            p_old = p;
            p = [p_A; p_B];
        end
    end