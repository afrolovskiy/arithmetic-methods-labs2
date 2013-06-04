function [result] = Kplus(u, rightU)
    result = (K(u) + K(rightU)) ./ 2.0;
end

