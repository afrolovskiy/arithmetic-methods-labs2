function result = K(u)
    global a;
    global b; 
    global sigma;
    result = a + b*(u.^sigma);
end

