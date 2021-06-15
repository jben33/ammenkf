fsize=25;
line_color;
figure('Name',strcat(plotfolder,'/snapshot',sprintf('%02d',i)),'DefaultAxesFontSize',fsize)
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Units', 'inches', 'OuterPosition', [0.5, 0.5, 20, 10]);
hold on
p1 = plot(true_mesh,u(i*s+1,:));
p1.Color = cblk{1}; p1.Marker='x'; p1.LineWidth=5;
%p2 = scatter(obs_locs{i},obs_vals{i},120,'k','filled');
p2 = plot(obs_locs{i}(:),obs_vals{i}(:),'o');
p2.MarkerSize=15; p2.MarkerEdgeColor=cblk{1}; p2.MarkerFaceColor=cblk{3};
for j=1:N_ens:N_ens
    len = length(temp{j})/2;
    p3 = plot(fc_full(j,N+1:2*N),fc_full(j,1:N));
    p3.Color = cblu{2}; p3.Marker='o'; p3.LineWidth=3;
    p3.MarkerSize=15; p3.MarkerEdgeColor=cblu{3}; p3.MarkerFaceColor=cblu{2};
    p4 = plot(an_full(j,N+1:2*N),an_full(j,1:N));
    p4.Color = cred{2}; p4.Marker='o'; p4.LineWidth=3;
    p4.MarkerSize=15; p4.MarkerEdgeColor=cred{3}; p4.MarkerFaceColor=cred{2};
    p5 = plot(temp{j}(len+1:2*len),temp{j}(1:len));
    p5.Color = cblu{3}; p5.Marker='s'; p5.LineWidth=3;
    p5.MarkerSize=8; p5.MarkerEdgeColor=cblu{3}; p5.MarkerFaceColor=cblu{3};
    p6 = plot(fc{j}(len+1:2*len),fc{j}(1:len));
    p6.Color = cred{3}; p6.Marker='s'; p6.LineWidth=3;
    p6.MarkerSize=8; p6.MarkerEdgeColor=cred{3}; p6.MarkerFaceColor=cred{3};
end

hold off
xlim([left right])
ylim([-.5 1.5]) % BGM
ylim auto % KSM
xlabel('z')
ylabel('u')
title(['Time = ' num2str(da_times(i+1))],'FontSize',25)
lg = legend([p1,p2,p5,p3,p4,p6],'Truth','Observations','Forecast on AMM', 'Forecast on RFM','Analysis on RFM', 'Analysis on AMM');
lg.FontSize = 4*fsize/5;
lg.Location='best';
lg.Box='off';
grid on;
