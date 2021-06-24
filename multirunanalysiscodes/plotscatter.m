
x=[sts(:,2).HRA]'
y=[sts(:,3).HRA]'
z=[sts(:,5).HRA]'
%scatter(x,y,[],z)
%[X,Y]=meshgrid(x,y);
%contour3(X,Y,z)
% [x, xi]=sort(x)
% y=y(xi)
% z=z(xi)
interpolant=scatteredInterpolant(x,y,z)
xl=linspace(1,1.6,length(x))
yl=linspace(0,0.1,length(y))
[xx,yy]=meshgrid(xl,yl);
Z=interpolant(xx,yy);
contourf(xx,yy,Z)
%interp2(x,y,z,[1:0.01:1],[0:0.01:0.1])


% figure;
% x=[sts(:,2).HR]
% y=[sts(:,3).HR]
% z=[sts(:,5).HR]
% scatter(x,y,[],z)
%contourf(x,y,z)