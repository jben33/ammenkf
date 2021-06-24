% for i=1:90
% plot(an_ensemble(i,101:200),an_ensemble(i,1:100))
% hold on
% plot(mean(an_ensemble(:,101:200)),mean(an_ensemble(:,1:100)),'LineWidth',3)
% hold on
% pause
% end
mem=[sts(1,23).HRA{30}]
for i=2:20

plot(mem(i,101:200),mem(i,1:100))
hold on
plot(mean(mem(:,101:200)),mean(mem(:,1:100)),'LineWidth',3)
hold on
pause
end