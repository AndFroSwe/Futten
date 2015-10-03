% Projektarbete "Rymdskeppet Futten illa ute"
% Andreas Fröderberg & Henrik Hvitfeldt
% Stanko Sprit & Strömningsmekanik AB?
% Rev 1
% Create main program with empty functions
close all; clear all; clc;
%% Define variables
% Function containing all variables
[c1] = global_var;                      % c = Vector of constants [g, R]
t = 0;                                  % Starting time [h]
% Starting values Part 1
alpha = 50;                             % [deg]
H = 10;                                 % [Earth radii]
G = Grav(H, c1(1), c1(2));              % Calculates earth grav pull at starting height
u1 = H;                                 % r-coordinate [Earth radii]
u2 = 0;                                 % dr/dt [Radii/h]
u3 = 0;                                 % phi angle [rad]
u4 = 0;                                 % dphi/dt [rad/h] 
u = [u1 u2 u3 u4];                      % Create starting state vector
u_t = [u t];                            % Vector containing all states and time [r dr/dt phi dphi/dt t]
c1 = [c1 alpha G];                      % Vector of constants [g R alpha G]
%% Part 1: Solve ODE
h = 0.1;                                % Step length [h]
pass = 1;                               % Pass earth condition 
while u_t(end,1) >= 1 && pass >= 0      % Runge Kuttas method while not crash and while not pass
    [u_new t_new] = RK4step(u_t(end,1:4), t, h, c1);        % RK step
    u_t = [u_t; u_new t_new];                               % Add new values to old in matrix
    pass = u_t(end-1,1) - u_t(end,1)                        % Pass if new r is bigger than old
    t = t_new;                                              % Change to new t
end

disp(u_t)
% figure (1)
% 
% polar(ones(length(u_t),1))
% hold on
% polar(u_t(:,3),u_t(:,1))
% view([90 -90])

