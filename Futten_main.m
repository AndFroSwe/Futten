% Projektarbete "Rymdskeppet Futten illa ute"
% Andreas Fröderberg & Henrik Hvitfeldt
close all; clear all; clc;
%% Declare variables
check = 0;   % Enables accuracy control of quadinterpol
global alpha

pm = char(177);   % Plus minus sign
h = 0.01;  % Step length used in RK4
bisec_err = 0.0001;

%% Part 1: Test H-values and calculate passing r, t and phi for alpha = 90
% Runge Kuttas method while not crash and while not pass
disp('Part 1')
alpha = 90;
t_list = [];                        % Empty vector of passing t:s
r_list = [];                        % Empty vector of passing r:s
phi_list = [];                      % Empty vector of passing phi:s
H_list = [];                        % Empty vector of passing phi:s
crash_list = [];                    % Empty vector of passing phi:s
starting_heights = [10, 8, 6, 2];

% Test and plot trajectories for different H
figure ()
plotStyle = {'b','g','r','m'};                       % Set colors of trajectory plots
for i = 1:length(starting_heights)                   % Test H:s
    H = starting_heights(i);
    trajectory = RKeval(h, H);                       % Evaluate trajecory with RK4
    trajectory.H=H;
    trajectories(i) = trajectory;
    % Plot trajectory
    polar(trajectory.phi, trajectory.r, plotStyle{i})                      % Plot tracectory
    view([90 -90])                      % Flip plot to 0 deg up
    grid on; hold all;
    legendInfo{i} = ['Starting height ' num2str(H) ' earth radii'];       % Add legend info for use in legend command   
end
title ('Trajectories for different starting altitudes, \alpha =90')
legend(legendInfo)     % Set legends accoring to legend info

%find passing values for all trajectories   
for i = 1:length(starting_heights)
    trajectories_temp(i)=futten_pass(trajectories(i));
end
trajectories=trajectories_temp;


% Display results part 1
make_table(trajectories)

%% Part 2 Find H*, H when Futten just passes earth
% Bisection method to determine critical starting height, H_star, when 
% trajectory just passes earth.
start1=3;       %first start value for bisection method
start2=6;       %second startvalue for bisection method
start=[start1 start2];

H_star = bisection_meth(@futt_extra, start, h);
% Evaluate trajectory for H_star
trajectory_star = RKeval(h, H_star);
trajectory_star = futten_pass(trajectory_star);
fprintf('Futten passerar precis jordytan vid %0.3f%c%f jordradier\n', H_star, pm, bisec_err)
fprintf('vilket ger passeringsradie %0.3f%c%f jordradier\n', trajectory_star.r_pass, pm, trajectory_star.r_err)
fprintf('Passeringshastigheten är då %0.3f%c%f jordradier/h\n', trajectory_star.v_pass, pm, trajectory_star.v_err)
%%
% Calculate trajectory length
traj_length = arclength(trajectory_star.t, 0, trajectory_star.r); %distance traveled
traj_length_2h = arclength((trajectory_star.t(1:2:end)), 0, trajectory_star.r(1:2:end));
fprintf('och Futten har åkt avståndet %0.3f%c%f jordradier\n', traj_length, pm, abs(traj_length - traj_length_2h))

%% Plot trajectory at H_star
figure()
polar(trajectory_star.phi, trajectory_star.r,'r')
title('Trajectory at critical H, \alpha =90')
view([90 -90])
hold on;
phi_earth = 0:360/(length(trajectory_star.r)):360;
r_earth = ones(1,length(trajectory_star.r)+1);
polar(phi_earth,r_earth,'b')
legend('Trajectory','Earth')
pass_speed = trajectory_star.v_pass;
%% least square and length
figure()

var=trajectory_star.phi; 
plot (var, trajectory_star.r)
hold on
grad=2;
[C, dC]=least_square(var,trajectory_star.r,grad); %C=poly coeffs, dC=derivate
legendtext = sprintf('Interpolerad med polynom %0.2f%c^2%0.2f%c+%0.2f=r', C(1), 966, C(2), 966, C(3));
title('Kurva från RK4 mot interpolad till grad 2')
leg = {'RK4' legendtext};
% Plot interpolated
plot (var,polyval(C,var))
legend(leg)
%(analytiskt beräknad banlängd till 3.2018 från minsta kvadrat)
fprintf('Banlängden vid interpolering är %f jordradier\r\n', 3.2018)

%% Part 3 Find H* for different alphas

H_star_alpha = [];
alpha_list = [];
pass_speed_list = [];
figure()
% Loop over alphas and plot trajectory
i = 1;
alpha_legend = {};
alpha_pass = [];
alphas = [150:-10:50];
for alpha = alphas
    H_alpha = bisection_meth(@futt_extra, start, h);                    %optimal height for different alpha
    H_star_alpha = [H_star_alpha; H_alpha];                             %list of optimal heights
    alpha_list = [alpha_list alpha];                                    %alpha list
    trajectory_star_alpha=RKeval(h,H_alpha);                            %calculates the passing curve
    trajectory_pass_alpha=futten_pass(trajectory_star_alpha);           %calculates the passing paramaters for above curve
    pass_speed_list = [pass_speed_list trajectory_pass_alpha.v_pass];   %corresponding speed of angle 70:10:130
    polar(trajectory_pass_alpha.phi, trajectory_pass_alpha.r)
    view([90 -90])                      % Flip plot to 0 deg up
    hold on
    legend_text = sprintf('%c=%d', 945, alpha);
    v_err(i) = trajectory_pass_alpha.v_err;
    H_err(i) = trajectory_pass_alpha.r_err;
    alpha_legend{i} = legend_text;
    pass_speed(i) = trajectory_pass_alpha.v_pass;
    i = i + 1;
end

% Flip to fit table
alphas = alphas';
pass_speed = pass_speed';
v_err = v_err';
H_err = H_err';

% Calculate errors

title('Trajectories at different starting angles')
legend(alpha_legend)

alpha_table = table(alphas, H_star_alpha, H_err, pass_speed, v_err);
disp('Passing parameters for different alphas')
disp(alpha_table)
writetable(alpha_table, 'alphas.xls')

%% Convergence check for RK4
disp('Check convergence for RK4')
alpha = 90;
error_vektor=[];
no_of_tests = 3;

% Loop for different step length
for a=0:no_of_tests-1
    h_test = h*2^a;
    % Run convergence tests
    trajectory_error=RKevalerror(h_test, H_star,2);
    trajectories_err(a+1) = trajectory_error;
    % Save all values
    end_value=[ trajectory_error.r(end),...
                trajectory_error.rdot(end),...
                trajectory_error.phi(end),...
                trajectory_error.phidot(end)];
   error_vektor=[error_vektor; end_value];
end

r = getTableData(error_vektor(:, 1));
rdot = getTableData(error_vektor(:, 2));
phi = getTableData(error_vektor(:, 3));
phidot = getTableData(error_vektor(:, 4));

tab = table(r, rdot, phi, phidot);
writetable(tab, 'RKerrors.xls');
rows = {'end(h)' 'end(2h)' 'end(4h)' 'diff(h; 2h)e6' 'diff(2h; 4h)e6' 'kvot' 'rel error'};
tab.Properties.RowNames = (rows);
disp(tab)

