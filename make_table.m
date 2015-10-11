function [] = make_table (trajectories)
% MAKE_TABLE (trajectory) prints the passing values of the trajectory

no_of_rows = 4;

% Loop adds all relevant values into struct
for i = 1:no_of_rows
    trajectory = trajectories(i);
    H(i, 1) = trajectory.H;
    t_pass(i, 1) = trajectory.t_pass; 
    t_err(i, 1) = trajectory.t_err;
    r_pass(i, 1) = trajectory.r_pass;
    r_err(i, 1) = trajectory.r_err;
    phi_pass(i, 1) = trajectory.phi_pass;
    phi_err(i, 1) = trajectory.phi_err;
    v_pass(i, 1) = trajectory.v_pass;
    v_err(i, 1) = trajectory.v_err;
end

T = table(H, t_pass, t_err, r_pass, r_err, phi_pass, phi_err);
disp('Passing values for Fnutten')
disp(T)
