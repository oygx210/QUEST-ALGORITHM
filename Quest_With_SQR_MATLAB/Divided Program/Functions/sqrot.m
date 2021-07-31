function qval = sqrot(r,b,w,k,t)
%A function that deals with the "180 degrees" case, where QUEST fails if used directly.

    %Altering the vectors in reference frame according to the new frame.
    r = -r;
    r(:,t) = -r(:,t);
    
    %Applying Quest to that set of vectors.
    qnew = q(r,b,w,k);
    
    %Rearranging the terms to bring the quaternion in Original Frame.
    
    %Defining the axis of rotation.
    e = zeros(3,1);
    e(t) = 1;
    %Defining the "cross product matrix i.e. [e x]" of 'e'.
    E = [0 -e(3) e(2) e(1) ; e(3) 0 -e(1) e(2) ; -e(2) e(1) 0 e(3) ; -e(1) -e(2) -e(3) 0];
    %The transformation back to the original reference frame.
    qval = E*qnew;
    
    %Fixing the negative scalar component if present.
    if qval(4) < 0
        qval = -qval;
    end
    
end