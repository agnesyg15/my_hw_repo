function [Y] = f1(X)
    Y = [];
    for i = 1:length(X)
        Y(i) = -2 + 0.5 * X(i);
    end
end
