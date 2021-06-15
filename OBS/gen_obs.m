% Input observation type (Eulerian or Lagrangian)
% Output observation locations and observation values

function [obs_locs, obs_vals, obs_mesh, perturb_obs] = gen_obs

global left right
global sol_h
global otype
global obs_var num_steps da_times
global num_obs obs_m_indices
global true_mesh N_ens

obs_locs = cell(num_steps,1);
obs_vals = cell(num_steps,N_ens);
perturb_obs = cell(num_steps,1);

if(strcmp(otype,'EUL'))                                         % Eulerian observations
    for i=1:num_steps
        obs_locs{i} = true_mesh(obs_m_indices);
        obs_mesh(:,i) = obs_locs{i};
    end
elseif(strcmp(otype,'LAG'))                                     % Lagrangian observations

    obs_locs = cell(num_steps,1);
    %pmesh = true_mesh(obs_m_indices);
    pmesh = linspace(left,right-0.01,num_obs);
    cmesh = pmesh;

    for j=1:num_steps

        pmesh = cmesh;
        t1 = da_times(j);
        t2 = da_times(j+1);

        while(t1 < t2)
            d_approx = u_at(t1,pmesh);
            pmesh = pmesh+sol_h*d_approx;
            while(pmesh(1) < left)
                pmesh(1) = right-(left-pmesh(1));
                pmesh = sort(pmesh);
            end
            while(right <= pmesh(num_obs))
                pmesh(num_obs) = left+(pmesh(num_obs)-right);
                pmesh = sort(pmesh);
            end
            %pmesh = sort(pmesh);
            t1 = t1+sol_h;
        end

        obs_locs{j} = pmesh;
        cmesh = obs_locs{j};
        obs_mesh(:,j) = obs_locs{j};

    end
end

for i=1:num_steps
	k = size(obs_locs{i},2);
	jj=2;
	for ii = 2:k
		if ( (obs_locs{i}(jj) - obs_locs{i}(jj-1)) < 0.001 )
			obs_locs{i}(jj) = [];
		else
			jj = jj + 1;
		end
	end
	num_obs = size(obs_locs{i},2);
    perturb_obs{i} = normrnd(0,sqrt(obs_var),N_ens,num_obs);
    for kk=1:N_ens
      obs_vals{i}{kk} = u_at(da_times(i+1),obs_locs{i}) + perturb_obs{i}(kk,:);
    end
end
