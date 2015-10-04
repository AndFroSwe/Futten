function [res] = RK4(h, H, alpha)
% Finding errors

c1 = global_var();
G = Grav(H, c1(1), c1(2));              % Calculates earth grav pull at starting height
c1 = [c1 alpha G];
u1 = H;                                 % r-coordinate [Earth radii]
u2 = 0;                                 % dr/dt [Radii/h]
u3 = 0;                                 % phi angle [rad]
u4 = 0;                                 % dphi/dt [rad/h] 
u = [u1 u2 u3 u4];                      % Create starting state vector
t = 0;                                  % Starting t
u_t = [u t];                            % Vector containing all states and time [r dr/dt phi dphi/dt t]

for i = 1:h:3
    [u_new, t_new] = RK4step(u_t(end,1:4), t, h, c1);       % RK step evaluation
    u_t = [u_t; u_new t_new];                               % Add new values to old in matrix
    t = t_new;                                              % Change to new t
end

res = u_t(end, 1:4);