line_color
fsize=25;
figure('Name', strcat(plotfolder,'/',model,'_',resol,'_error_evolution'),'DefaultAxesFontSize',fsize)
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Units', 'inches', 'OuterPosition', [0.5, 0.5, 20, 10]);
hold on
%p1 = plot(da_times,sqrt(obs_var)*ones(1,num_steps+1));
%    p1.Color = cblk{1}; p1.LineWidth=3;
%    p1.MarkerSize=15; p1.MarkerEdgeColor='black'; p1.MarkerFaceColor='black';
p2 = plot(da_times,fc_rmse);
    p2.Color = cblu{1}; p2.LineWidth=6;
    p2.MarkerSize=15; p2.MarkerEdgeColor=cblu{3}; p2.MarkerFaceColor=cblu{2};
p3 = plot(da_times,an_rmse);
    p3.Color = cred{1}; p3.LineWidth=6;
    p3.MarkerSize=15; p3.MarkerEdgeColor=cred{3}; p3.MarkerFaceColor=cred{2};
p4 = plot(da_times(1:num_steps+1),fc_cov_trace.^0.5);
    p4.Color = cblu{1}; p4.LineStyle = '-.'; p4.LineWidth=4;
    p4.MarkerSize=15; p4.MarkerEdgeColor=cblu{2}; p4.MarkerFaceColor=cblu{2};
p5 = plot(da_times(1:num_steps+1),an_cov_trace.^0.5);
    p5.Color = cred{1}; p5.LineStyle = '-.'; p5.LineWidth=4;
    p5.MarkerSize=15; p5.MarkerEdgeColor=cred{2}; p5.MarkerFaceColor=cred{2};
if (strcmp(model,'BGM'))
  ylim([0 .2]) % BGM
elseif (strcmp(model,'KSM')) 
  ylim([0 4.2]) % KSM
end
xlabel('t')
%title('Forecast and Analysis Error and Spread')
lg = legend('RMSE_f','RMSE_a','{\sigma}^2_f','{\sigma}^2_a');
lg.FontSize = fsize;
lg.Location='NorthEast';
lg.Orientation='Horizontal';
lg.Location = 'best';
lg.Box='off';
grid on;
