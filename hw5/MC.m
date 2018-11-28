function L = MC(param)

load('hw5.mat');

beta0 = param(1);
sig_beta = param(2);
gamma = param(3);
N = data.N;
T = data.T;
n = 100; 

Li_temp = zeros(n,N); 
F = @(x)((1+exp(-x)).^(-1));
for m = 1:n
    beta = normrnd(beta0,sig_beta,1,N);
    f = data.X .* repmat(beta,T,1) + data.Z * gamma ;
    Fval = F(f);
    Lit = (Fval.^ data.Y).*(Fval.^(1-data.Y)); 
    Li_m = prod(Lit,1);
    Li_temp(m,:) = Li_m;
end

Li = mean(Li_temp);
logLi = log(Li);
L = - sum(logLi);

end