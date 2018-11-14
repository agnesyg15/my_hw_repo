%%% Using Dart-Throwing Method

%% Problem 1 Using Quasi-Monto Carlo
% Define indicator function
f = @(x,y) double((x.^2 + y.^2 <= 1))
% you didn't need to define a function, it's all defined for you already.
% check the answer key


% Use `N'eiderrieter, 'W'eyl and 'H'aber points do the 1000 draw
addpath ('../CETools');
[n] = qnwequi(1000, [0 0], [1, 1], 'N');

% Compute the value of f with each element of n
f_val = f(n(:,1), n(:,2));

% Compute PI
PI_1 = 4 / size(n,1) * sum(f_val)

%% Problem 2 Using Newton-Cotes
f_1 = @(x) double(x.^2 + y.^2<=1)

% Cut y-axis and get 1000 points
Y = linspace(0,1,1000);
% I am not sure that is equivalent to Newton Conton method. there is a
% function in compecon that generates the draws for you 
fval1 = []; % try to evaluate intergration of f_1 given each y value
for i = 1:size(Y,2)
    y = Y(i);
    f_1 = @(x) double(x.^2 + y.^2<=1);
    fval1(i) = Int_trap(f_1, 0,1,1000);
end

PI_2 = 4 / 1000 * sum(fval1)

%%% Using 2nd Approach

%% Problem 3 Using Quasi-Monto Carlo
% Define function
f2 = @(x) sqrt(1-x.^2)

% Use `N'eiderrieter, 'W'eyl and 'H'aber points do the 1000 draw
[n] = qnwequi(1000, 0, 1, 'N');

% Compute PI
PI_3 = 4 / size(n,1) * sum(f2(n))

%% Problem 4 Using Newton-Cotes
%Compute PI
PI_4 = 4 * Int_trap(f2, 0,1,1000)

%% Problem 5 

% Calculate Mean Squared Error for Quasi-Monto Carlo

Qmc_mse = [0,0,0];
m = [1000,10000,1000000];
for i = 1: size(m,2)
    j = 1;
    while j <=200
        [n] = qnwequi(m(i), 0, 1, 'N');
        Qmc_mse(i) = Qmc_mse(i) + (pi - 4 / size(n,1) * sum(f2(n)))^2;
        j = j + 1;
    end
    Qmc_mse(i) = Qmc_mse(i)/200;
end

% Calculate Mean Squared Error for Newton-Cotes

Nc_mse = [0,0,0];
m = [1000,10000,1000000];
for i = 1: size(m,2)
    j = 1;
    while j <=200
        Nc_mse(i) = Nc_mse(i) + (pi - 4 * Int_trap(f2, 0,1, m(i)))^2;
        j = j + 1;
    end
    Nc_mse(i) = Nc_mse(i)/200;
end

% Calculate Squared Error for Newton-Cotes

Nc_se = [0,0,0];
m = [1000,10000,1000000];
for i = 1: size(m,2)
    Nc_se(i) =(pi - 4 * Int_trap(f2, 0,1, m(i)))^2;
end

% Generate Table for Comparison

Method  = {'Quasi-MC MSE'; 'Newton-Cotes MSE'; 'Newton-Cotes SE'};
Draw_1000 = [Qmc_mse(1); Nc_mse(1); Nc_se(1)];
Draw_10000 = [Qmc_mse(2); Nc_mse(2); Nc_se(2)];
Draw_1000000 = [Qmc_mse(3); Nc_mse(3); Nc_se(3)];

T = table(Method,Draw_1000,Draw_10000,Draw_1000000)
    