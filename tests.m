% Get RK4 errors 
close all, clear all, clc
h = 0.001;
H = 5;      % Starting height
alpha = 90; % Degrees
no_tests = 10;

vals = [];
for i = 1:no_tests
    val = RK4(h*i, H, alpha);
    vals = [vals; val];
end



