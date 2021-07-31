function Bval = B(r,b,w,k)
%A function that build our 3x3 matrix 'B'; A weigted summation of the outer products of vectors in both the frames i.e. body 'b' and reference 'r'.
    Bval = zeros (3,3);
    for c = 1:k
        Bval = Bval + w(c)*(b(c,:)')*(r(c,:));
    end
end