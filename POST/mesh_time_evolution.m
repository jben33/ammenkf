figure('Name',strcat(plotfolder,'/mesh_evolution'),'DefaultAxesFontSize',35)
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Units', 'inches', 'OuterPosition', [0.5, 0.5, 20, 20]);
hold on
grid on;
%title(['Mesh in time'])
xlabel('z'); xlim([left right])
ylabel('t')
jj = 1;
    for j=1:tlength
            if ( j == 1 )
              s = scatter(true_mesh,comp_time(j)*ones(1,length(true_mesh)),15,'k');
              s.Marker = '*';
              s = scatter(true_mesh(obs_m_indices),comp_time(j)*ones(1,length(true_mesh(obs_m_indices))), 45,'go','filled');
            elseif ( j == tlength )
              s = scatter(true_mesh,comp_time(j)*ones(1,length(true_mesh)),15,'k');
              s.Marker = '*';
            else
              s = scatter(true_mesh,comp_time(j)*ones(1,length(true_mesh)),1,'k');
              s.Marker = 'o';
            end
                if (mod(j,obs_time/sol_h)==1) && ( j ~= 1)
                    s = scatter(obs_locs{jj},comp_time(j)*ones(1,length(obs_locs{jj})), 45,'ro','filled');
                jj = jj + 1;
                end
    end
hold off
  if (plot2file ~= 0)
          pltnum = strcat('t', sprintf('%02d',i));
          pltnam = strcat(plotfolder,'/Mesh_evo_in_time.png');
          fig = gcf;
          fig.PaperUnits = 'centimeters';
          fig.PaperPosition = [0 0 25 25];
          print(pltnam,'-dpng','-r300')
  end
