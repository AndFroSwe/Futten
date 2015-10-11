function [v] = getTableData(error_col)
% getTableData (error_col) gets a vector containing all data according to
% prespecified table properties.

%konvergenskoll
delta = abs(diff(error_col));
kvot = delta(2)/delta(1);
rel_err = (error_col(1)-error_col(2))/error_col(1);
% Make a vector of results
v = error_col;
v(4:5) = delta*1e6;
v(6) = kvot;
v(7) = abs(rel_err);
