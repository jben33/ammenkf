lnum = size(da_times);
set(groot,'defaultAxesColorOrder',[1 0 0;0 1 0;0 0 1],...
      'defaultAxesLineStyleOrder','-|--|:')
figure('Name', strcat(plotfolder,'/velo_evolution'),'pos',[300 300 800 800],'DefaultAxesFontSize',35)
hold on
grid on; grid minor;
title(['Velocity in Time'])
xlabel('z'); xlim([left right]);
ylabel('u'); ylim([-1.5 1.5]);
    s = plot(true_mesh,u(1,:),'k');
    s.LineWidth = 8;
    jj=1;
    legendInfo{jj}=[strcat('t = ', sprintf('%i',0))];
    for ii=1:tlength
        if (mod(ii,obs_time/sol_h)==0)
            s = plot(true_mesh,u(ii,:));
            s.LineWidth = 8 - jj/100;
            jj = jj + 1;
            legendInfo{jj}=[strcat('t = ', sprintf('%0.1f',da_times(jj)))];
        end
    end
        lgd = legend(legendInfo);
        lgd.FontSize = 11;
        lgd.Location = 'southeast';
hold off
  if (plot2file ~= 0)
          pltnum = strcat('t', sprintf('%02d',i));
          pltnam = strcat(plotfolder,'/Velo_evo_in_time.png');
          fig = gcf;
          fig.PaperUnits = 'centimeters';
          fig.PaperPosition = [0 0 25 25];
          print(pltnam,'-dpng','-r300')
  end
