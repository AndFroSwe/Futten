function [u_ut] = F(t, u)
% F (t, u) returns derivatives of physical system.
% Output is [r rdot phi phidot]

global alpha % Is global so no input is needed (for use in ode45)

% Define parameters
g = 20;                 % Gravity constant[earth radii/hour]
R = 1;                  % Radius of earth
G = Grav(u(1), g, R);   % Engine force

x1 = u(2);
x2 = u(1)*u(4)^2+G*cosd(alpha)-g*(R/u(1))^2;
x3 = u(4);
x4 = (G*sind(alpha)-2*u(2)*u(4))/u(1);

u_ut = [x1 x2 x3 x4];
