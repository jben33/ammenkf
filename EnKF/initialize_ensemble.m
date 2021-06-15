% Generate initial ensemble

function ens = initialize_ensemble

global left right
global N_ens init_emesh_size ens_sd bias

ens = cell(N_ens,1);                    % holds ensemble
% initial mesh for each ensemble member
edel = (right-left)/init_emesh_size;
init_emesh = linspace(left,right-edel,init_emesh_size);

SP     = normrnd(0,ens_sd,N_ens,init_emesh_size);
SP_bar = mean(SP);
for i=1:N_ens
    ens{i} = [u_at(0,init_emesh)+bias+(SP(i,:)-SP_bar)  init_emesh];
end
