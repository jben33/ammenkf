for i=500
j=22;
resol='HRA'
vars=[stsall(i,15).(resol)]
kurts=[stsall(i,16).(resol)]
rmses=[stsall(i,17).(resol)]
anrmses=[stsall(i,6).(resol)]
fileprefix='EX'

mems=[stsall(i,23).(resol){j}] % 22 for forcast 23 for analysis
size(mems)
inf=round([stsall(i,2).(resol)],2)
jit=round([stsall(i,3).(resol)],2)
theone=kurts(j,:)==min(kurts(j,:));

for g=1:length(theone)
    if(theone(g)==1)
        thisone=g;
    end
end
for ii=thisone
    %subplot(1,2,1)

  
    plot(mems(ii,101:200), u_at(da_times(j),mems(ii,101:200)),'LineWidth',3,'Color',[0,0,0])
    hold on
    plot(mean(mems(:,101:200)),mean(mems(:,1:100)),'--','LineWidth',3,'Color',[1,0,0])
    hold on
    plot(mems(ii,101:200),mems(ii,1:100),'LineWidth',2,'Color',[0,0,1])
    xlabel('z')
    ylabel('u')
    
    keystr=strcat('Infation:',{' '},num2str(inf),{'   '},'Jitter:',{' '},num2str(jit),{'   '},'Member Variance:',{' '},num2str(vars(j,ii)),{'    '},'Member Kurtosis:',{' '},num2str(kurts(j,ii)),{'   '},'Member RMSE:',{' '},num2str(rmses(j,ii)),{'   '},'Mean RMSE:',{' '},num2str(anrmses))
    dim = [0 0 .25 .6];
    colnames={'Inflation';'Jitter';'Member Variance';'Member Kurtosis';'Member RMSE';'Average RMSE'}
    Inflation=round(inf,-2);
    Jitter=round(jit,-2);
    Variance=vars(j,ii);
    Kurtosis=kurts(j,ii);
    ENS_RMSE=rmses(j,ii);
    AVG_RMSE=anrmses;
  %  subplot(2,2,1)
  %  T=table(Inflation,Jitter,Variance,Kurtosis,ENS_RMSE,AVG_RMSE);
   % uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,...
    %'RowName',T.Properties.RowNames,'Units', 'Normalized', 'Position',[.3, .8, .529, .09]);
   dim = [.55 .0 .3 .3];
   %dim= [0.18 0.03 .2 .2];
   str1 = strcat('Average RMSE=',num2str(anrmses));
   param=[stsall(:,4).(resol)]==50;
   str2 = strcat('Optimal RMSE=',num2str(min([stsall(param,6).(resol)])));
   s3=strcat('$\sigma_{ens}=$',num2str(vars(j,ii)))
   s4=strcat('$k_{ens}=$',num2str(kurts(j,ii)))
   s5=strcat('$RMSE_{ens}=$',num2str(rmses(j,ii)))

   %annotation('textbox',dim2,'String',str2,'FitBoxToText','on');
%txt={strcat('Average RMSE=',num2str(anrmses)),strcat('Optimal RMSE=',num2str(min([stsall(:,6).(resol)])))};
%text(0.55,0.2,txt,'FontWeight','bold','FitBoxToText','on')
   title(strcat(model,{' '},'\alpha=',num2str(inf),{' '},{'\alpha_J='},num2str(jit),{' '},'Time=',num2str(da_times(j)),'sec'))
   set(gca,'FontSize',14)
  % legend({'Truth','Analysis Mean','Typical Ensemble Member'},'Location','north','Orientation', 'horizontal','FontSize',10)
   legend({'Truth','Analysis Mean','Typical Ensemble Member'},'Location','northwest','FontSize',10)

   %annotation('textbox',dim,'String',{str1,str2},'FitBoxToText','on','LineWidth',3,'EdgeColor',[1,0,0],'FontWeight','bold');
   annotation('textbox',[.3 0.01 .3 .3],'String',{resol,s3,s4,s5},'FitBoxToText','on','LineWidth',3,'EdgeColor',[1,0,0],'FontWeight','bold','interpreter','latex');

   saveas(gcf,strcat(fileprefix,'_',resol,'_',num2str(ii),'_',num2str(jit),'_',num2str(inf),'.eps'),'epsc')
      saveas(gcf,strcat(fileprefix,'_',resol,'_',num2str(ii),'_',num2str(jit),'_',num2str(inf),'.fig'))

   %pause
   %close all
end
hold off
% em=vars(20,:)==max(vars(20,:))
% em=kurts(20,:)==min(kurts(20,:))
% em=rmses(20,:)==max(rmses(20,:))
%figure
figure('units','normalized','outerposition',[0 0 1 1])
em=20
p1=plot((mems(:,101:200)),(mems(:,1:100)),'LineWidth',5,'Color',[0,0,1])
hold on
p2=plot((mems(em,101:200)),(mems(em,1:100)),'LineWidth',4,'Color',[1,0,0])
xlabel('z')
ylabel('u')
s1=strcat('\alpha_J=',num2str(jit))
s2=strcat('\alpha=',num2str(inf))
legend([p1(1) p2(1)],{'All members','Single Member'},'Location','best')
set(gca,'FontSize',24)
annotation('textbox',[.2 .2 .1,.6],'String',{resol,s1,s2},'FitBoxToText','on','LineWidth',3,'EdgeColor',[1,0,0],'FontWeight','bold','FontSize',24);
title(strcat(model,{'  '},'Variance and Ensemble Member Example'))

saveas(gcf,strcat('Inherent','_',resol,'_',num2str(em),'_',num2str(jit),'_',num2str(inf),'.eps'),'epsc')
saveas(gcf,strcat('Inherent','_',resol,'_',num2str(em),'_',num2str(jit),'_',num2str(inf),'.fig'))
close all
end