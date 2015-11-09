% Function takes a vector and assesses a linear intepolation error on last
% 2 values
function [err] = linpol_err(v)

% Define points
next_next_last = v(end -2);
next_last = v(end-1);
last = v(end);



