function [ L ] = arclength( u_t )
%UNTITLED3 Summary of this function goes here
%  this funciton determin the length of a vector function. further is uses the
%  formula inf sum sqprt (1+f'^2) h=>0. in this case this sum will be
%  approximated with the MATLAB function trapz.

T=u_t(:,5);   %time vector from u_t
y=u_t(:,2);   %Rprim vector from u_t
h = abs((T(1)-T(2))); 
Lvektor = [];

for a=1:length (T);
f=h*sqrt((1+y(a)^2)); %formula for the arc length
Lvektor=[Lvektor,f];
end
L=sum (Lvektor);    %MATLAB function for integrate f over T which puts out the arc length L
end

