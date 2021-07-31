function Kval = K(r,b,w,k)
%A function that builds a 4x4 matrix 'K' from the above matrices developed.
    %Fetching the required Values and Matrices.
    S2temp = S2(r,b,w,k);
    Ztemp = Z(r,b,w,k);
    sigmatemp = sigma(r,b,w,k);
    %Final calculation
    Kval = [sigmatemp (Ztemp') ; Ztemp S2temp]; 
end