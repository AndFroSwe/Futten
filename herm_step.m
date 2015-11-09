function [xpos, v, phi] = herm_step(bana, n, k)

points = 100*k;
xpos = [];
v = [];
phi=[];
x1 = bana.t(n);
x2 = bana.t(n + 1);


for i = 1:points
    x = x1 + (x2-x1)*i/points;
    p = herm(    x,...
                    [x1, x2],...
                    [bana.r(n), bana.r(n + 1)],...
                    [bana.rdot(n), bana.rdot(n + 1)]);
    p2= herm(    x,...
                    [x1, x2],...
                    [bana.phi(n), bana.phi(n + 1)],...
                    [bana.phidot(n), bana.phidot(n + 1)]);         

    v = [v p];
    phi=[phi,p2];
    xpos = [xpos x];
end

