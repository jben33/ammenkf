global etype labelt

%if (exist(plotfolder) == 0)
%  mkdir(plotfolder)
%elseif (exist(plotfolder) ~= 0 && ~isempty(etype))
%  fprintf(strcat('!!!--',plotfolder,' exists -- but continues for multirun \n'));
%else
%  fprintf(strcat('!!!--',plotfolder,' exists do not overwrite \n'));
%  return
%end
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = get(FigHandle, 'Name');
  FigNum    = get(FigHandle, 'Number');
  saveas(FigHandle, fullfile(strcat(FigName,'_',sprintf('%02d',FigNum),'.png')));
  saveas(FigHandle, fullfile(strcat(FigName,'_',sprintf('%02d',FigNum),'.fig')));
end

if ( ~isempty(etype) )
  save(fullfile(plotfolder,strcat('paraminput_',labelt,'.mat')), 'model','resol', ...
   'otype', 'left', 'right', 'd1', 'd2', 'rmc', 'N', 'inf_fac', 'bias', 'clim_std', ...
   'eps', 'nu', 'start', 'finish', 'h', 'sol_h', 'comp_time', 'tlength', 'obs_time', ...
   'obs_var', 'num_steps', 'obs_t_indices', 'da_times', 'num_obs', 'obs_m_indices', 'N_true', ...
   'true_mesh', 'del', 'N_ens', 'init_emesh_size', 'ens_sd', ...
   '-mat')
  save(fullfile(plotfolder,strcat('statoutput_',labelt,'.mat')), 'sts', 'fc_rmse', 'an_rmse', 'fc_cov_trace', 'an_cov_trace', '-mat')
else
  save(fullfile(plotfolder,strcat('paraminput.mat')), 'model','resol', ...
   'otype', 'left', 'right', 'd1', 'd2', 'rmc', 'N', 'inf_fac', 'bias', 'clim_std', ...
   'eps', 'nu', 'start', 'finish', 'h', 'sol_h', 'comp_time', 'tlength', 'obs_time', ...
   'obs_var', 'num_steps', 'obs_t_indices', 'da_times', 'num_obs', 'obs_m_indices', 'N_true', ...
   'true_mesh', 'del', 'N_ens', 'init_emesh_size', 'ens_sd', ...
   '-mat')
  save(fullfile(plotfolder,'statoutput.mat'), 'sts', 'fc_rmse', 'an_rmse', 'fc_cov_trace', 'an_cov_trace', '-mat')
end
