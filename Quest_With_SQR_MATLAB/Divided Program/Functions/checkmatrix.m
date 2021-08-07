function checkmatrixval = checkmatrix(r,b,w,k)
    checkmatrixval = abs(det(((root(r,b,w,k)+sigma(r,b,w,k))*eye(3)-det(S(r,b,w,k)))));
end

