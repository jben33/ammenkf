
fsize=25;
line_color;
figure('Name', strcat(plotfolder,'/',model,'_compare_HR_LR_enkf'),'DefaultAxesFontSize',fsize)
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Units', 'inches', 'OuterPosition', [0.5, 0.5, 20, 10]);
hold on;
grid on;

xlabel('t')
p(1).rmse = plot(da_times, forecast(1).rmse, 'Color', cblu{3}, 'LineWidth', 6);
p(2).rmse = plot(da_times, forecast(2).rmse, 'Color', cblu{2}, 'LineWidth', 6);
p(3).rmse = plot(da_times, analysis(1).rmse, 'Color', cred{3}, 'LineWidth', 6);
p(4).rmse = plot(da_times, analysis(2).rmse, 'Color', cred{2}, 'LineWidth', 6);

p(1).sdev = plot(da_times, forecast(1).sdev, '-.', 'Color', cblu{3}', 'LineWidth', 3);
p(2).sdev = plot(da_times, forecast(2).sdev, '-.', 'Color', cblu{2}, 'LineWidth', 3);
p(3).sdev = plot(da_times, analysis(1).sdev, '-.', 'Color', cred{3}, 'LineWidth', 3);
p(4).sdev = plot(da_times, analysis(2).sdev, '-.', 'Color', cred{2}, 'LineWidth', 3);

p(5).eobs = plot(da_times, sqrt(obs_var)*ones(1,size(da_times,2)),'k-.', 'LineWidth', 5);

% if (strcmp(model,'BGM'))
%  ylim([0 0.1]);
% else
%  ylim([0 4.5]);
% end

%p(5)=plot(da_times, sqrt(obs_var)*ones(1,num_steps+1),':', 'LineWidth', 3);

lg = legend([p(:).rmse p(:).sdev], ...
        strcat('RMSE_f', '^{', forecast(1).res, '}'), ...
        strcat('RMSE_f', '^{', forecast(2).res, '}'),  ...
        strcat('RMSE_a', '^{', analysis(1).res, '}'), ...
        strcat('RMSE_a', '^{', analysis(2).res, '}'), ...
        strcat('{\sigma}_{f}', '^{', forecast(1).res, '}'), ...
        strcat('{\sigma}_{f}', '^{', forecast(2).res, '}'), ...
        strcat('{\sigma}_{a}', '^{', analysis(1).res, '}'), ...
        strcat('{\sigma}_{a}', '^{', analysis(2).res, '}') ...
);

lg.Box = 'off';
lg.Location='NorthOutside';
lg.FontSize = 6/5*fsize;
lg.Orientation = 'Horizontal';


