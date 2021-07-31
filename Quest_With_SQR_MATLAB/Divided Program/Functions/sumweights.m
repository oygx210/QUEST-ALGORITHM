function sumweightsval = sumweights(w,k)
%A function defination that just sums up the weights of all measurements to give lambda0; An initial guess for the required eigen value.  
    sumweightsval = 0;
    for c = 1:k
        sumweightsval = sumweightsval + w(c);    
    end
end
