%% Problem 1 Gaussian Quadrature

clear
load('hw5.mat');
N = data.N;
T = data.T;
n = 20; % number of nodes used in gaussian quadrature
beta0 = 0.1;
sig_beta = 1;
gamma = 0;

addpath ('../CETools');
[x, w] = qnwnorm(n, beta0, sig_beta); % generate gaussian quadrature nodes
beta = x;

F = @(x)((1+exp(-x)).^(-1));
Li_temp = zeros(n,N); 

for m = 1:n
    f = data.X * beta(m)+data.Z * gamma ;
    Fval = F(f);
    Lit = (Fval.^ data.Y).*(Fval.^(1-data.Y)); 
    Li_m = prod(Lit,1); % single contribution to the likelihood function
    Li_temp(m,:) = Li_m*w(m);
end

Li = mean(Li_temp);
logLi = log(Li);
L = sum(logLi)

%% Problem 2 Monte Carlo

clear
load('hw5.mat');
N = data.N;
T = data.T;
n = 100; % number of nodes used in Monte Carlo
% Typically MC needs many more draws
beta0 = 0.1;
sig_beta = 1;
gamma = 0;

Li_temp = zeros(n,N); 
F = @(x)((1+exp(-x)).^(-1));
for m = 1:n
    beta = normrnd(beta0,sig_beta,1,N);
    f = data.X .* repmat(beta,T,1) + data.Z * gamma  ;
    Fval = F(f);
    Lit = (Fval.^ data.Y).*(Fval.^(1-data.Y)); 
    Li_m = prod(Lit,1);
    Li_temp(m,:) = Li_m;
end

Li = mean(Li_temp);
logLi = log(Li);
L = sum(logLi)

%% Problem 3 

clear 

% set initial value
param = [0.1;1;1];

A=[ 0, 0, 0;
    0, -1, 0;
    0, 0, 0];
b= [0; 0; 0];

[param1, min_1] = fmincon(@gausQuad, param, A, b)
[param2, min_2] = fmincon(@MC, param, A, b)

%% Problem 4

clear

% set initial value
para = [0.5; 0.5; 1; 0.5; 1; 0.5];

A = [0,0,0,0,0,0;
    0,0,0,0,0,0;
    0,0,-1,0,0,0;
    0,0,0,0,0,0;
    0,0,0,0,-1,0;
    0,0,0,0,0,0];
b = [0;0;0;0;0;0];

[para3, min3] = fmincon(@MC2, para, A, b);

% This does not seem to proceed far from the initial point and the result
% changes from run to run.

% para3 =

%   0.6484
%   0.4733
%   1.0327
%   0.4656
%   0.9970
%   0.5345
    
%  min3 =

%  1.3777e+03
