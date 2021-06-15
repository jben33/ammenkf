% Adaptive Moving Mesh (AMM) EnKF - Burgers' Equation
% Reference fixed mesh (RFM)
% Ensemble Kalman Filter (EnKF)
% Burgers' Model (BGM)
% Kuramoto-Sivasinsky Model (KSM)

global model resol da_tag expno etype
global xind
global N N_ens inf_fac jitter
global num_steps
global u da_times
global time

%close all;              % close previous windows

load_parameter;
divtrue=0;
h1norm=0;
fprintf('loaded parameters\n');

% Burgers' Model
if (strcmp(model,'BGM'))
  ens_sd  = .16;
  if(strcmp(otype,'EUL'))
    obs_var = .0001;
  elseif(strcmp(otype,'LAG'))
    obs_var = .0001;
  end
  bias    = 0.1;
  if (strcmp(etype,'N_ens'))
   N_ens   = xind;
   inf_fac = 1.0;
   init_emesh_size = 70;
   fprintf('experiment with ensemble size... \n');
   jitter=0;
  elseif (strcmp(etype,'inf_fac'))
   N_ens   = 30;
   init_emesh_size = 70;
   inf_fac = xind;
   fprintf('experiment with inflation factor... \n');
   jitter=0;
  elseif (strcmp(etype,'obs_var'))
   obs_var = xind^2;
   fprintf('experiment with observational error... \n');
   jitter=0;
   init_emesh_size = 70;
   inf_fac = 1.0;
   N_ens=30;
  elseif (strcmp(etype,'init_mesh'))
   N_ens   = 30;
   if (strcmp(resol,'HR')); inf_fac = 1.00;end
   if (strcmp(resol,'HR')); inf_fac = 1.00;end
   if (strcmp(resol,'LR')); inf_fac = 1.45; end
   init_emesh_size = xind;
   fprintf('experiment with initial mesh size... \n');
   jitter=0;
   inf_fac=1;
   
  elseif (strcmp(etype,'jitter'))
   N_ens   = 30;
   if (strcmp(resol,'HRA')); inf_fac = 1.00; end
   if (strcmp(resol,'HR')); inf_fac = 1.00; end
   if (strcmp(resol,'LR')); inf_fac = 1.00; end
   jitter = xind;
   init_emesh_size = 70;
   fprintf('experiment with jitter... \n');
  elseif (strcmp(etype,'jitter_inflation'))
    N_ens=30;
    init_emesh_size=70;
    inf_fac=xind(1);
    jitter=xind(2);
    fprintf('experiment with Jitter and Inflation LHS \n');
  elseif (strcmp(etype,'everything'))
    N_ens=xind(4);
    init_emesh_size=xind(5);
    inf_fac=xind(1);
    jitter=xind(2);
    obs_var=xind(3);
    fprintf('experiment with everything LHS \n');
  
  elseif (strcmp(etype,'inflation_jitter_other1d'))
   inf_fac=xind(1);
   jitter=xind(2);
   %N_ens=xind(3);
    N_ens=30;
    init_emesh_size=70;
   obs_var=xind(3)^2;
    fprintf('experiment finding optimal jitter and inflation for another paramater LHS \n');
    
  else
   N_ens   = 30;
   init_emesh_size =70 ; % this needs to change depending on d1 and d2
   if (strcmp(resol,'HRA')); inf_fac = 1; end
   if (strcmp(resol,'HR')); inf_fac = 1; end
   if (strcmp(resol,'LR')); inf_fac = 1.45; end
   fprintf('single experiment with fixed parameters... \n');
   jitter=0;
   inf_fac=1;
   
  end
% Kuramoto-Sivashinsky Model
elseif (strcmp(model,'KSM'))
  ens_sd  = (clim_std*0.1);
  obs_var = (clim_std*0.1)^2; %!!check!!!
  bias    = 1.0;
  if (strcmp(etype,'N_ens'))
   N_ens   = xind;
   inf_fac = 1.0;
   init_emesh_size = 80;
   fprintf('experiment with ensemble size... \n');
   jitter=0;
  elseif (strcmp(etype,'inf_fac'))
   N_ens   = 40;
   inf_fac = xind;
   init_emesh_size = 80;
   fprintf('experiment with inflation factor... \n');
   jitter=0;
  elseif (strcmp(etype,'obs_var'))
   obs_var = xind^2;
   fprintf('experiment with observational error... \n');
   jitter=0;
   init_emesh_size = 80;
   inf_fac=1.0;
   N_ens=40;
  elseif (strcmp(etype,'init_mesh'))
   N_ens   = 40;
   if (strcmp(resol,'HR')); inf_fac = 1.2; end
   if (strcmp(resol,'LR')); inf_fac = 1.3; end
   init_emesh_size = xind;
   fprintf('experiment with initial mesh size... \n');
   jitter=0;
   inf_fac=1.0;
   elseif (strcmp(etype,'jitter'))
   N_ens   = 40;
   if (strcmp(resol,'HRA')); inf_fac = 1.0; end
   if (strcmp(resol,'HR')); inf_fac = 1.0; end
   init_emesh_size = 80;
   jitter=xind;
   inf_fac=1.0;
   fprintf('experiment with jitter... \n');
   elseif (strcmp(etype,'jitter_inflation'))
    N_ens=40;
    init_emesh_size=80;
    inf_fac=xind(1);
    jitter=xind(2);
    fprintf('experiment with Jitter and Inflation LHS \n');
   elseif (strcmp(etype,'inflation_jitter_other1d'))
   inf_fac=xind(1);
   jitter=xind(2);
   N_ens=40;
    init_emesh_size=70;
   obs_var=xind(3)^2;
    fprintf('experiment finding optimal jitter and inflation for another paramater LHS \n');
   else
   N_ens   = 40;
   if (strcmp(resol,'HRA')); inf_fac = 1.2; end
   if (strcmp(resol,'HR')); inf_fac = 1.2; end
   if (strcmp(resol,'LR')); inf_fac = 1.3; end
   if (strcmp(resol,'HRA')); init_emesh_size = 80; end
   if (strcmp(resol,'HR')); init_emesh_size = 80; end
   if (strcmp(resol,'LR')); init_emesh_size = 80; end
   fprintf('single experiment with fixed parameters... \n');
   jitter=0;
  end
