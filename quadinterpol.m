function [T0] = quadinterpol(R,T)
% Uses quadratic interpolation to find when and where the r'=0 and thereby
% calculate the status in this point through linear interpolation.
% Input(u_t, matrix which consist of all intresting parameters (u) from main program) 
% Output[Vector with end values, Passing speed]
%% Create matrix and vectors
global check t_err

grad=2;
for a=1:grad+1                  %constructing the matrix A of T(t)=R
   A(:,a)=T.^(grad+1-a);
end                            %least square to solve R as a function of T
 y=R;
 AT=A'*A;
 b=A'*y;
 c=AT\b;
for a=1:grad+1
    g(a)=c(a)*(grad+1-a);       %derivate R as a polynom
end
b=(g(1:grad));
T0=roots (b);                  %time where R'=0    

if check == 1
    % Plot interpolated 2nd degree polynomial against actual points from RK.
    % Used to determine accuracy.
    figure
    % Plot polynomial
    x_range = T(1):1/10000:T(end);
    y_range = polyval(c,x_range);
    subplot(1,2,1)
    plot(x_range, y_range,'b')
    hold on; grid on;
    % Plot points
    plot(T, R, 'rx')
    title('Points vs interpolation, r(t)')
    legendInfo = {['Interpolated polyn: ' num2str(c(1)) 'x^2+' num2str(c(2)) 'x+' num2str(c(3))]};
    legend(legendInfo, 'Points') %'x^2+' num2str(c(2)) 'x+' num2str(c(3)),'Points')
    xlabel('t [h]')
    ylabel('r [Earth radii]')
    % Zoom in on turning point
    subplot(1,2,2)
    % PLot polynomial
    plot(x_range, y_range,'b')
    % Set apprpriate axis
    axis([2.99 2.995 1 1.0001])
    hold on; grid on;
    % Plot points
    plot(T, R, 'rx')
    title('Points vs interpolation, r(t), zoomed in')
    % legendInfo = {['Interpolated polyn: ' num2str(c(1)) 'x^2+' num2str(c(2)) 'x+' num2str(c(3))]};
    % legend(legendInfo, 'Points') %'x^2+' num2str(c(2)) 'x+' num2str(c(3)),'Points')
    xlabel('t [h]')
    ylabel('r [Earth radii]')
    % Error in est of t as the span of last 2 points
    t_err = abs(T(end)-T(end-1));
end


end

