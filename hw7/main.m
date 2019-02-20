clear;
tic;

L = 30;
% initial guess
V0 = ones(L,L)*20;

p0 = ones(L,L)*10;

%% Q.1 solve value and policy 
[V,p,iter] = solveValue(V0, p0);

elapsed = toc./60;
disp(sprintf('Elapsed time: %12.4f minutes', elapsed));

% Elapsed time:       9.1228 minutes
% iter = 53

% plot value and policy
mesh(V')
mesh(p')

%% Q.2 plot the distribution of states after 10, 20, 30 periods
[a_0, trans_P] = transition(p);

Distn_10 = dist_state(a_0, trans_P, 10);
bar3(Distn_10') 

Distn_20 = dist_state(a_0, trans_P, 20);
bar3(Distn_20')

Distn_30 = dist_state(a_0, trans_P, 30);
bar3(Distn_30)

%% Q.3 plot the limit distribution

Distn_limit = dist_state(a_0, trans_P, 1000);
bar3(Distn_limit)
