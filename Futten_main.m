% Projektarbete "Rymdskeppet Futten illa ute"
% Andreas Fröderberg & Henrik Hvitfeldt
close all; clear all; clc;
%% Declare variables
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
    trajectory.H=H;
    trajectories(i) = trajectory;
    % Plot trajectory
    polar(trajectory.phi, trajectory.r, plotStyle{i})                      % Plot tracectory
    view([90 -90])                      % Flip plot to 0 deg up
    grid on; hold all;
    legendInfo{i} = ['Starting height ' num2str(H) ' earth radii'];       % Add legend info for use in legend command   
end
title ('Trajectories for different starting altitudes, \alpha =90')
legend(legendInfo)                      % Set legends accoring to legend info

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
start1=3; %first start value for bisection method
start2=6; %second startvalue for bisection method
start=[start1 start2];

H_star = bisection_meth(@futt_extra, start, h)
% Evaluate trajectory for H_star
trajectory_star = RKeval(h, H_star);
trajectory_star = futten_pass(trajectory_star)

%%
% Calculate trajectory length
traj_length=arclength(trajectory_star.t,0,trajectory_star.r,h) %distance traveled
%%
figure()
polar(trajectory_star.phi, trajectory_star.r,'r')
title('Trajectory at critical H, \alpha =90')
view([90 -90])
hold on;
phi_earth = 0:1/(length(trajectory_star.r))*360:360;
r_earth = ones(1,length(trajectory_star.r)+1);
polar(phi_earth,r_earth,'b')
legend('Trajectory','Earth')
pass_speed = trajectory_star.v_pass;
%% least square and length
figure()
%[x y]=euklid(trajectory_star.r,trajectory_star.phi)

var=trajectory_star.t %trajectory_star.t %

plot (var, trajectory_star.r)
hold on
 grad=4;
 [C dC]=least_square(var,trajectory_star.r,grad); %C=poly coeffs, dC=derivate


 plot (var,polyval(C,var))
hold on
 plot (var,polyval(dC,var))
leastsquare_length=arclength(var,C,0,h)

%% Part 3 Find H* for different alphas

H_star_alpha = [];
alpha_list = [];
pass_speed_list = [];
for alpha = [70:10:130]
    H_alpha = bisection_meth(@futt_extra, start, h);                  %optimal height for different alpha
    H_star_alpha = [H_star_alpha; H_alpha];                     %list of optimal heights
    alpha_list = [alpha_list alpha];                            %alpha list
    trajectory_star_alpha=RKeval(h,H_alpha);                    %calculates the passing curve
    trajectory_pass_alpha=futten_pass(trajectory_star_alpha);    %calculates the passing paramaters for above curve
    pass_speed_list = [pass_speed_list trajectory_pass_alpha.v_pass]; %corresponding speed of angle 70:10:130
end

%%
alpha = 90;
error_vektor=[];
no_of_tests = 5;

% Loop for different step length
for a=0:no_of_tests
    h_test = h*2^a;
    fprintf('h = %f\n', h_test)
    trajectory_error=RKevalerror(h_test, H_star,2);

    trajectories_err(a+1) = trajectory_error;

   end_value=[ trajectory_error.r(end),...
               trajectory_error.rdot(end),...
               trajectory_error.phi(end),...
               trajectory_error.phidot(end)];
   error_vektor=[error_vektor;end_value];
end

%konvergenskoll
delta_r = abs(diff(error_vektor(:,:)))
kvot = []
for i=0:(length(delta_r(:,1)) - 2)
   kvot(i + 1) = delta_r(end - i,1)/delta_r(end - i - 1,1)
end

%%

 figure()
% plot (u_t_star(:,5),u_t_star(:,1))
% grid on
% hold on
% x_range=[0:0.0001:u_t_star(end,5)];
% y_range=polyval (c,x_range);
% plot (x_range,y_range,'r');
% legend('Values from RK','Values from polynom')
% title ('interpolated polynom versus RK values')
% xlable =('t [h]')
% ylable =('r [earth radii]');
%trajectory_error=RKevalerror(h,H_star,1.671999999);
%plot (trajectory_error.t,trajectory_error.r)
%hold on

