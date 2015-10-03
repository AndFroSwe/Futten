function [phi_dot_pass] = quadinterpol_phidot(phi_dot,T, t_pass)
% Uses quadratic interpolation to find when and where the r'=0 and thereby
% calculate the status in this point through linear interpolation.
% Input(u_t, matrix which consist of all intresting parameters (u) from main program) 
% Output[Vector with end values, Passing speed]
%% Create matrix and vectors
global check phi_dot_err

degree = 2;
% Create A-matrix
for j = 1:length(T)
    for i = 1:(degree + 1);
        A(j,i) = T(j)^(degree+1-i); 
    end
end
 AT=A'*A;
 b=A'*phi_dot;
 c=AT\b;
 

phi_dot_pass = polyval(c,t_pass) ;

if check == 1
    % Plot interpolated 2nd degree polynomial against actual points from RK.
    % Used to determine accuracy.
    figure
    % Plot polynomial
    x_range = T(1):1/10000:T(end);
    y_range = polyval(c,x_range);
    plot(x_range, y_range,'b')
    hold on; grid on;
    plot(T, phi_dot, 'rx')
    title('phi^(dot) as function of t')
    xlabel('t [h]')
    ylabel('phi^(dot) [rad] ')
    legend('Interpolated polynomial','Points')
    phi_dot_err = abs(phi_dot(end)-phi_dot(end-1));
end

    
end

