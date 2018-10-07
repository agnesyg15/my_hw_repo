%% Problem_1

% Define demand function

demand = @(v,p) exp([v-p;0])/sum(exp([v-p;0]));

% Compute demand 
v = [2;2];
p = [1;1];
d = demand(v,p);

D_A = d(1) % Demand for product A
D_B = d(2) % Demand for product B
D_0 = d(3) % Demand for outside option

%% Problem_2

v = [2;2];
% Initial guess of p = [p_A;p_B]
p_ini = [1;1];

% Call Broyden
addpath /Users/YinshiG/Desktop/'Econ 512'/Lectures/CEtools

% use relative path to functions. I have a very different path on my
% computer. use addpath ../compecon/CEtools for example if compecon is one
% folder up.

tic % calculate the execution time for comparison in Problem_3
[x,fval,flag,it,fjacinv] = broyden(@(p) bertrand_foc(p,v),p_ini);
T_boyden = toc;

% Nash pricing equilibrium
p_nash = x


%% Problem_3 Use Gauss-Seidel iteration method to solve for equilibrium price
v = [2;2];

p_ini = [1;1];

tic
p_nash2 = gauseid(p_ini, v);
T_gauseid = toc;


% Compare the execution time between Boyden's method and Gauss-Seidel (with Secant
% method in inner iteration)

T_boyden > T_gauseid


%% Problem_4

v = [2;2];

% Still use Gauss-Seidel method for outer iteration

p_ini = [1;1];

tic
p_nash3 = update(p_ini, v);
T_update = toc;
% be sure to pring all the results in command line so that I can see them


%% Problem_5

% Using Boyden's method

v_A = 2;
v_B = 0: .2 : 3;
p_ini = [1;1];
p_A = [];
p_B = [];

for i = 1:length(v_B)
    x = broyden(@(p) bertrand_foc(p,[v_A;v_B(i)]),p_ini);
    p_A(i) = x(1);
    p_B(i) = x(2);
end

plot(v_B, p_A, v_B, p_B);
legend('p_A', 'p_B');
xlabel('v_B');
ylabel('p_A or p_B');
