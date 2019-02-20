function [W]= GetnW(V)
delta = 0.03;
L = 30;
W = zeros(L, L, 3);

for i = 1:L
    for j = 1:L
        delta_i = 1 - (1 - delta) ^ i; % prob of depreciation
        delta_j = 1 - (1 - delta) ^ j; % prob of depreciation
        W(i, j, 1)= V(i,j) * (1 - delta_i) * (1 - delta_j) + V(max(i-1, 1), j) * delta_i * (1 - delta_j)...
            + V(i, max(j-1, 1)) * (1 - delta_i) * delta_j + V(max(i-1, 1), max(j-1,1 )) * delta_i * delta_j;
        W(i, j, 2) = V(min(i+1, L), j) * (1 - delta_i) * (1 - delta_j) + V(i, j) * delta_i * (1 - delta_j)...
            + V(min(i+1, L), max(j-1, 1)) * (1 - delta_i) * delta_j + V(i, max(j-1, 1)) * delta_i * delta_j;
        W(i, j, 3) = V(i, min(j+1, L)) * (1 - delta_i) * (1 - delta_j) + V(max(i-1, 1), min(j+1, L)) * delta_i * (1 - delta_j)...
            + V(i, j) * (1 - delta_i) * delta_j + V(max(i-1, 1), j) * delta_i * delta_j;
    end
end