function [ L ] = arclength( x, C,y)
%  this funciton determin the length of a vector function. further is uses the
%  formula inf sum sqprt (1+f'^2) h=>0. in this case this sum will be
%  approximated with the MATLAB function trapz.
dL=[];
% steg=h/(x(end)-x(1)); %stegning
% x=[x(1):steg:x(end)];
for a=1:length(x)-1;
    deltax=x(a+1)-x(a);
    % If a polynomial, get intermediate points
    if y==0
    deltay=polyval(C,x(a+1))-polyval(C,x(a));
    % If a set of descrete points, use linear sumation
    elseif C==0
        deltay=y(a+1)-y(a);
    end
dS=sqrt(deltax^2+deltay^2);
dL=[dL dS];
end
L=sum(dL);
