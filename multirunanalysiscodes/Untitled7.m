

for k=1:10

for i=1:N_ens
plot(sts(k,16).HRA(2:41,i))
hold on
end
saveas(gcf,strcat(num2str(k),'.png'))
hold off
end