function [result] = W(t)
    global t0;
    global Q;
    if (t >= t0)
        result = 0.0;
    else
        result = Q;
    end;
end

