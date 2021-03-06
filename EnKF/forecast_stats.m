fc_ensemble = A_full;
Nup=size(A_full,2); % N has been replaced with this since analysis dimension chages
if(strcmp(resol, 'HR') || strcmp(resol,'LR'))
    Nup=N;
end

%fc_means(i+1,:) = ens_mean(A_full);
fc_means{i+1} = ens_mean(A_full);
A = A_full(:,1:Nup)';

% if(strcmp(resol, 'HR') || strcmp(resol, 'LR'))
% fc_means{i+1} = ens_mean(A_full(:,1:Nup/2));
% A = A_full(:,1:Nup/2)'; 
% else
% fc_means{i+1} = ens_mean(A_full);
% A = A_full(:,1:Nup)'; 
% end;

% matrix of ensemble members
%A_bar = repmat(fc_means(i+1,1:Nup),N_ens,1)';         % matrix of ensemble means
A_bar = repmat(fc_means{i+1}(1:Nup),N_ens,1)';         % matrix of ensemble means
%A_bar_full = repmat(fc_means(i+1,:),N_ens,1);
A_bar_full = repmat(fc_means{i+1},N_ens,1);


if(strcmp(resol,'HRA'))
EANHRA(:,:,i+1)=(1/sqrt(N_ens-1))*((A-A_bar)*(A-A_bar)');
EAHRA(:,:,i+1)=(A-A_bar)*(A-A_bar)';
save('EANHRA.mat', 'EANHRA');
save('EAHRA.mat', 'EAHRA');
end

if(strcmp(resol, 'HR'))
EANHR(:,:,i+1)=(1/sqrt(N_ens-1))*((A-A_bar)*(A-A_bar)');
EAHR(:,:,i+1)=(A-A_bar)*(A-A_bar)';

save('EANHR.mat', 'EANHR');
save('EAHR.mat', 'EAHR');
end



A_prime = 1/sqrt(N_ens-1)*inf_fac*(A-A_bar);        % matrix of anomalies

% if(strcmp(resol, 'HRA') && divtrue==0)
         ifm.stat=[1:Nup];
% elseif(strcmp(resol, 'HRA') && divtrue==1)        
%         ifm.stat=[1:Nup/2];
% elseif(strcmp(resol, 'HR'))
%        ifm.stat=[1:Nup];
% end
        
%if(divtrue==0)       
Adiag = A_full(:,ifm.stat)';                                 % matrix of ensemble members
%A_bar_diag = repmat(fc_means(i+1,ifm.stat),N_ens,1)';        % matrix of ensemble means
A_bar_diag = repmat(fc_means{i+1}(ifm.stat),N_ens,1)';        % matrix of ensemble means

%A_bar_full_diag = repmat(fc_means(i+1,:),N_ens,1);
A_bar_full_diag = repmat(fc_means{i+1},N_ens,1);


A_prime_diag = 1/sqrt(N_ens-1)*inf_fac*(Adiag-A_bar_diag);        % matrix of anomalies

fc_cov = A_prime_diag*A_prime_diag';
fc_cov_trace(i+1) = sum(diag(fc_cov))/length(ifm.stat);
%elseif(divtrue==1)

if(strcmp(resol,'HRA'))
ifm.stat=[1:Nup/2];
end

for kd=1:N_ens
AdiagD(:,kd) = gradient(A_full(kd,ifm.stat),A_full(kd,ifm.stat+N))';
end

A_bar_diagD = repmat(gradient(fc_means{i+1}(ifm.stat),fc_means{i+1}(ifm.stat+N)),N_ens,1)'; 
A_prime_diagD = 1/sqrt(N_ens-1)*inf_fac*(AdiagD-A_bar_diagD);
fc_covD = A_prime_diagD*A_prime_diagD';
fc_cov_traceD(i+1) = sum(diag(fc_covD))/length(ifm.stat);
%end;
