function [result] = norma(x)
    sum = 0;
    [m, n] = size(x);
    for i = 1:m
        for j = 1:n
            sum = sum + x(i, j)*x(i, j);            
        end;
    end;
    result = sqrt(sum);
end

