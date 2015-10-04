function [c, g] = LS_interpol(x, y, order)
% LS_INTERPOL (vec, order) uses Least Squares to interpolate polynomial to specified order
% from dataset vec.

A = [];

for a=1:order+1                  %constructing the matrix A of T(t)=R
   A(:,a)=x.^(order+1-a);
end                            

c = A\y;

g = [];
for a=1:order+1
    g(a)=c(a)*(order+1-a);       %derivate R as a polynom
end

%b=(g(1:order));
%T0=roots (b);                  %time where R'=0    

