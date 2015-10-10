function [x y]=euklid(R, phi)
% EUKLID makes polar to euklidian space

y=R.*sin(phi)
x=R.*cos(phi)

