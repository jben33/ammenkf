check = exist('analysis');
if ( check == 0 )
	exp_index = 1;
	!rm exp_index.mat
	analysis(exp_index).mod = strcat(model);
	forecast(exp_index).mod = strcat(model);
	analysis(exp_index).res = strcat(resol);
	forecast(exp_index).res = strcat(resol);
	analysis(exp_index).obs = strcat(otype);
	forecast(exp_index).obs = strcat(otype);

	analysis(exp_index).rmse = an_rmse; 
	forecast(exp_index).rmse = fc_rmse; 

	analysis(exp_index).sdev = an_cov_trace.^.5;
	forecast(exp_index).sdev = fc_cov_trace.^.5;

	analysis(exp_index).mean = an_means; 
	forecast(exp_index).mean = fc_means; 

	exp_index = exp_index + 1;
	save('exp_index.mat', 'exp_index', '-mat')
else
	load('exp_index.mat');
	!rm exp_index.mat
     %exp_index
     %resol
	%pause
    analysis(exp_index).mod = strcat(model);
	forecast(exp_index).mod = strcat(model);
	analysis(exp_index).res = strcat(resol);
	forecast(exp_index).res = strcat(resol);
	analysis(exp_index).obs = strcat(otype);
	forecast(exp_index).obs = strcat(otype);

	analysis(exp_index).rmse = an_rmse; 
	forecast(exp_index).rmse = fc_rmse; 

	analysis(exp_index).sdev = an_cov_trace.^.5;
	forecast(exp_index).sdev = fc_cov_trace.^.5;

	analysis(exp_index).mean = an_means; 
	forecast(exp_index).mean = fc_means; 

	exp_index = exp_index + 1;
	save('exp_index.mat', 'exp_index', '-mat')
end
