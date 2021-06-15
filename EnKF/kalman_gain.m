HA = nan(length(obs_locs{i}),N_ens);
HA_bar = nan(length(obs_locs{i}),N_ens);
S = nan(length(obs_locs{i}),N_ens);
Nup=size(A_full,2); % needed since dimension of analysis mesh changes Nup replaces N in this code

for j=1:N_ens
    HA(:,j) = get_H(A_full(j,:),obs_locs{i})*A(1:Nup/2,j); %should it 1:Nup?
   % HA_bar(:,j) = get_H(fc_means(i+1,:),obs_locs{i})*fc_means(i+1,1:Nup)';
   HA_bar(:,j) = get_H(fc_means{i+1},obs_locs{i})*fc_means{i+1}(1:Nup/2)';
end

S = 1/sqrt(N_ens-1)*(HA-HA_bar);

%v = obs_var*ones(1,length(obs_locs{i}));
%R = diag(v)
Yo = 1/sqrt(N_ens-1)*perturb_obs{i}';
R_e = Yo*Yo';
K = A_prime*S'*pinv((S*S')+R_e);
