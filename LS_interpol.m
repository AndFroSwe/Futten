function [c] = LS_interpol(x, y, order)
% LS_INTERPOL (vec, order) uses Least Squares to interpolate polynomial to specified order
% from dataset vec.

A = [];

for a=1:order+1                  %constructing the matrix A of T(t)=R
   A(:,a)=x.^(order+1-a);
end                            

c = A\y;


