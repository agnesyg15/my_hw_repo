function V = getV(np, p, W, c)
    L = 30; % number of know-how levels
    beta = 1/1.05; % discount factor
    
    V = zeros(L,L);
    for i = 1:L
        for j = 1:L
            V(i,j) = demand(np(i,j), p(j,i)) * (np(i,j) - c(i)) + ...
                 beta * ((1- demand(np(i,j), p(j,i)) - demand(p(j,i), np(i,j))) * W(i,j, 1)...
                + demand(np(i,j), p(j,i)) * W(i, j, 2) ...
                + demand(p(j,i), np(i,j)) * W(i, j, 3));
        end
    end
end