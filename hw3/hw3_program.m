% Loading data
load('hw3.mat');

%% 1 Using MLE via Nelder-Mead

% Use fminsearch
options = optimset('Display','iter');
fun = @(beta) -sum(-exp(X*beta) + y.*(X*beta) - log(factorial(y)));

%beta0 = [0,0,0,0,0,0]'; % not optimal
%beta0 = [1,1,1,1,1,1]'; % not optimal
%beta0 = [2,2,2,2,2,2]'; % not optimal
%beta0 = [3,3,3,3,3,3]'; % exceed max num of fctn
%beta0 = [-1,-1,-1,-1,-1,-1]'; % exceed max num of fctn
beta0 = [-0.5, -0.5, -0.5, -0.5, -0.5, -0.5]'; % maybe optimal

[beta, fval] = fminsearch(fun,beta0,options)

%% 2 Using MLE via quasi-Newton optimization method

% Use BFGS search method
options = optimoptions('fminunc','Algorithm','quasi-newton',...
          'SpecifyObjectiveGradient',false, 'Display','iter');
      
%beta0 = [0,0,0,0,0,0]'; % maybe optimal 
%beta0 = [1,1,1,1,1,1]'; % not optimal
%beta0 = [2,2,2,2,2,2]'; % not optimal
%beta0 = [3,3,3,3,3,3]'; % not optimal
%beta0 = [-1,-1,-1,-1,-1,-1]'; % maybe optimal
beta0 = [-0.5, -0.5, -0.5, -0.5, -0.5, -0.5]'; % maybe optimal 

[beta2, fval2] = fminunc(fun, beta0, options)

%% 3 Using nonlinear least squares estimator via lsqnonlin

fun2 = @(beta) y - exp(X*beta);

% Use Levenberg-Marquardt computation method
options = optimoptions('lsqnonlin', 'Algorithm','levenberg-marquardt', 'Display','iter');

beta0 = [0,0,0,0,0,0]'; % maybe optimal
%beta0 = [1,1,1,1,1,1]'; % not optimal
%beta0 = [2,2,2,2,2,2]'; % not optimal
%beta0 = [3,3,3,3,3,3]'; % not optimal
%beta0 = [-1,-1,-1,-1,-1,-1]'; % not optimal
%beta0 = [-0.5, -0.5, -0.5, -0.5, -0.5, -0.5]'; % not optimal

[beta3, fval3] = lsqnonlin(fun2,beta0, [],[],options)

%% 4 Using nonlinear least squares estimator via Nelder-Mead

fun3 = @(beta) sum((y - exp(X*beta)).^2);
options = optimset('Display','iter');

beta0 = [0,0,0,0,0,0]'; % not optimal
%beta0 = [1,1,1,1,1,1]'; % not optimal
%beta0 = [2,2,2,2,2,2]'; % not optimal
%beta0 = [3,3,3,3,3,3]'; % not optimal
%beta0 = [-1,-1,-1,-1,-1,-1]'; % not optimal


[beta4, fval4] = fminsearch(fun3,beta0,options)

% The resulted beta is very different from those calculated from Problem
% 1,2,3. This may due to the reason that the calculation converges to
% another local minimum. Now, test Problem 4 with initial value of beta2,
% which is the optimal result get from Problem 1 and 2.

beta0 = beta2; % the result is pretty the same with those in Problem 3
[beta5] = fminsearch(fun3,beta0,options)

