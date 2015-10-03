function yut = herm(x,x1,x2,y1,y2,k1,k2,name)
% Hermite interpolation
% Input(Point on x to find f(x), left side x, right side x, y corr to x1 ...
% ...y corr to x2, derivative in x1, derivative in x2)
% Output[Interpolated value]

global check phi_err r_err

h = x2-x1;

c1 = y1 ;
c2 = (y2-y1)/h;
c3 = (k2-c2)/h^2;
c4 = (k1-c2)/h^2;

yut = c1+c2*(x-x1)+c3*(x-x1)^2*(x-x2)+c4*(x-x1)*(x-x2)^2;

if check==1
    X = [x1 x2];
    Y = [y1 y2];
    figure
    plot(X,Y,'ro')
    hold on; grid on;
    plot(x,yut,'bo')
    title('Accuracy of Hermite interpol')
    legend('Point set', 'Interpolated point')
    xlabel('t [h]'); ylabel(name)
    if strcmp(name,'r')
        r_err = abs(y2-y1);
    elseif strcmp(name,'phi')
        phi_err = abs(y2-y1);
    end
        
end
          
end

