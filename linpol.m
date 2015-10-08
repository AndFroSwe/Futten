function [y_out]=linpol (x,y,xq)
% LINPOL (x,y,xq) returns y(xq) with a linear interpolation of the points
% x=[x1 x2] and y=[y1 y2]


y_out=y(1)+(y(2)-y(1))/(x(2)-x(1))*(xq-x(1));
