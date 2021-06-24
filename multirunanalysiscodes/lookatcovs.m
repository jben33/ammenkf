clear sp
k=401
resol='HRA'
lx1=101
lx2=200
ly1=1
ly2=100
for i=10:10
mems=[stsall(k,23).(resol){i}(:,1:200)];
size(mems,1)
stsall(k,2).(resol)
stsall(k,3).(resol)

%zcov=cov(mems)%cov(mems(:,101:200))
em=(mems-repmat(mean(mems),size(mems,1),1))';
ee=(1/(sqrt(size(mems,1)-1)))*(em*em');
% 
imagesc((ee(lx1:lx2,ly1:ly2)))
 colorbar
xlabel('node locations')
ylabel('physical variables')
 set(gca,'FontSize',16)
 
 figure
subplot(2,1,1)
imagesc((ee(lx1:lx2,ly1:ly2)))
if(strcmp(resol, 'HR'))
 imagesc((ee(1:100,1:100)))
end
colorbar('Location','northoutside')
xlabel('node locations')
ylabel('physical variables')
set(gca,'FontSize',16)
title('Covariance: Physical Values vs Node Locations')
subplot(2,1,2)
yyaxis left
plot(mean(mems(:,101:200)),gradient(mean(mems(:,ly1:ly2)),mean(mems(:,101:200))),'LineWidth',2)
xlabel('z')
%ylabel({'$\partial_{x} \{bf \bar{u}^{\rm f}}$'},'Interperter','latex')
ylabel({'$\partial_x \bar{u}^f$'},'Interpreter','latex')
%plot(mean(mems(:,101:200)),mean(mems(:,ly1:ly2)),'LineWidth',2)
yyaxis right
plot(mean(mems(:,101:200)),diag(ee(lx1:lx2,ly1:ly2)),'LineWidth',2)
ylabel({'$\sigma_{u_i z_i}$'},'Interpreter','latex')
if(strcmp(resol, 'HR'))
yyaxis left
plot(mean(mems(:,1:100)),'LineWidth',2)
yyaxis right
plot(diag(ee(1:100,1:100)),'LineWidth',2)
end
if(strcmp(model, 'KSM'))
    xlim([0 2*pi])
end
set(gca,'FontSize',16)
%legend('Forecast Mean','$\sigma_{u_{j}z_{j}}$','Location','best')
%legend('Gradient of Forecast Mean','Covariances,Physical vs Node locations','Location','best')
legend([{'$\partial_x \bar{u}^f$'},{'$\sigma_{u_i z_i}$'}],'Interpreter','latex')
title('Spatial Gradient and Covariance Diagonal')
%axis equal
% figure
% imagesc((ee(101:200,101:200)))
% colorbar
%colormap(jet)
 pause
 close
sp(i-1)=trace(ee);
 end

% plot(sp)

% for i=1:41
%    % mems=[stsall(1,23).HR{i}];
%     %subplot(1,2,1)
%     imagesc(histeq(EANHRA(:,:,i)))
%      %subplot(1,2,2)
%     %imagesc(histeq(EANHRA(:,:,i)))
%     pause
% end