% Function takes a vector and assesses a linear intepolation error on last
% 2 values
function [err] = linpol_err(v)

next_last = v(end-1);
last = v(end);

mid = mean([next_last last]);
err = abs(last - mid);

