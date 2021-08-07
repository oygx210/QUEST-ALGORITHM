function rootval = root(r,b,w,k)
%A function that calculates the root of the characteristic polynomial of 'K' closest to our initial guess 'sumweights'.

    %Initial guess = Summation of the weights.
    a0 = sumweights (w,k);
    
    %Newton Raphson iterations.
    while F(r,b,w,k,a0) > 0.1
        a0 = a0 - (F(r,b,w,k,a0)/Fprime(r,b,w,k,a0));
    end
    
    rootval = a0;
    
end