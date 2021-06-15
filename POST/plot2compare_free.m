fsize=25;
line_color;
figure('Name', strcat(plotfolder,'/',model,'_compare_HR_LR_free'),'DefaultAxesFontSize',fsize)
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Units', 'inches', 'OuterPosition', [0.5, 0.5, 20, 10]);
hold on;
grid on;

xlabel('t')

p(3).rmse = plot(da_times, analysis(1).rmse, 'Color', cblu{3}, 'LineWidth', 6);
p(4).rmse = plot(da_times, analysis(2).rmse, 'Color', cblu{2}, 'LineWidth', 6);

p(3).sdev = plot(da_times, analysis(1).sdev, '-.', 'Color', cblu{3}, 'LineWidth', 3);
p(4).sdev = plot(da_times, analysis(2).sdev, '-.', 'Color', cblu{2}, 'LineWidth', 3);

lg = legend([p(:).rmse p(:).sdev], ...
        strcat('RMSE_f', '^{', analysis(1).res, '}'), ...
        strcat('RMSE_f', '^{', analysis(2).res, '}'), ...
        strcat('{\sigma}_{f}', '^{', analysis(1).res, '}'), ...
        strcat('{\sigma}_{f}', '^{', analysis(2).res, '}') ...
);

lg.Box = 'off';
lg.Location='NorthOutside';
lg.FontSize = 6/5*fsize;
lg.Orientation = 'Horizontal';
