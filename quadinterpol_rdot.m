function [T0] = quadinterpol_rdot(y_vec,x_vec)
% Uses quadratic interpolation to find when and where the r'=0 and thereby
% calculate the status in this point through linear interpolation.
% Input(u_t, matrix which consist of all intresting parameters (u) from main program) 
% Output[Vector with end values, Passing speed]
%% Create matrix and vectors
x_vec, y_vec
degree = 2;
% Create A-matrix
for j = 1:length(x_vec)
    for i = 1:(degree + 1)
        A(j,i) = x_vec(j)^(degree+1-i); 
    end
end
A
 AT=A'*A
 b=A'*y_vec;
 c=AT\b
 
for a=1:degree+1
    g(a)=c(a)*(degree+1-a);       %derivate R as a polynomial
end

b=(g(1:degree));
T0=roots (b);                  %time where R'=0    

end

