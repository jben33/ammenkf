an_ensemble = A_full;
Nup=size(A_full,2);%N has been replaced with this since analysis mesh changes dimension
if(strcmp(resol, 'HR') || strcmp(resol,'LR'))
    Nup=N;
end
%an_means(1,:) = ens_mean(A_full);
an_means{1}=ens_mean(A_full);
A = A_full(:,1:Nup)';

% if(strcmp(resol, 'HR') || strcmp(resol, 'LR'))
% an_means{1} = ens_mean(A_full(:,1:Nup/2));
% A = A_full(:,1:Nup/2)'; 
% else
% an_means{1} = ens_mean(A_full);
% A = A_full(:,1:Nup)'; 
% end;

%A_bar = repmat(an_means(1,1:Nup),N_ens,1)';
A_bar = repmat(an_means{1}(1:Nup),N_ens,1)';

if(strcmp(resol,'HRA'))
EANHRA(:,:,1)=(1/sqrt(N_ens-1))*((A-A_bar)*(A-A_bar)');
EAHRA(:,:,1)=(A-A_bar)*(A-A_bar)';
save('EANHRA.mat', 'EANHRA');
save('EAHRA.mat', 'EAHRA');
end

if(strcmp(resol, 'HR'))
EANHR(:,:,1)=(1/sqrt(N_ens-1))*((A-A_bar)*(A-A_bar)');
EAHR(:,:,1)=(A-A_bar)*(A-A_bar)';

save('EANHR.mat', 'EANHR');
save('EAHR.mat', 'EAHR');
end

A_prime = 1/sqrt(N_ens-1)*(A-A_bar);
% if(strcmp(resol, 'HRA') && divtrue==0)
         ifm.stat=[1:Nup];
% elseif(strcmp(resol, 'HRA') && divtrue==1)        
%         ifm.stat=[1:Nup/2];
% elseif(strcmp(resol, 'HR'))
%        ifm.stat=[1:Nup];
% end

%if(divtrue==0)
Adiag = A_full(:,ifm.stat)';
%A_bar_diag = repmat(an_means(1,ifm.stat),N_ens,1)';
A_bar_diag = repmat(an_means{1}(ifm.stat),N_ens,1)';
A_prime_diag = 1/sqrt(N_ens-1)*(Adiag-A_bar_diag);
an_cov = A_prime_diag*A_prime_diag';
an_cov_trace(1) = sum(diag(an_cov))/length(ifm.stat);
%elseif(divtrue==1)
clear Adiag
if(strcmp(resol,'HRA'))
ifm.stat=[1:Nup/2];
AdiagD=zeros(Nup/2,N_ens);
else
AdiagD=zeros(Nup,N_ens);
end
for kd=1:N_ens
AdiagD(:,kd) = gradient(A_full(kd,ifm.stat),A_full(kd,ifm.stat+N))';
end

A_bar_diagD = repmat(gradient(an_means{1}(ifm.stat),an_means{1}(ifm.stat+N)),N_ens,1)'; 
A_prime_diagD = 1/sqrt(N_ens-1)*(AdiagD-A_bar_diagD);
an_covD = A_prime_diagD*A_prime_diagD';
an_cov_traceD(1) = sum(diag(an_covD))/length(ifm.stat);
%end
    