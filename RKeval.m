function [u_t, t_pass, r_pass, phi_pass, phi_dot_pass] = RKeval (h, H, c1)
% Evaluates system until earth is passed or crashed into.
% Used RK4step for evaluation
% Input(Step length, vector with system info[r dr/dt phi dphi/dt t], Vector with constants)
% Output[Values during flight, Crash(=1 yes, =0 No]                               % Starting time [h]

global check


G = Grav(H, c1(1), c1(2));              % Calculates earth grav pull at starting height
c1 = [c1 G];
u1 = H;                                 % r-coordinate [Earth radii]
u2 = 0;                                 % dr/dt [Radii/h]
u3 = 0;                                 % phi angle [rad]
u4 = 0;                                 % dphi/dt [rad/h] 
u = [u1 u2 u3 u4];                      % Create starting state vector
t = 0;                                  % Starting t
u_t = [u t];                            % Vector containing all states and time [r dr/dt phi dphi/dt t]
pass = 0;

% Evaluates while current r is less than previous r (pass condition)
while u_t(end,2)<=0                        
    [u_new, t_new] = RK4step(u_t(end,1:4), t, h, c1);       % RK step evaluation
    u_t = [u_t; u_new t_new];                               % Add new values to old in matrix
    t = t_new;                                              % Change to new t
end


% Interpolate passing t  with quadratic interpolation
t_pass = quadinterpol(u_t(end-11:end,1),u_t(end-11:end,5));  % Interpolate t value when pass earth
% Interpolate passing r with hermite interpolation
t1 = u_t(end-1,5); t2 = u_t(end,5);
r1 = u_t(end-1,1); r2 = u_t(end,1);
r_prim1 = u_t(end-1,2); r_prim2 = u_t(end,2);
r_pass = herm(t_pass, t1, t2, r1, r2, r_prim1, r_prim2, 'r');
% Interpolate passing phi with hermite interpolation
t1 = u_t(end-1,5); t2 = u_t(end,5);
phi1 = u_t(end-1,3); phi2 = u_t(end,3);
phi_prim1 = u_t(end-1,4); phi_prim2 = u_t(end,4);
phi_pass = herm(t_pass, t1, t2, phi1, phi2, phi_prim1, phi_prim2,'phi');
% Interpolate passing phi_dot using quadratic interpolation
phi_dot_pass = quadinterpol_phidot(u_t(end-11:end,4),u_t(end-11:end,5),t_pass);


end