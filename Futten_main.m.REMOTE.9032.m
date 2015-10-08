% Projektarbete "Rymdskeppet Futten illa ute"
% Andreas Fröderberg & Henrik Hvitfeldt
close all; clear all; clc;
%% Declare variables
global check phi_err r_err t_err phi_dot_err
check = 0;   % Enables accuracy control of quadinterpol
global alpha
h = 0.001;  % Step length used in RK4

%% Part 1: Test H-values and calculate passing r, t and phi for alpha = 90
% Runge Kuttas method while not crash and while not pass
disp('Part 1')
alpha = 90;
t_list = [];         % Empty vector of passing t:s
r_list = [];         % Empty vector of passing r:s
phi_list = [];       % Empty vector of passing phi:s
H_list = [];         % Empty vector of passing phi:s
crash_list = [];     % Empty vector of passing phi:s
starting_heights = [10, 8, 6, 2];

% Test and plot trajectories for different H
figure ()
plotStyle = {'b','g','r','m'};          % Set colors of trajectory plots
for i = 1:length(starting_heights)                   % Test H:s
    H = starting_heights(i);
    trajectory = RKeval(h, H);     % Evaluate trajecory with RK4
    trajectories(i) = trajectory; 
    % Plot trajectory
    polar(trajectory.phi, trajectory.r, plotStyle{i})                      % Plot tracectory
    view([90 -90])                      % Flip plot to 0 deg up
    grid on; hold all;
    legendInfo{i} = ['Starting height ' num2str(H) ' earth radii'];       % Add legend info for use in legend command   
end
title ('Trajectories for different starting altitudes, \alpha =90')
legend(legendInfo)                      % Set legends accoring to legend info

% Display results part 1
disp('State of Futten when passing earth depending on starting height: ')

%% Part 2 Find H*, H when Futten just passes earth

% Bisection method to determine critical starting height, H_star, when 
% trajectory just passes earth.
H_star = bisection_meth(@RKeval, 3, 6, 40, 0.05, 0, h, c1)
% Evaluate trajectory for H_star
check = 1; % Enable accuracy check
[u_t_star, t_pass, r_pass, phi_pass, phi_dot_pass] = RKeval(h, H_star, c1);
% Test convergence of RK method
h2 = h*2;
[u_t_star2, t_pass2, r_pass2, phi_pass2] = RKeval(h2, H_star, c1);
RK_err = abs(r_pass-r_pass2);
% Calculate trajectory length
traj_length = arclength(u_t_star)
figure()
r_path = u_t_star(:,1); phi_path = u_t_star(:,3); % Extract path info
polar(phi_path, r_path,'r')
title('Trajectory at critical H, \alpha =90')
view([90 -90])
hold on;
phi_earth = 0:1/(length(r_path))*360:360;
r_earth = ones(1,length(r_path)+1);
polar(phi_earth,r_earth,'b')
legend('Trajectory','Earth')
pass_speed = phi_dot_pass;


%% Part 3 Find H* for different alphas

H_star_alpha = [];
alpha_list = [];
pass_speed_list = [];
for alpha = [70:10:130]
    check = 0;
    c1 = [const alpha];
    H_alpha = bisection_meth(@RKeval, 3, 6, 40, 0.001, 0, h, c1);
    H_star_alpha = [H_star_alpha H_alpha];
    alpha_list = [alpha_list alpha];
    [u_t3, t_pass3, r_pass3, phi_pass3, phi_dot_pass3] = RKeval(h, H_alpha, c1);
    pass_speed_list = [pass_speed_list phi_dot_pass3];
end

%%

err_tot=RK_err+0.001 %för vilket H som vi passerar med

velocityerror=r_err*phi_err %+- this lies our velocityerror

traj_error= 5.2075-traj_length

T=u_t_star(:,5);
Radie=u_t_star(:,1);
Theta_star=u_t_star(:,3);
X=Radie.*sin(Theta_star);
Y=Radie.*cos(Theta_star);

grad=2;
for a=1:grad+1                  %constructing the matrix A of T(t)=R
   A(:,a)=T.^(grad+1-a);
end                            %least square to solve R as a function of T
 ;
 AT=A'*A;
 b=A'*Y;
 c=AT\b;
for a=1:grad+1
    g(a)=c(a)*(grad+1-a);       %derivate R as a polynom
end




figure()
plot (u_t_star(:,5),u_t_star(:,1))
grid on
hold on
x_range=[0:0.0001:u_t_star(end,5)];
y_range=polyval (c,x_range);
plot (x_range,y_range,'r');
legend('Values from RK','Values from polynom')
title ('interpolated polynom versus RK values')
xlable =('t [h]')
ylable =('r [earth radii]');



