%% Q.2 Use tauchen.m to generate 21 grids for p_t
N = 21;
[prob,grid] = tauchen(N,0.5,0.5,0.1)

%% Q.3 Plot the value of firm depending on the initial stock and current price p = 0.9, 1, 1.1
% Use value function iteration
S = 100;
delta = 0.95;
V_ini = zeros(N, S + 1);
prob = prob';


V = zeros(N, S + 1); % V(i,j) maximum firm value when price is grid(i), amount of harvest left is j+1
X_temp = zeros(N, S + 1); % X(i,j) optimal harvest policy when price is grid(i), amount of harvest left is j+1
diff = 1;
tol = 1e-6;

while diff > tol
    for i = 1 : N
        for s = 1 : (S+1)
            V_temp = [];
            for x = 1 : s
                V_temp(x) = grid(i) * (x - 1) - 0.2 * ((x - 1).^ 1.5) ...
                    + delta * (V_ini(:, s - x + 1))' * prob(:, i);
            end
            [V(i,s), X_temp(i,s)] = max(V_temp);
        end
    end
    diff = norm(V - V_ini);
    V_ini = V;
end

X = X_temp - 1; % adjust the optimal harvest amount


% plot the value of the firm depending on the initial stock
% when current p = 0.9, plot V(8,:), since grid(8) = 0.8961 close to 0.9

x = 0 : S;
plot(x, V(8,:))
xlabel('Initial stock level')
ylabel('Firm value')
title('Firm value when current price p = 0.9')

% add hold on to plot multiple graphs on the same figure
hold on


% when current p = 1
x = 0 : S;
plot(x, V(11,:))
xlabel('Initial stock level')
ylabel('Firm value')
title('Firm value when current price p = 1')

% when current p = 1.1, plot V(14,:), since grid(14) = 1.1039 close to 1.1
x = 0 : S;
plot(x, V(14,:))
xlabel('Initial stock level')
ylabel('Firm value')
title('Firm value when current price p = 1.1')

%% Q.4 Plot optimal harvest amount as a function of today's price and different stock level
[m, n] = meshgrid(grid, 0 : S);
mesh(m,n,X')
xlabel('current price')
ylabel('stock level')
zlabel('harvest amount')

% You need to try more discrete grid, this one looks too coarse

%% Q.5 Firms starts with stock 100 and price 1, expected stock over time for 20 periods

times = 1000; % use 1000 samples to calculate the expected value
Stock = zeros(times, 21);
Stock(:, 1) = 100;
Stock(:, 2) = 100 - X(find(grid == 1), 100);
p = [];
p(1) = 1;
p(2) = grid(randsample(21,1,true,prob(:,find(grid == 1))));
for i = 1 : times
    for j = 3 : 21
        p(j) = grid(randsample(21,1,true,prob(:,find(grid == p(j-1)))));
        Stock(i,j) = 100 - X(find(grid == p(j)), 100);
    end
end
Stock_exp = mean(Stock, 1);

% plot expected stock level against 20 periods ahead
t = 1:21;
plot(t, Stock_exp)
xlabel('t period')
ylabel('Expected stock level')

% the shape is wrong, how come it's increasing sometimes? trees don't grow,
% remember?

%% Q.6 Redo 2-4 for coarse grid of 5 points in Tauchen's representation

N = 5;

% and use the code in 2-4