 clim_std = 7.98;

 run_AMMEnKF
 insize=length(da_times);

 sts(1,1).(resol) = resol;
 sts(1,2).(resol) = 0;
 sts(1,3).(resol) = mean(fc_rmse((insize-1)/2:insize));
 sts(1,4).(resol) = mean(an_rmse((insize-1)/2:insize));
 sts(1,5).(resol) = mean(fc_cov_trace((insize-1)/2:insize).^0.5);
 sts(1,6).(resol) = mean(an_cov_trace((insize-1)/2:insize).^0.5);
