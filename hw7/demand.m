function d = demand(p1, p2) % prob that firm1 makes the sale
v = 10; 
    d = exp(v - p1) / (1 + exp(v - p1)+ exp(v - p2));
    
end 