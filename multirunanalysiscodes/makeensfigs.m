%In What is loaded from loadthestuff.m resol is not loaded so subtract 1 from the indexes to get the quantity you wish to look at. 
%   sts(kk,1).(resol) = resol;
%   sts(kk,2).(resol) = xind(1);
%   sts(kk,3).(resol) = xind(2);
%   sts(kk,4).(resol)=xind(3);
% % %  sts(kk,3).(resol) = mean(fc_rmse((insize-1)/2:insize));
% % %  sts(kk,4).(resol) = mean(an_rmse((insize-1)/2:insize));
% % %  sts(kk,5).(resol) = mean(fc_cov_trace((insize-1)/2:insize).^0.5);
% % %  sts(kk,6).(resol) = mean(an_cov_trace((insize-1)/2:insize).^0.5);
% % 
% % %half interval first
%    sts(kk,5).(resol) = mean(fc_rmse(20:insize));
%    sts(kk,6).(resol) = mean(an_rmse(20:insize));
%    sts(kk,7).(resol) = mean(fc_cov_trace(20:insize).^0.5);
%    sts(kk,8).(resol) = mean(an_cov_trace(20:insize).^0.5);
%    sts(kk,9).(resol) = mean(fc_rmseD(20:insize));
%    sts(kk,10).(resol) = mean(an_rmseD(20:insize));
%    sts(kk,11).(resol) = mean(fc_cov_traceD(20:insize).^0.5);
%    sts(kk,12).(resol) = mean(an_cov_traceD(20:insize).^0.5);
%     sts(kk,13).(resol) = mean(fc_rmseH(20:insize));
%     sts(kk,14).(resol) = mean(an_rmseH(20:insize));
%     sts(kk,15).(resol)=Ean_vars;
%     sts(kk,16).(resol)=Ean_kurts;
%     sts(kk,17).(resol)=Ean_rmses;
%     sts(kk,19).(resol)=Efc_vars;
%     sts(kk,20).(resol)=Efc_kurts;
%     sts(kk,21).(resol)=Efc_rmses;



if strcmp(model,'KSM')
    inflim=0.5;
else
    inflim=0.1;
end
metricvalue='Average Member Kurtosis';
resol='HRA';
parameter='Ensemble Size';
vs=[20,30,50,70,90]; % EN size
fileprefix='ENS';
metric=20;
k=1;
for ii=vs
chosenone=ii;
chosenonestring=num2str(ii);
parameter='Ensemble Size';
vs=[20,30,50,70,90]; % EN size
fileprefix='ENS';
param=[stsall(:,4).(resol)]==chosenone; 
x=[stsall(param,2).(resol)];
y=[stsall(param,3).(resol)];
kk=1;
ahit=1;
if(metric>14)
for i=param
    if (i==1)
        zt=[stsall(ahit,metric).(resol)];
        ztavg(kk)=mean(mean(zt(20:41,:)));
         if (strcmp(resol,'HRA'))
             zot=[stsall(ahit,metric).HR];
             zotavg(kk)=mean(mean(zot(20:41,:)));
         else
             zot=[stsall(ahit,metric).HRA];
             zotavg(kk)=mean(mean(zot(20:41,:)));
         end
          
        kk=kk+1
    end
    ahit=ahit+1;
end
cmin=min(min(ztavg),min(zotavg));
cmax=max(max(ztavg),max(zotavg));

z=ztavg;
clear ztavg
clear zt
clear zot
else
z=[stsall(param,metric).(resol)]
end

if (metric==16 || metric==20)
 best=z==max(z)
else
best=z==min(z)
end
infHRA(k)=x(best)
jitterHRA(k)=y(best)
other(k)=chosenone
zHRA(k)=z(best)

interpolant=scatteredInterpolant(x',y',z');
xl=linspace(1,1.6,length(x));
yl=linspace(0,inflim,length(y));
[xx,yy]=meshgrid(xl,yl);
 Z=interpolant(xx,yy);
 figure

contourf(xx,yy,Z);
%surf(xx,yy,Z)
%view(2)
hold on
scatter(x,y,[],z,'filled')
hold on
if (metric==16 || metric==20)
    plot(infHRA(k),jitterHRA(k),'-bp','MarkerSize',18,'MarkerFaceColor',[0 0 1])
else
    plot(infHRA(k),jitterHRA(k),'-rp','MarkerSize',18,'MarkerFaceColor',[1 0 0])
end
colormap(jet)
c=colorbar;
c.Label.String=metricvalue;
caxis([cmin,cmax])
%caxis([min(min(xhra(param,metric)),min(xhr(param,metric))) max(max(xhra(param,metric)),max(xhr(param,metric))) ]);
%title(strcat(parameter,{' '},chosenonestring,{' '},model,{' '},resol))
title(strcat('N^{\rm e}','=',chosenonestring,{'  '},'I_{m}','=',num2str(init_emesh_size),{'  '},'\sigma_{o}','=',num2str(sqrt(obs_var)),{'  '},model,{' '},resol))
xlabel('{\bf \alpha}')
ylabel('{\bf \alpha_J}')
set(gca,'FontSize',14)
hold off
saveas(gcf,strcat(fileprefix,'_',resol,'_',num2str(ii),'.eps'),'epsc')
saveas(gcf,strcat(fileprefix,'_',resol,'_',num2str(ii),'.fig'))

k=k+1
end
