function Sval = S(r,b,w,k)
%A function to find a matrix 'S' which is nothing but a symmetric matrix obtained by adding 'B' and its transpose.
    Sval = B(r,b,w,k) + (B(r,b,w,k)'); 
end