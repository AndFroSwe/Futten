function [u] = diff_ekv(u, c)
% Function containing differential equations used to
% model the problem. Output is row vector of states.
% u(1) = r, u(2) = dr/dt, u(3) = phi, u(4) = dphi/dt
% c = [g R alpha G]
% Change notation

u = [u(2), u(1)*u(4)^2+c(4)*cosd(c(3))-c(1)*(c(2)/u(1))^2, u(4), (c(4)*sind(c(3))-2*u(2)*u(4))/u(1)];

end