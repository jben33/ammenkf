line_color;
fsize=25;
figure('Name',strcat(plotfolder,'/snapshot',sprintf('%02d',i)),'DefaultAxesFontSize',fsize)
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Units', 'inches', 'OuterPosition', [0.5, 0.5, 20, 10]);
hold on
for j=1:N_ens
    len = length(temp{j})/2;
    scatter(temp{j}(len+1:2*len),temp{j}(1:len),'b','filled');
    scatter(fc{j}(len+1:2*len),fc{j}(1:len),'r','filled');
end
p3 = plot(fc_means(i+1,N+1:2*N),fc_means(i+1,1:N));
    p3.Color = cblu{1}; p3.Marker='o'; p3.LineWidth=3;
    p3.MarkerSize=15; p3.MarkerEdgeColor=cblu{3}; p3.MarkerFaceColor=cblu{2};
p4 = plot(an_means(i+1,N+1:2*N),an_means(i+1,1:N));
    p4.Color = cred{1}; p4.Marker='o'; p4.LineWidth=3;
    p4.MarkerSize=15; p4.MarkerEdgeColor=cred{3}; p4.MarkerFaceColor=cred{2};
p1 = plot(true_mesh,u(i*s+1,:));
p1.Color = cblk{1}; p1.Marker='x'; p1.LineWidth=5;
p2 = plot(obs_locs{i}(:),obs_vals{i}(:),'o');
p2.MarkerSize=15; p2.MarkerEdgeColor=cblk{1}; p2.MarkerFaceColor=cblk{3};
hold off
xlim([left right])
ylim([-.5 1.5]) % BGM
ylim auto % KSM
xlabel('z')
ylabel('u')
title(['Time = ' num2str(da_times(i+1))],'FontSize',25)
lg = legend([p1,p2,p3,p4],'x^t','Obs','{\mu}^f','{\mu}^a');
lg.FontSize = 4*fsize/5;
lg.Location='best';
lg.Orientation='Horizontal';
lg.Box='off';
grid on;
