global model etype labelt labelx labelp

fsize=30;
line_color;

fname=strcat(plotfolder,'/',model,'_error_',labelt);
f = figure('Name',fname,'DefaultAxesFontSize',fsize);

set(gcf, 'Units', 'Inches', 'Position', [0, 0, 30, 40], 'PaperUnits', 'Inches', 'PaperPosition', [0 0 30 40])
set(gca,'GridAlpha',.2, 'XTick',round([sts(:,2).LR],2))
grid on; hold on;

subplot(1,2,1)
%maximum=max([sts(:,3).HR sts(:,4).HR sts(:,5).HR sts(:,6).HR]);
ylim auto;
%if (strcmp(model,'BGM') && maximum > 0.03)
%  ylim([0.005 inf]);
%else
%  ylim([0.005 0.03]);
%end
%if (strcmp(model,'KSM'))
%  ylim([0 inf]);
%else
%  ylim([0.005 0.03]);
%end

xlabel(labelx)
fld = fieldnames(sts);
pp=1;
%for pp = 1:length(fld)
p(pp).rmsf = plot([sts(:,2).(fld{pp})], [sts(:,3).(fld{pp})], 'Color', cblu{pp}, 'LineWidth', 12);
p(pp).rmsa = plot([sts(:,2).(fld{pp})], [sts(:,4).(fld{pp})], 'Color', cred{pp}, 'LineWidth', 12);
p(pp).fdev = plot([sts(:,2).(fld{pp})], [sts(:,5).(fld{pp})], 'd-', 'Color', cblu{pp}, 'LineWidth', 5);
p(pp).adev = plot([sts(:,2).(fld{pp})], [sts(:,6).(fld{pp})], 'd-', 'Color', cred{pp}, 'LineWidth', 5);
%p(pp).eobs = plot([sts(:,2).(fld{pp})], sqrt(obs_var)*ones(1,size([sts(:,2).(fld{pp})],2)),'ko', 'LineWidth', 5);
%end

annotation(f,'textbox',...
    [0.85 0.1 0.1 0.1],...
    'String',labelp,...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',45,...
    'FitBoxToText','on');

subplot(1,2,2)
ylim auto;
%if (strcmp(model,'BGM') && maximum > 0.03)
%  ylim([0.005 inf]);
%else
%  ylim([0.005 0.03]);
%end
%if (strcmp(model,'KSM'))
%  ylim([0 inf]);
%else
%  ylim([0.005 0.03]);
%end

xlabel(labelx)
fld = fieldnames(sts);
pp=2;
%for pp = 1:length(fld)
p(pp).rmsf = plot([sts(:,2).(fld{pp})], [sts(:,3).(fld{pp})], 'Color', cblu{pp}, 'LineWidth', 12);
p(pp).rmsa = plot([sts(:,2).(fld{pp})], [sts(:,4).(fld{pp})], 'Color', cred{pp}, 'LineWidth', 12);
p(pp).fdev = plot([sts(:,2).(fld{pp})], [sts(:,5).(fld{pp})], 'd-', 'Color', cblu{pp}, 'LineWidth', 5);
p(pp).adev = plot([sts(:,2).(fld{pp})], [sts(:,6).(fld{pp})], 'd-', 'Color', cred{pp}, 'LineWidth', 5);
%p(pp).eobs = plot([sts(:,2).(fld{pp})], sqrt(obs_var)*ones(1,size([sts(:,2).(fld{pp})],2)),'ko', 'LineWidth', 5);
%end

annotation(f,'textbox',...
    [0.85 0.1 0.1 0.1],...
    'String',labelp,...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',45,...
    'FitBoxToText','on');


%lg = legend([ p(1).rmsf, p(1).rmsa, p(1).fdev, p(1).adev, p(2).rmsf, p(2).rmsa, p(2).fdev, p(2).adev], ...
%            strcat('RMSE_f^{',fld{1},'}'), ...
%	    strcat('RMSE_a^{',fld{1},'}'), ...
%	    strcat('\sigma_f^{',fld{1},'}'), strcat('\sigma_a^{', fld{1},'}'), ...
%            strcat('RMSE_f^{',fld{2},'}'), ...
%	    strcat('RMSE_a^{',fld{2},'}'), ...
%	    strcat('\sigma_f^{',fld{2},'}'), strcat('\sigma_a^{', fld{2},'}') ...
%	    );
%lg.FontSize = 4*fsize/5;
%lg.Location = 'northoutside';
%lg.Box = 'off';
%lg.Orientation = 'Horizontal';

%print -dpng multi_error_evolution_KSM42.png
