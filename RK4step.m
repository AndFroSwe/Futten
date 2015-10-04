function [out] = RK4step (t, u, h)
% RK4STEP (t, u, h) calculates a step with RK4 method with step length h. Returns a struct. 

k1 = h*diff_ekv(u, c);
k2 = h*diff_ekv(u+h*k1/2, c);
k3 = h*diff_ekv(u+h*k2/2, c);
k4 = h*diff_ekv(u+h*k3, c);

uout = u + (k1+2*k2+2*k3+k4)/6;
tout = t + h;

out = struct(   'u', uout,...
                't', tout);
