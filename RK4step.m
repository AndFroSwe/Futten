function [uout, tout] = RK4step (u, t, h, c)
% One step of Runge-Kutta Method 4 for solvning ODE
% Input(System of ODE to be evaluated, Starting u, Starting t, Step Size,...
%..., Starting angle, Gravitational pull at surface, Gravitational pull at start,...
% ..., Earth radius)
% c = Vector of constants [g R alpha G]
% Output[Nex u, new t]

k1 = h*diff_ekv(u, c);
k2 = h*diff_ekv(u+h*k1/2, c);
k3 = h*diff_ekv(u+h*k2/2, c);
k4 = h*diff_ekv(u+h*k3, c);

uout = u + (k1+2*k2+2*k3+k4)/6;
tout = t + h;

end