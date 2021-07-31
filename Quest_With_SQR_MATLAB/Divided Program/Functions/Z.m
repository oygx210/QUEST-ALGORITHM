function Zval = Z(r,b,w,k)
%A function that builds a column vector 'Z' from certain elements of matrix 'B'.
    Btemp = B(r,b,w,k);
    Zval = [Btemp(2,3)-Btemp(3,2) ; Btemp(3,1)-Btemp(1,3) ; Btemp(1,2)-Btemp(2,1)]; 
end