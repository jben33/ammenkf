figure('Name',strcat(plotfolder,'/snapshot',sprintf('%02d',i)),'DefaultAxesFontSize',25)
hold on
for j=1:N_ens
    len = length(temp{j})/2;
    scatter(temp{j}(len+1:2*len),temp{j}(1:len),'g','filled');
    scatter(fc{j}(len+1:2*len),fc{j}(1:len),'r','filled');
end
p3 = plot(fc_means(i+1,N+1:2*N),fc_means(i+1,1:N),'g-','Linewidth',5);
p4 = plot(an_means(i+1,N+1:2*N),an_means(i+1,1:N),'r-','Linewidth',5);
p1 = plot(true_mesh,u(i*s+1,:),'b-','Linewidth',5);
p2 = scatter(obs_locs{i},obs_vals{i},120,'k','filled');
hold off
xlim([left right])
ylim auto % KSM
ylim([-.5 1.5]) % BGM
xlabel('z')
ylabel('u')
title(['Forecast and Analysis Ensembles at Time = ' num2str(da_times(i+1))],'FontSize',15)
lg = legend([p1],'Free run');
lg.FontSize=15;
lg.Location='best';
