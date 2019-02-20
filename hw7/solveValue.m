function [V,p,iter] = solveValue(V0, p0)

CRIT = 1e-2; % set converging criterion
lambda = 1;
L = 30;
V = V0;
p = p0;
check = 1;
iter = 0;

%define c
rho = 0.85; % slope of the learning curve
k = 10; % marginal cost of production with minimal know-how
l = 15; % learning curve flattens out at l units of know-how
eta = log(rho)/log(2);
c = zeros(1,L);
for i = 1: (l-1)
    c(i) = k * (i ^ eta);
end
for i = l:L
    c(i) = k * (l ^ eta);
end

while check > CRIT
    W = GetnW(V);
    np = price(p, W, c);
    nV = getV(np,p,W, c);
    check = max( max(max(abs((nV-V)./(1+nV)))),  max(max(abs((np-p)./(1+np)))));
    V = lambda * nV + (1-lambda)*V;
    p = lambda * np + (1-lambda)*p;
    iter = iter+1;
end