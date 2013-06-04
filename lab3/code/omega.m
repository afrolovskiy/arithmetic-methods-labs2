function [result] = omega(N)
    result = 2 / (1 + sin(pi/N)) + 1e-4;
end

