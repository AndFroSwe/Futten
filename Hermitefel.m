function [] = Hermitefel(H)
% HERMITFEL plots error estimations from Hermite interpolation

% Define parameters
h = 0.01;
u = [H 0 0 0];
bana_big = RKeval(h*2, H);
bana_small = RKeval(h, H);

x1 = [];
y1 = [];
x2 = [];
y2 = [];

% Get interpolation for 2*h
for n = 1:length(bana_big.t) - 1 
    [x, y] = herm_step(bana_big, n);
    x1 = [x1 x];
    y1 = [y1 y];
    hold on
end

% Get interpolation for h
for n = 1:length(bana_small.t) - 1 
    [x, y] = herm_step(bana_small, n);
    x2 = [x2 x];
    y2 = [y2 y];
    hold on
end

figure()
% Plot full 
plot(x1,y1)
hold on
plot(x2,y2)
grid on
leg_big = sprintf('h=%0.3f', 2*h);
leg_small = sprintf('h=%0.3f', h);
title('Bana stycvis interpolerad med Hermite-interpolering')
legend({leg_big, leg_small})
xlabel('x [m]')
ylabel('y [m]')
hold off

% Assess error from plot
fprintf('Relativt fel bedöms ur från avstånd mellan linjer: %f*10^-6\n', (abs(y1(end-1)-y2(end-1)))/y2(end-1)*1e6)
