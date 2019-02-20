function np = price(p, W,c)
L = 30; % number of know-how levels
    options = optimset('TolX', 1e-3, 'TolFun', 1e-3);  
    np = zeros(L,L);
    for i = 1:L
        for j = 1:L
            p0 = 10;
            p2 = p(j,i);
            np(i,j) = fsolve(@(p) priceFOC(p, p2, i, j, W, c), p0, options);
        end
    end
end