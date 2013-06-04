function [result] = Kminus(leftU, u)
    result = (K(leftU) + K(u)) ./ 2.0;
end

