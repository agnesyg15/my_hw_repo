function dep = depreciation(i) % prob of depreciation 
delta = 0.03;
dep = 1 - (1 - delta) ^ i;
end