function[c,g]=least_square(X,Y,grad)
% LEAST_SQUARE (X,Y,grad)X is the independent vector, Y is the vector of the result, grad is the grad of
% the desired polynomial.
for a=1:grad+1                  %constructing the matrix A of F(X)=Y
   A(:,a)=X.^(grad+1-a);
end
 c=A\Y;
for a=1:grad+1
    g(a)=c(a)*(grad+1-a);       %derivate c as a polynom
end
g=g(1:grad);