end

fprintf('initial mesh size: %i \n', init_emesh_size);
fprintf('observation error: %f \n', obs_var);
fprintf('Ensemble size    : %i \n', N_ens);
fprintf('Inflation factor : %f \n', inf_fac);
fprintf('Jitter : %f \n', jitter);

% % Generate true state - adaptive mesh and values at mesh locations
if (strcmp(model,'BGM'))
    init_vals = sin(2*pi.*true_mesh)+0.5*sin(pi.*true_mesh);
    u = generate_truth_bgm(init_vals);
elseif (strcmp(model,'KSM'))
    load('ksm_u.mat');
    init_vals = ksm_init_u;
%    init_vals = -sin(true_mesh);
    u = generate_truth_ksm(init_vals);
end
fprintf('generated the truth\n');

% % Generate observations
[obs_locs, obs_vals, obs_mesh, perturb_obs] = gen_obs;
fprintf('generated the observations\n');

% % Plot evolution of the observations on the mesh
%  mesh_time_evolution
%  velo_time_evolution
%  velocity_surface

% % Initialize the ensemble
init_ens = initialize_ensemble;
fc       = init_ens;

% % Run EnKF
%fc_means     = nan(num_steps+1,2*N);  an_means     = nan(num_steps+1,2*N);
%fc_cov_trace = nan(1,num_steps+1);    an_cov_trace = nan(1,num_steps+1);

if(strcmp(resol,'HR'))
    fprintf('Reference mesh resolution: %s \n', resol);
    embedded_fc = embed_HR(fc);
    active = ~isnan(embedded_fc);
    A_full = fill_in(embedded_fc);
elseif(strcmp(resol,'LR'))
    fprintf('Reference mesh resolution: %s \n', resol);
    [embedded_fc, indices] = embed_LR(fc);
    A_full = embedded_fc;
elseif(strcmp(resol,'US'))
    fprintf('Refrence mesh resolution %s \n', resol);
    [A_full,gnums,idxu,idxz]=embed_US(fc,0);% option zero selects least num groups non zero number specifies a specific number
    % A_full(:,size(A_full,2)/2+1:size(A_full,2))=[];

elseif(strcmp(resol,'HRA'))
     fprintf('Refrence mesh resolution %s \n', resol);
     embedded_fc = embed_HRA(fc);
     active = ~isnan(embedded_fc);
     A_full = fill_in_HRA(embedded_fc);

end

initial_stats;

s = (tlength-1)/(num_steps);

for i=1:num_steps

    %% Forecast step
    fc = fw_ensemble(fc,da_times(1),da_times(2));
    temp = fc;

    %% Embed forecast ensemble in state space, fill in gaps
    if(strcmp(resol,'HR'))
        embedded_fc = embed_HR(fc);
        active = ~isnan(embedded_fc);
        A_full = fill_in(embedded_fc);
%    for j=1:N_ens
%      L = length(A_full(j,:))/2;
%      maxdiff=max(A_full(j,1:L))-min(A_full(j,1:L));
%     % A_full(j,1:L)=A_full(j,1:L)+normrnd(0,0.01*maxdiff,[1,L]);%,normrnd(0,0,[1,L])]; 
%     A_full(j,1:L)=A_full(j,1:L)+normrnd(0,0.01*maxdiff)*ones(1,L);%,[1,L]),normrnd(0,0,[1,L])]; 
%    end
	fc_full = A_full;
    elseif(strcmp(resol,'LR'))
        [embedded_fc, indices] = embed_LR(fc);
	A_full = embedded_fc;
	fc_full = A_full;
    
    elseif(strcmp(resol,'US'))
   % fprintf('Refrence mesh resolution %s \n', resol);
    [A_full,gnums,idxu,idxz]=embed_US(fc,0);
    %A_full(:,size(A_full,2)/2+1:size(A_full,2))=[];
    
    elseif(strcmp(resol,'HRA'))
    %fprintf('Refrence mesh resolution %s \n', resol);

    embedded_fc = embed_HRA(fc);
     active = ~isnan(embedded_fc);
     A_full = fill_in_HRA(embedded_fc);
