function [root] = bisection_meth (fhandle, start, h)
%  BISECTION_METH (fhandle,f, start, it_allowed, delta, h, c1)
% fhandle is the function evaluated with bisection method to find roots, f is the
% variable searched for if the function outputs a struct, else it should be set to 0=zero.
%start is the start values, It_allowed is the number of iterations allowed. delta is
% the allowed h. h is not right and neither is c1.
% Finds root for function 'fhandle' using bisection method. Precision is
% size of h (dx) allowed.

delta = 0.0001;
it_allowed = 100;
x0 = start(1); 
x1 = start(2); 
it = 1;       % Starting values, it = iteration counter
[out] = feval(fhandle, h, x0); % Evaluate function at starting value 1
f0 = out;
deltax = 1;

% Bisection method
while abs(deltax) > delta
    % Convergence ceiling
    if it > it_allowed
        disp('Bisection iteration timeout')
        break
    end
    [out] = feval(fhandle, h, x1);            % Evaluate function at x1
    f1=out;
    deltax = (x1 - x0)/(f1 - f0)*f1;         % Calculate dx
    x0 = x1; 
    f0 = f1;                   % New best guess
    x1 = x1 - deltax;                        % New best x = old best x - h
    it = it + 1;                        % Iteration counter step
end

root = x1;
