Main()
%%
function Main()
    
    %Arbitrary value of t required to select AOR in SQR.
    t = 1;
    
    while (true)
        
        %Arrangement to end the program.
        if (input('Press -1 to exit: ') == -1)
            break;
        end
    
        %Asks for the number of measurements made.
        k = input('Enter the number of vectors available: ');
        %Asks for the vectors in reference frame.
        r = zeros(3,k);
        for i = 1:k
            for j = 1:3
                r(i,j) = input('Reference Frame Vector '+string(i)+' -> '+'Component'+string(j)+': ');
            end
        end
        %Asks for the vectors in Body Frame.
        b = zeros(3,k);
        for i = 1:k
            for j = 1:3
                b(i,j) = input('Body Frame Vector '+string(i)+' -> '+'Component'+string(j)+': ');
            end
        end
        %Asks for weigts if any.
        w = zeros(1,k);
        for i = 1:k
            w(i) = input('Weightage Of Vector '+string(i)+': ');
        end
    
        %Check for Singularity Case (180 degree rotation case).
        if (abs(det(S2(r,b,w,k))))<0.01
            finalq = sqrot(r,b,w,k,t);
        else
            finalq = q(r,b,w,k);
        end
    
        %Purpose of our program.
        disp(finalq);
        
        %SQR 't' updation.
        t = sqrupdate(finalq);
   
    end
    
end