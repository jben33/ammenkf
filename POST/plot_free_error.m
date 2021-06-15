fsize=25;
figure('Name', strcat(plotfolder,'/',model,'_',resol,'_error_evolution'),'DefaultAxesFontSize',fsize)
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Units', 'inches', 'OuterPosition', [0.5, 0.5, 20, 10]);
hold on
p1 = plot(da_times,an_rmse);
p1.Color = [.2 .2 .2]; p1.LineWidth=5;
p2 = plot(da_times(1:num_steps+1),an_cov_trace.^0.5);
p2.Color = [.2 .2 .2]; p1.LineWidth=5;
p2.MarkerSize=15; p2.MarkerEdgeColor='black'; p2.MarkerFaceColor=[0.1 0.1 0.1];
ylim([0 4]) % KSM
ylim auto
ylim([0 .4]) % BGM
xlabel('t')
ylabel('RMSE')
%title('Forecast and Analysis Error and Spread')
lg = legend(p1, strcat('Free-Run(',resol,')'));
lg.FontSize = fsize;
lg.Location = 'best';
lg.Orientation = 'Horizontal';
