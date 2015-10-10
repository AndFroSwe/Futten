function [trajectory] = RKevalerror (h, H,t_in)
% RKEVAL (h, H) Evaluates system until earth is passed or crashed into for
% starting height H and step lengt h.
% Used RK4step for evaluation.
% Returns struct with trajectory parameters

u = [H 0 0 0];                          % Initial conditions
t = 0;                                          % Starting t
trajectory = struct(    't',        t,...
                        'r',        u(1),...
                        'rdot',     u(2),...
                        'phi',      u(3),...
                        'phidot',   u(4));


% Evaluates while rdot is negative
while trajectory.t <= t_in                        
    [t, u] = RK4step(t, u, h);       % RK step evaluation
    trajectory.t = [trajectory.t; t];
    trajectory.r = [trajectory.r; u(1)];
    trajectory.rdot = [trajectory.rdot; u(2)];
    trajectory.phi = [trajectory.phi; u(3)];
    trajectory.phidot = [trajectory.phidot; u(4)];  
end
