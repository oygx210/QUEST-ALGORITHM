Main()
%%
function Main()
    
    t = 1;
    
    while (2>1)
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
        if (abs(S2(r,b,w,k)))<0.001
            finalq = sqrot(r,b,w,k,t);
        else
            finalq = q(r,b,w,k);
        end
    
        disp(finalq);
        
    end
end
%% 
% A function defination that just sums up the weights of all measurements to 
% give lambda0; An initial guess for the required eigen value.

function sumweightsval = sumweights(w,k) 
    sumweightsval = 0;
    for c = 1:k
        sumweightsval = sumweightsval + w(c);    
    end
end
%% 
% A function that build our 3x3 matrix 'B'; A weigted summation of the outer 
% products of vectors in both the frames i.e. body 'b' and reference 'r'.

function Bval = B(r,b,w,k)
    Bval = zeros (3,3);
    for c = 1:k
        Bval = Bval + w(c)*(b(c,:)')*(r(c,:));
    end
end
%% 
% A function that calculates the trace of matrix 'B' obtained above.

function sigmaval = sigma(r,b,w,k)
    sigmaval = trace(B(r,b,w,k));
end
%% 
% A function to find a matrix 'S' which is nothing but a symmetric matrix obtained 
% by adding 'B' and its transpose.

function Sval = S(r,b,w,k)
    Sval = B(r,b,w,k) + (B(r,b,w,k)');
end
%% 
% A function that finds a matrix "S - sigma(B) * I (3x3)" say, 'S2'.

function S2val = S2(r,b,w,k)
    S2val = S(r,b,w,k) - sigma(r,b,w,k)*eye(3);
end
%% 
% A function that builds a column vector 'Z' from certain elements of matrix 
% 'B'.

function Zval = Z(r,b,w,k)
    Btemp = B(r,b,w,k);
    Zval = [Btemp(2,3)-Btemp(3,2) ; Btemp(3,1)-Btemp(1,3) ; Btemp(1,2)-Btemp(2,1)];
end
%% 
% A function that builds a 4x4 matrix 'K' from the above matrices developed.

function Kval = K(r,b,w,k)

    %Fetching the required Values and Matrices.
    S2temp = S2(r,b,w,k);
    Ztemp = Z(r,b,w,k);
    sigmatemp = sigma(r,b,w,k);
    
    Kval = [sigmatemp (Ztemp') ; Ztemp S2temp];
    
end
%% 
% A function that calculates the value of characteristic polynomial of "K" for 
% a value "t".

function Fval = F(r,b,w,k,s)

    Fval = polyvalm(poly(K(r,b,w,k)),s);
    
end
%% 
% A function that calculates the value of derivative of 'F' at 's'.

function Fvalprime = Fprime(r,b,w,k,s)

    Fvalprime = polyvalm(polyder(K(r,b,w,k)),s);
    
end
%% 
% A function that calculates the root of the characteristic polynomial of 'K' 
% closest to our initial guess 'sumweights'.

function rootval = root(r,b,w,k)
    
    %Initial guess = Summation of the weights.
    a0 = sumweights (w,k);
    
    %Newton Raphson iterations.
    while F(r,b,w,k,a0) > 0.001
        a0 = a0 - (F(r,b,w,k,a0)/Fprime(r,b,w,k,a0));
    end
    
    rootval = a0;
    
end
%% 
% A function that calculates the quaternion from the root obtained above.

function qval = q(r,b,w,k)
    
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
%% 
% A function that deals with the "180 degrees" case, where QUEST fails if used 
% directly.

function qval = sqrot(r,b,w,k,t)

    %Altering the vectors in reference frame according to the new frame.
    r = -r;
    for i = 1:k
        r(i,t) = -r(i,t);
    end
    
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