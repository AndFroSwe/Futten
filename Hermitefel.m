function [] = Hermitefel(H)
% HERMITFEL 

% Define parameters
h = 0.01;
u = [H 0 0 0];
%bana_big = RKeval(h*2, H);
bana_small = RKeval(h, H);
bana_big = struct(  't',    bana_small.t(1:2:end),...
                    'r',    bana_small.r(1:2:end),...
                    'rdot', bana_small.rdot(1:2:end),...
                    'phi',  bana_small.phi(1:2:end),...
                    'phidot',   bana_small.phidot(1:2:end));

x1 = [];
y1 = [];
x2 = [];
y2 = [];
phi1=[];
phi2=[];

k = 2;
% Get interpolation for 2*h
for n = 1:length(bana_big.t) - 1 
    [x, y, phi] = herm_step(bana_big, n, k);
    x1 = [x1 x];
    y1 = [y1 y];
    phi1=[phi1 phi];
    hold on
end

k = 1;
% Get interpolation for h
for n = 1:length(bana_small.t) - 1 
    [x, y, phi] = herm_step(bana_small, n, k);
    x2 = [x2 x];
    y2 = [y2 y];
    phi2=[phi2 phi];
    hold on
end

err_abs = max(abs(y1 - y2));
ind = find(max(abs(y1 - y2)) == err_abs);
err_rel = err_abs/y1(ind);


fprintf('Hermitefel %fe-6\n', err_rel*1e6)