function [root] = bisection_meth (fhandle, start1, start2, it_allowed, delta, print_it, h, c1)
% Andreas Froderberg 20141207
% Finds root for function 'fhandle' using bisection method. Precision is
% size of h (dx) allowed.
% Input(Function handle, Starting guess 1, Starting guess 2, Allowed number of iterations, Precision...
%  ..., If print_it = 1 iterations are displayed)


x0 = start1; x1 = start2; it = 1;       % Starting values, it = iteration counter
[u0 t0 r0 phi0] = feval(fhandle, h, x0, c1);                 % Evaluate function at starting value 1
f0 = r0 - 1;
H = 1; oldh = 1; Ktest = [];            % Define variables
% Bisection method
while abs(H) > delta
    [u1 t1 r1 phi1] = feval(fhandle, h, x1, c1);            % Evaluate function at x1           
    f1 = r1 - 1;
    H = (x1 - x0)/(f1 - f0)*f1;         % Calculate dx
    if it <= 2
        if print_it == 1 
            disp([x1, f1, H])
        end
    else 
        Ktest = H/oldh/elderh;
        if print_it == 1
            disp([x1, f1, h, Ktest])
        end
    end
    x0 = x1; f0 = f1;                   % New best guess
    x1 = x1 - H;                        % New best x = old best x - h
    elderh = oldh; oldh = H;            % Save old dx
    it = it + 1;                        % Iteration counter step
    if it == it_allowed
        error('Troligen ej konvergens')
    end
end

root = x1;


end