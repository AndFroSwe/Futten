function [trajectory] = RKeval (h, H)
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
while trajectory.rdot <= 0                        
    [t, u] = RK4step(t, u, h);       % RK step evaluation
    trajectory.t = [trajectory.t; t];
    trajectory.r = [trajectory.r; u(1)];
    trajectory.rdot = [trajectory.rdot; u(2)];
    trajectory.phi = [trajectory.phi; u(3)];
    trajectory.phidot = [trajectory.phidot; u(4)];  
end

% 
  %Interpolate passing t  with quadratic interpolation
% t_pass = quadinterpol(u_t(end-11:end,1),u_t(end-11:end,5));  % Interpolate t value when pass earth
% % Interpolate passing r with hermite interpolation
% t1 = u_t(end-1,5); t2 = u_t(end,5);
% r1 = u_t(end-1,1); r2 = u_t(end,1);
% r_prim1 = u_t(end-1,2); r_prim2 = u_t(end,2);
% r_pass = herm(t_pass, t1, t2, r1, r2, r_prim1, r_prim2, 'r');
% % Interpolate passing phi with hermite interpolation
% t1 = u_t(end-1,5); t2 = u_t(end,5);
% phi1 = u_t(end-1,3); phi2 = u_t(end,3);
% phi_prim1 = u_t(end-1,4); phi_prim2 = u_t(end,4);
% phi_pass = herm(t_pass, t1, t2, phi1, phi2, phi_prim1, phi_prim2,'phi');
% % Interpolate passing phi_dot using quadratic interpolation
% phi_dot_pass = quadinterpol_phidot(u_t(end-11:end,4),u_t(end-11:end,5),t_pass);


end