function [xpos, v] = herm_step(bana, n)

points = 100;
xpos = [];
v = [];
x1 = bana.t(n);
x2 = bana.t(n + 1);


for i = 1:points
    x = x1 + (x2-x1)*i/points;
    p = herm(    x,...
                    [x1, x2],...
                    [bana.r(n), bana.r(n + 1)],...
                    [bana.rdot(n), bana.rdot(n + 1)]);
%    p = LinPol(bana.y(n), bana.y(n + 1), x1, x2, x);
    v = [v p];
    xpos = [xpos x];
end

