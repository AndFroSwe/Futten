function [G] = Grav (H, g, R)
% Gravitational pull at starting altitude
% Input(Starting height, gravitational pull at surface, earth radius)
% Outout(See description)

G = (g*R^2)/(R+H)^2;

end