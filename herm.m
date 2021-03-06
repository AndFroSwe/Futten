function yut = herm(xq,x,y,k)
% HERM (xq,x,y,k)
x1=x(1);
x2=x(2);
y1=y(1);
y2=y(2);
k1=k(1);
k2=k(2);

h = x2-x1;

c1 = y1 ;
c2 = (y2-y1)/h;
c3 = (k2-c2)/h^2;
c4 = (k1-c2)/h^2;

yut = c1+c2*(xq-x1)+c3*(xq-x1)^2*(xq-x2)+c4*(xq-x1)*(xq-x2)^2;

          
end

