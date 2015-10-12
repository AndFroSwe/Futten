function [trajectory] = futten_pass(trajectory)
% FUTTEN_PASS (trajectory) calculates the different passing parameters
%r,phi,t,v using linear interpolation and hermit for when rdot equals zero
%i.e spaceship is heading to space again. 
RK_r_err = 1.0019e-6;
RK_phi_err = 9.061e-07;
RK_phidot_err = 8.2023e-07;
herm_relerr = 600e-6;

rdot_pass=0;
t_pass=linpol(trajectory.rdot(end-1:end),...
            trajectory.t(end-1:end),...
            rdot_pass);
r_pass=herm(t_pass,...
            trajectory.t(end-1:end),...
            trajectory.r(end-1:end),...
            trajectory.rdot(end-1:end));
phi_pass=herm(t_pass,...
            trajectory.t(end-1:end),...
            trajectory.phi(end-1:end),...
            trajectory.phidot(end-1:end));
phidot_pass=linpol(trajectory.rdot(end-1:end),...
            trajectory.phidot(end-1:end),...
            rdot_pass);
        
v_pass=phidot_pass*r_pass;
v_pass_err = linpol_err(trajectory.phidot) + phidot_pass*RK_phidot_err;
        
%add to struct
trajectory.t_pass=t_pass;
trajectory.t_err = linpol_err(trajectory.t);
trajectory.r_pass=r_pass;
trajectory.r_err = r_pass*(herm_relerr + RK_r_err);
trajectory.phi_pass=phi_pass;
trajectory.phi_err = phi_pass*(herm_relerr + RK_phi_err);
trajectory.v_pass=v_pass;
trajectory.v_err = v_pass_err;

