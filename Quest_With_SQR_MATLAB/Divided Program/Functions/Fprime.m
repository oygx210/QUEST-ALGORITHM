function Fvalprime = Fprime(r,b,w,k,s)
%A function that calculates the value of derivative of 'F' at 's'.
    Fvalprime = polyvalm(polyder(K(r,b,w,k)),s); 
end