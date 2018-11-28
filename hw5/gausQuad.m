function L= gausQuad(param)

load('hw5.mat');

beta0 = param(1);
sig_beta = param(2);
gamma = param(3);
N = data.N;
T = data.T;
n = 20;

addpath ('../CETools');
[x, w] = qnwnorm(n, beta0, sig_beta); % generate gaussian quadrature nodes
beta = x;

F = @(x)((1+exp(-x)).^(-1));
Li_temp = zeros(n,N); 
for m = 1:n
    f = data.X * beta(m)+data.Z * gamma ;
    Fval = F(f);
    Lit = (Fval.^ data.Y).*(Fval.^(1-data.Y)); 
    Li_m = prod(Lit,1);
    Li_temp(m,:) = Li_m*w(m);
end

Li = mean(Li_temp);
logLi = log(Li);
L = - sum(logLi);

end
