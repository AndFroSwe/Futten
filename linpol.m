function [y_out, err]=linpol (x,y,xq)
% LINPOL (x,y,xq) returns y(xq) with a linear interpolation of the points
% x=[x1 x2] and y=[y1 y2]. Also returns error of estimation.

% Calculate interpolated point
y_out = y(2)+(y(3)-y(2))/(x(3)-x(2))*(xq-x(2));

% Calculate interpolation at double step size
y_out_2h = y(1)+(y(2)-y(1))/(x(2)-x(1))*(xq-x(1));

% Calculate error
err = abs(y_out - y_out_2h);