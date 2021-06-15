
fsize=30;
line_color;

load('FIG/KSM_EUL_AMM21/output_LR_N_ens.mat')
fname=strcat(plotfolder,'/',model,'_error_',labelt);

sta = sts;
load('FIG/KSM_EUL_AMM21/output_LR_N_ens_50_90.mat')
f = figure('Name',fname,'DefaultAxesFontSize',fsize);

set(gcf, 'Units', 'Inches', 'Position', [0, 0, 30, 10], 'PaperUnits', 'Inches', 'PaperPosition', [0 0 30 10])

%% First panel
s1 = subplot(1,3,1, 'Position', [0.05, 0.1, 0.3, 0.83]);
set(gca,'GridAlpha',.2, 'XTick',round([sta(2,2).LR sts(:,2).LR],2))
grid on; hold on;
xlim([20 90]);  ylim([0 2]); ylim([0.004 0.0155]);
ylim([0 1.5]);
xlabel(labelx); fld = fieldnames(sts);
s1.XColor='[0 0 0]'; s1.YColor='[0 0 0]';
%ylim([-inf 1]); xlabel(labelx); fld = fieldnames(sts);
for pp = 1:length(fld)
%p(pp).rmsf = plot([sts(:,2).(fld{pp})], [sts(:,3).(fld{pp})], 'Color', cblu{pp}, 'LineWidth', 12);
p(pp).rmsa = plot([sta(2,2).(fld{pp}) sts(:,2).(fld{pp})], [sta(2,4).(fld{pp}) sts(:,4).(fld{pp})], 'Color', cred{pp}, 'LineWidth', 12);
%p(pp).fdev = plot([sts(:,2).(fld{pp})], [sts(:,5).(fld{pp})], '-.', 'Color', cblu{pp}, 'LineWidth', 3);
p(pp).adev = plot([sta(2,2).(fld{pp}) sts(:,2).(fld{pp})], [sta(2,6).(fld{pp}) sts(:,6).(fld{pp})], '-.', 'Color', cred{pp}, 'LineWidth', 3);
p(pp).eobs = plot([sta(2,2).(fld{pp}) sts(:,2).(fld{pp})], sqrt(obs_var)*ones(1,size([sta(2,2).(fld{pp}) sts(:,2).(fld{pp})],2)),'k-.', 'LineWidth', 5);
end
annotation(f,'textbox', [0.05 0.83 0.1 0.1],...
    'String',labelp, 'LineStyle','none',...
    'FontWeight','bold', 'FontSize',45,...
    'FitBoxToText','on');

%% Second panel
load('FIG/KSM_EUL_AMM21/output_LR_inf_fac.mat')
sta=sts;
load('FIG/KSM_EUL_AMM21/output_LR_inf_fac.mat')

s2 = subplot(1,3,2,'Position', [0.37, 0.1, 0.3, 0.83]);
set(gca,'GridAlpha',.2, 'XTick',round([sts(:,2).LR],2), 'YTickLabel', [])
grid on; hold on;
ylim([0.004 0.016]);
ylim([0 1.5]);
xlabel(labelx); fld = fieldnames(sts);
s2.XColor='[0 0 0]'; s2.YColor='[0 0 0]';
for pp = 1:length(fld)
%p(pp).rmsf = plot([sts(:,2).(fld{pp})], [sts(:,3).(fld{pp})], 'Color', cblu{pp}, 'LineWidth', 12);
p(pp).rmsa = plot([sts(:,2).(fld{pp})], [sts(:,4).(fld{pp})], 'Color', cred{pp}, 'LineWidth', 12);
%p(pp).fdev = plot([sts(:,2).(fld{pp})], [sts(:,5).(fld{pp})], '-.', 'Color', cblu{pp}, 'LineWidth', 3);
p(pp).adev = plot([sts(:,2).(fld{pp})], [sts(:,6).(fld{pp})], '-.', 'Color', cred{pp}, 'LineWidth', 3);
p(pp).eobs = plot([sts(:,2).(fld{pp})], sqrt(obs_var)*ones(1,size([sts(:,2).(fld{pp})],2)),'k-.', 'LineWidth', 5);
end
annotation(f,'textbox', [0.37 0.83 0.1 0.1],...
    'String',labelp, 'LineStyle','none',...
    'FontWeight','bold', 'FontSize',45,...
    'FitBoxToText','on');

%% Third panel
load('FIG/KSM_EUL_AMM21/output_LR_init_mesh.mat')

s3 = subplot(1,3,3,'Position', [0.69, 0.1, 0.3, 0.83]);
set(gca,'GridAlpha',.2, 'XTick',round([sts(:,2).LR],2), 'YTickLabel', [])
grid on; hold on;
ylim([0.004 0.016]);
ylim([0 1.5]);
xlabel(labelx); fld = fieldnames(sts);
s3.XColor='[0 0 0]'; s3.YColor='[0 0 0]';
for pp = 1:length(fld)
%p(pp).rmsf = plot([sts(:,2).(fld{pp})], [sts(:,3).(fld{pp})], 'Color', cblu{pp}, 'LineWidth', 12);
p(pp).rmsa = plot([sts(:,2).(fld{pp})], [sts(:,4).(fld{pp})], 'Color', cred{pp}, 'LineWidth', 12);
%p(pp).fdev = plot([sts(:,2).(fld{pp})], [sts(:,5).(fld{pp})], '-.', 'Color', cblu{pp}, 'LineWidth', 3);
p(pp).adev = plot([sts(:,2).(fld{pp})], [sts(:,6).(fld{pp})], '-.', 'Color', cred{pp}, 'LineWidth', 3);
p(pp).eobs = plot([sts(:,2).(fld{pp})], sqrt(obs_var)*ones(1,size([sts(:,2).(fld{pp})],2)),'k-.', 'LineWidth', 5);
end
annotation(f,'textbox', [0.69 0.83 0.1 0.1],...
    'String',labelp, 'LineStyle','none',...
    'FontWeight','bold', 'FontSize',45,...
    'FitBoxToText','on');

lg = legend([ p(1).rmsa, p(2).rmsa, p(1).adev, p(2).adev, p(2).eobs], ...
	    strcat('RMSE_a^{',fld{1},'}'), ...
	    strcat('RMSE_a^{',fld{2},'}'), ...
	    strcat('\sigma_a^{', fld{1},'}'), ...
	    strcat('\sigma_a^{', fld{2},'}'), ...
	    strcat('\sigma_o') ...
	    );
lg.FontSize = fsize*5/6;
%lg.Location = 'northeast';
lg.Position = [.40 0.85 0.25 0.06];
lg.Box = 'on';
lg.Orientation = 'Horizontal';
lg.Units = 'normalized';

%print -dpng multi_error_evolution_KSM42.png
