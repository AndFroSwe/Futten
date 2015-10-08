function [r_out]=futt_extra(h, H)
%FUTTEN_EXTRA the most advanced function in the world. it is the "utvidgning" of Futten
%wrapping RKeval to evaluate H, Futten_pass evaluates the passing values
%for H.

trajectory=RKeval(h,H);
trajectory_pass=futten_pass(trajectory);
r_out=trajectory_pass.r_pass-1; %needs to be aiming for zero for the root finding method.

