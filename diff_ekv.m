function [u_ut] = diff_ekv(u, c)
% Function containing differential equations used to
% model the problem. Output is row vector of states.
% u(1) = r, u(2) = dr/dt, u(3) = phi, u(4) = dphi/dt
% c = [g R alpha G]

g = c(1);
R = c(2);
alpha = c(3);
G = c(4);

x1 = u(2);
x2 = u(1)*u(4)^2+G*cosd(alpha)-g*(R/u(1))^2;
x3 = u(4);
x4 = (G*sind(alpha)-2*u(2)*u(4))/u(1);

u_ut = [x1 x2 x3 x4];
