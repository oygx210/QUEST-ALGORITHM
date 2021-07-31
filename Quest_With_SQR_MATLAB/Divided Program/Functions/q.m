function qval = q(r,b,w,k)
%A function that calculates the quaternion from the root obtained above.

    %Fetching all the required values and matrices.
    temp = root(r,b,w,k) + sigma(r,b,w,k);
    Stemp = S(r,b,w,k);
    Ztemp = Z(r,b,w,k);
    
    %Vectorial section of quaternion.
    qvector = (inv(temp*eye(3)-Stemp))*Ztemp;
    
    %Normalising the quaternion.
    qtemp = [qvector ; 1];
    qval = qtemp/norm(qtemp);
    
end