%    for j=1:N_ens
%      L = length(A_full(j,:))/2;
%      maxdiff=max(A_full(j,1:L))-min(A_full(j,1:L));
%     % A_full(j,1:L)=A_full(j,1:L)+normrnd(0,0.01*maxdiff,[1,L]);%,normrnd(0,0,[1,L])]; 
%     A_full(j,1:L)=A_full(j,1:L)+normrnd(0,0.3*maxdiff)*ones(1,L);%,[1,L]),normrnd(0,0,[1,L])]; 
%    end
fc_full=A_full;
    end
    

    %% Compute forecast mean, covariance, kalman gain
    forecast_stats;

    %% Compute Kalman gain K
    kalman_gain

    %% Ensemble update
    time=obs_t_indices(i);
    ens_update

    %% Put analysis ensemble members back on original meshes
if(strcmp(resol,'HR'))
    an_full = A_full;
    embedded_an = A_full.*active;
    embedded_an(embedded_an==0) = nan;
    for j=1:N_ens
	    L = length(fc{j})/2;
        fc{j} = [get_values(embedded_an(j,:)) fc{j}(L+1:2*L)];
       maxdiff=max(fc{j}(:))-min(fc{j}(:));
       fc{j}=fc{j}+[normrnd(0,jitter*maxdiff,[1,L]),normrnd(0,0,[1,L])];
       % fc{j} = [get_values(embedded_an(j,:)) get_mesh(embedded_an(j,:))];
    end
elseif(strcmp(resol,'LR'))
    an_full = A_full;
    embedded_an = A_full;
    for j=1:N_ens
      for fm=1:N
      ind = size(indices{j,fm},2);
        for k = 1:ind
          fc{j}(indices{j,fm}(k)) = embedded_an(j,fm);
        end  % end for k loop
      end % end for fm loop
    end % end for j loop
elseif(strcmp(resol, 'US'))
    %need to put updated singles in fc and move averaged by same amount as
    %averaged values. not clearwhat to do 
% for j=1:N_ens
%    % fc{j}=A_full(j,:);
%      for i=1:length(fc{j})
%       fc{j}(
%     
% end

elseif(strcmp(resol, 'HRA'))
     an_full = A_full;
    embedded_an=A_full;
    %embedded_an = A_full.*active;
    %embedded_an(embedded_an==0) = nan;
    embedded_an(~active)=nan;
    for j=1:N_ens
	    L = length(fc{j})/2;
        %fc{j} = [get_values(embedded_an(j,:)) fc{j}(L+1:2*L)]; %when going back to orignal no mesh update
        fc{j} = [get_values(embedded_an(j,:)) get_mesh(embedded_an(j,:))];
      % fc{j}=A_full(j,:);
        %if(fc_cov_trace(i+1) < sqrt(obs_var))
          maxdiff=max(fc{j}(:))-min(fc{j}(:));
          fc{j}=fc{j}+[normrnd(0,jitter*maxdiff,[1,L]),normrnd(0,0,[1,L])];           % display('resampling');
            %pause(0.1)
       % end;
            
        %make sure ordering is correct after location updating.
        fctu=fc{j}(1:L);
        fctz=fc{j}(L+1:2*L);
%         plot(fctz,fctu)
%         pause
       % hold on
        [fctz, fczi]=sort(fctz);
        fctu=fctu(fczi);
        %plot(fctz,fctu,'o')
%         LL=length(fc{j})/2;
% plot(fc{j}(LL+1:2*LL),fc{j}(1:LL),'o');
% pause(0.1);
        %hold on
        %pause;
       % [fctu1, fctz1]=remesh(fctu, fctz);%remesh if necessary
        %plot(fctz1,fctu1,'o')
        %hold off
        %pause;
       %[fct1, fct2]=remesh(fc{j}(1:L), fc{j}(L+1:2*L)); %I think need to remesh
      %fc{j}=[fctu1,fctz1];
      %plot(fctz,fctu)
      %hold on 
      %plot(fctz1,fctu1)
      %hold off
      %pause;
      clear fctz
       clear fctu
        %clear fctz1
       %  clear fctu1

end 


%
    %% Plot time evolution
%    if ( mod(i, plot_step) == 0)
%      plot_time_evolution
%      member_on_AMM_FRM
%    end
%
end
end
%
% % Compute error stats
compute_error_stats



% figure
% for k=1:N_ens
%     plot(memrms(k,:))
%     hold on
% end
% pause
% % Plot Error stats
% if ( da_tag == 0 )
% 	plot_free_error
% else
% 	plot_error_stats
% end
%save_figure
compare_experiment
fprintf('* Finished on %s at %s \n', date, datestr(now,'HH:MM:SS'));
