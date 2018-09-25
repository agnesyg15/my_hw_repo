function [p] = secant(p, pOld, para)

    tol = 1e-8;
    maxit = 100;
    
    fOld = unibertrand_foc(pOld, para);
    
    for it = 1:maxit
        fVal = unibertrand_foc(p,para);
        if abs(fVal) < tol
            break
        else
            pNew = p - ( (p - pOld) / (fVal - fOld) )* fVal;
            pOld = p;
            p = pNew;
            fOld = fVal;
        end
    end
end