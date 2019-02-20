function z = priceFOC(p1, p2, w1, w2, W, c) % w1 firm 1's stage; w2 firm 2's stage

beta = 1/1.05; % discount factor

     z = 1 - (1 - demand(p1, p2)) * (p1 - c(w1)) - beta * W(w1, w2, 2) ...
         + beta * ((1 - demand(p1, p2) - demand(p2, p1)) * W(w1, w2, 1) ...
         + demand(p1, p2) * W(w1, w2, 2) + demand(p2,p1) * W(w1, w2, 3));
end