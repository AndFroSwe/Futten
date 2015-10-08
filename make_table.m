function [] = make_table (trajectories)
% MAKE_TABLE (trajectory) prints the passing values of the trajectory

no_of_rows = 4;

% Loop adds all relevant values into struct
for i = 1:no_of_rows
    trajectory = trajectories(i);
    H(i, 1) = trajectory.H;
    t_pass(i, 1) = trajectory.t_pass; 
    r_pass(i, 1) = trajectory.r_pass;
    phi_pass(i, 1) = trajectory.phi_pass;
end

T = table(H, t_pass, r_pass, phi_pass);
disp('Passing values for Fnutten')
disp(T)
