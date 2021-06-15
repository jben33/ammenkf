figure('Name',strcat(plotfolder,'/velocity_surface'),'DefaultAxesFontSize', 24)
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'Units', 'inches', 'OuterPosition', [0.5, 0.5, 15, 15]);
s = mesh(true_mesh, comp_time,u(1:tlength,:)); 
%s = contour3(true_mesh, comp_time,u(1:tlength,:)); 
colormap(gca,jet)
hold on;
xlim([left right])
%mesh(true_mesh, comp_time,u(1:tlength,:));
%colorbar('LineWidth', 0.1, 'Location', 'north');
%s.EdgeColor='interp'; 
%s.FaceColor='interp'; 
%s.FaceLighting='flat'; 
%title(strcat(model,' until t=',num2str(finish))); 
xlabel('z'); ylabel('t'); zlabel('u');
%set(gca, 'Color', '[.9 .9 .9]')
view(-45,60);
hold off;

