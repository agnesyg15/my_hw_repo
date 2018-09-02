function [Y] = f2(X)
    Y = [];
    for i = 1:length(X)
        Y(i) = -2 + 0.5 * X(i)^2;
    end
end


