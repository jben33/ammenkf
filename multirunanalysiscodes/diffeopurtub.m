x=linspace(0,1,length(u(20,:)))
y=u(20,:)
diffeo=0.2*sin(x).*sin(2*pi*x)
plot(difeo)
x2=x-diffeo

plot(x,y)
hold on 
plot(x2,y)