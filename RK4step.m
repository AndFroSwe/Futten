function [tout, uout] = RK4step (t, u, h)
% RK4STEP (t, u, h) calculates a step with RK4 method with step length h.  

% RK4 factors
k1 = h*F(t, u);
k2 = h*F(t+0.5*h, u+0.5*k1);
k3 = h*F(t+0.5*h, u+0.5*k2);
k4 = h*F(t+h, u+k3);

uout = u + (k1+2*k2+2*k3+k4)/6;
tout = t + h;

