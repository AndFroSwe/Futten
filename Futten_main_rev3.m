% Projektarbete "Rymdskeppet Futten illa ute"
% Andreas Fröderberg & Henrik Hvitfeldt
% Stanko Sprit & Strömningsmekanik AB
% Rev 3
% Solve ODE and plot curve.
close all; clear all; clc;
%% Define variables
% Function containing all variables
c1 = global_var;                        % c = Vector of constants [g, R]
t = 0;                                  % Starting time [h]
% Starting values Part 1
alpha = 90;                              % [deg]
H = 6;                                  % [Earth radii]
G = Grav(H, c1(1), c1(2));              % Calculates earth grav pull at starting height
u1 = H;                                 % r-coordinate [Earth radii]
u2 = 0;                                 % dr/dt [Radii/h]
u3 = 0;                                 % phi angle [rad]
u4 = 0;                                 % dphi/dt [rad/h] 
u = [u1 u2 u3 u4];                      % Create starting state vector
u_t = [u t];                            % Vector containing all states and time [r dr/dt phi dphi/dt t]
c1 = [c1, alpha G];                     % Vector of constants [g R alpha G]
h = 0.001;
%% Part 1: Find approximate H value that passes earth
% Runge Kuttas method while not crash and while not pass
[u_t, crash] = RKeval(h, u_t, c1);


%% Part 2 Find H*, H when Futten just passes earth







figure ()
polar(u_t(:,3),u_t(:,1))
view([90 -90])

if crash == 0
R=[u_t(end-2,1) u_t(end-1,1) u_t(end,1)];
T=[u_t(end-2,5) u_t(end-1,5) u_t(end,5)];
T0 = linearinterpol(R,T);
vikt=(T0-T(2))/(T(3)-T(2));
Rprim=(u_t(end,2)-u_t(end-1,2))*vikt+u_t(end-1,2);

end
