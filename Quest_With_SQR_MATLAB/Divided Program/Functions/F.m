function Fval = F(r,b,w,k,s)
%A function that calculates the value of characteristic polynomial of "K" for a value "t".
    Fval = polyvalm(poly(K(r,b,w,k)),s); 
end