function L= MC2(param)

load('hw5.mat');
mu = [param(1), param(2)];
sigma = [param(3), param(4);
        param(4),param(5)];
gamma = param(6);

% need to guarantee sigma is a positive semi-definite matrix
if param(3)*param(5)-param(4)^2 <0 || param(3)+ param(5) < 0
    L=-Inf;
else
    
N = data.N;
T = data.T;
n = 100; 
Li_temp=zeros(n,N);
one = ones(T,N);
F = @(x)((1+exp(-x)).^(-1));

for m=1:n
    mu = mvnrnd(mu, sigma, N);
    beta = mu(:,1)';
    u = mu(:,2)';
    data.X .* repmat(beta,T,1)   
    f = data.X .* repmat(beta,T,1) + data.Z * gamma + one .* repmat(u,T,1);
    Fval = F(f);
    Lit = (Fval.^ data.Y).*(Fval.^(1-data.Y)); 
    Li_m = prod(Lit,1);
    Li_temp(m,:) = Li_m;
end

Li = mean(Li_temp);
logLi = log(Li);
L = -sum(logLi,2);

end