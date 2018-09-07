%% Problem_1

clear

X = [1, 1.5, 3, 4, 5, 7, 9, 10];
Y1 = f1(X);
Y2 = f2(X);

plot(X, Y1, X, Y2)
legend('Y1', 'Y2')
xlabel('X')
ylabel('Y1 or Y2')

%% Problem_2

clear

% Generate a evenly spaced row vector

X = (linspace(-10, 20, 200))';

% Calculate the sum of the elements

S = sum(X);

%% Problem_3

clear

A = [2, 4, 6; 1, 7, 5; 3, 12, 4];

b = [-2; 3; 10];

% Calculate C
C = A' * b;

% Calculate D
D = inv(A' * A) * b;

% Calculate E
[m,n] = size(A);
E = 0;
for i = 1:m
    for j = 1:n
% comment: take a careful look at the assignment, you calculate the wrong sum it should have been A(i,j)*b(i)
        E = E + A(i,j) * b(j);
    end
end

% Calculate F
F = A([1,3],[1:2]);

% Solve Ax = b
x = A\b;

%% Problem_4

clear

A = [2, 4, 6; 1, 7, 5; 3, 12, 4];

B = blkdiag(A,A,A,A,A);

%% Problem_5

clear

% Create A
A = normrnd(10, 5, 5, 3);

% Convert A to A_new
A_new = zeros(size(A));
[m,n] = size(A);
for i = 1:m
    for j = 1:n
        if A(i,j) < 10
            A_new(i,j) = 0;
        else
            A_new(i,j) = 1;
        end
    end
end

%% Problem_6

clear 

A = csvread('datahw1.csv');
Export = A(:,3);
RD = A(:,4);
cap = A(:,6);
prod = A(:,5);
X = [zeros(size(A,1),1) + 1, Export, RD, cap];

% Compute OLS estimator
beta = inv(X' * X) * (X' * prod);

% Compute point estimates
prod_est = X * beta;

% Compute standard errors
stand_er = prod - prod_est;
% This is not standard errors, these are residuals and you don't print out
% the betas ans standard errors