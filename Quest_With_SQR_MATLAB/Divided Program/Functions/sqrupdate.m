function sqrupdateval = sqrupdate(finalq)
%Records the component of highest magnitude for the next cases.
%Preferred axis component if SQR turns up.

    q1 = abs(finalq(1));
    q2 = abs(finalq(2));
    q3 = abs(finalq(3));
    
    if (q1>q2&&q1>q3)
        t = 1;
    elseif (q2>q1&&q2>q3)
        t = 2;
    else
        t = 3;
    end
    
    sqrupdateval = t;
    
end