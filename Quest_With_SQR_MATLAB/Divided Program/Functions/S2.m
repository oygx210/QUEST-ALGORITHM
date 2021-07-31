function S2val = S2(r,b,w,k)
%A function that finds a matrix "S - sigma(B) * I (3x3)" say, 'S2'.
    S2val = S(r,b,w,k) - sigma(r,b,w,k)*eye(3);
end