%load('FIG/BGM_LAG_AMM53/output_HRA.mat')
load(strcat('FIG/',model,'_',otype,'_',ename,expno,'/','output_',resol,'.mat'))
fsize=25;
line_color;
figure('Name', strcat(plotfolder,'/compare_experiment'),'DefaultAxesFontSize',fsize)
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Units', 'inches', 'OuterPosition', [0.5, 0.5, 20, 10]);
hold on;
grid on;

for ii=1:40 
 obs_num(ii) = size(obs_locs{ii}, 2);
end
size(obs_num)

xlabel('t')
p(1).rmse = plot(da_times, forecast(1).rmse, 'Color', cblu{2}, 'LineWidth', 6);
p(2).rmse = plot(da_times, forecast(2).rmse, 'Color', cblu{1}, 'LineWidth', 6);
p(3).rmse = plot(da_times, analysis(1).rmse, 'Color', cred{2}, 'LineWidth', 6);
p(4).rmse = plot(da_times, analysis(2).rmse, 'Color', cgrn{1}, 'LineWidth', 6);
%[ p(4).vaxis, p(4).rmse, p(4).numobs ] = plotyy(da_times, analysis(2).rmse, da_times, [10  obs_num]);
p(5).eobs = plot(da_times, sqrt(obs_var)*ones(1,size(da_times,2)),'k-.', 'LineWidth', 5);
% set(p(4).vaxis,{'ycolor'},{'k';cblk{3}});
% ylabel(p(4).vaxis(1),'RMSE');
% ylabel(p(4).vaxis(2),'d^{LAG}_{obs}');
% set(p(4).rmse, 'Color', cred{1}, 'LineWidth', 6);
% set(p(4).numobs,'LineStyle','-.', 'Color', cblk{3}, 'LineWidth', 6);

%p(1).sdev = plot(da_times, forecast(1).sdev, '-.', 'Color', cgrn{1}', 'LineWidth', 3);
%p(2).sdev = plot(da_times, forecast(2).sdev, '-.', 'Color', cgrn{2}, 'LineWidth', 3);
%p(3).sdev = plot(da_times, analysis(1).sdev, '-.', 'Color', cblk{3}, 'LineWidth', 3);
%p(4).sdev = plot(da_times, analysis(2).sdev, '-.', 'Color', cblk{2}, 'LineWidth', 3);
% 
% lg = legend([p(:).rmse p(5).eobs p(4).numobs ], ...
%         strcat('RMSE_f', '^{', analysis(1).obs, '}'), ...
%         strcat('RMSE_f', '^{', analysis(2).obs, '}'), ...
%         strcat('RMSE_a', '^{', forecast(1).obs, '}'), ...
%         strcat('RMSE_a', '^{', forecast(2).obs, '}'),  ...
%         strcat('\sigma_o'), strcat('d^{LAG}_{obs}')  ...
% );
%        strcat('{\sigma}_{f}', '^{', analysis(1).obs, '}'), ...
%        strcat('{\sigma}_{f}', '^{', analysis(2).obs, '}'), ...
%        strcat('{\sigma}_{a}', '^{', forecast(1).obs, '}'), ...
%        strcat('{\sigma}_{a}', '^{', forecast(2).obs, '}')  ...


lg.Box = 'on';
lg.Location='NorthOutside';
lg.FontSize = 6/5*fsize;
lg.Orientation = 'Horizontal';
