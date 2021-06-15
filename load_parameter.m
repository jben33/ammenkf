% Global variables
global left right d1 d2 rmc N
global start finish h sol_h comp_time tlength
global model resol otype
global eps nu
global obs_time obs_var num_steps obs_t_indices da_times
global num_obs obs_m_indices
global N_true true_mesh del
global N_ens init_emesh_size ens_sd
global inf_fac bias clim_std
global da_tag etype expno

debug = 0;       % debug 1 or not 0
% expno = '03'; % run_setup
% model = 'BGM';   % model to run 'BGM' or 'KSM' % run_setup
% resol = 'HR';    % FM resolution wrt AMM: LR=low or HR=high % run_setup
% otype = 'EUL';   % truth on 'eulerian=EUL' or 'lagrangian=LAG' mesh
ename = 'AMM';
rpath = strcat(model,'/',resol);
mpath = strcat('MESH/',resol);
addpath('EnKF', 'OBS', 'POST', 'MESH', model) % relevant paths

fprintf('--------------------------------------\n');
fprintf('-  Started on %s at %s \n', date, datestr(now,'HH:MM:SS'));
fprintf('running %s%s using %s %s case with %s observations \n', ...
         ename, expno, model, resol, otype); % load constant parameters

rng(0) % Set seed

% 0 = no DA
% 1 = DA with average observation operator
% 2 = DA with matrix of anomalies
% da_tag = 0; % run_setup

% Set values of global variables

if (strcmp(model,'BGM'))
  eps   = 0.008;    % Burgers'  viscosity
  start = 0;  finish = 2;  h = 1e-3;  sol_h = 1e-2;  % time window and step
  left  = 0;  right  = 1;                            % spatial boundaries
  %d1 =  0.005*(right-left); d2 = 0.01*(right-left);   % remeshing criteria
  d1 =  0.01*(right-left);  d2 = 0.02*(right-left);   % remeshing criteria

  N_true = 100;                           % size of true Eulerian grid
  num_obs = 10;
  obs_time = .05;                        % Time between observations

%  init_emesh_size = 50;                  % size of  each initial ensemble member BGM % run_AMMEnKF
%  N_ens = 30;                            % number of ensemble members for BGM % run_AMMEnKF
elseif (strcmp(model,'KSM'))

  nu    = 0.027;    % KS viscosity
  start = 0;  finish = 5;  h = 1e-5;  sol_h = 5e-3;  % time window and step
  left  = 0;  right = 2*pi;                          % spatial boundaries
  d1 =  0.01*(right-left); d2 = 0.02*(right-left);   % remeshing criteria

  N_true = 120;                           % size of true Eulerian grid
  num_obs = 20;
  obs_time = 0.05;

%  init_emesh_size = 80;                   % size of  each initial ensemble member KSM % run_AMMEnKF
%  N_ens = 30;                             % number of ensemble members for KSM % run_AMMEnKF
end

  if (strcmp(resol,'LR'))
	    rmc = d2;
  elseif (strcmp(resol,'HR'))
	    rmc = d1;
  elseif (strcmp(resol,'US'))
        rmc = d2;
  elseif (strcmp(resol,'HRA'))
        rmc = d1;
  end

N  = round((right-left)/rmc);
% dimension of state space

rfm.lres = round(linspace(left,right-d2, round((right-left)/d2)),3);
rfm.enkf = round(linspace(left,right-rmc, round((right-left)/rmc)),3);
[rfm.sect, ifm.lres, ifm.stat] = intersect(rfm.lres, rfm.enkf);
ifm.mesh = ifm.stat + N;

del = (right-left)/N_true;             % distance between true grid points
true_mesh = round(linspace(left,right-del,N_true),3);  % true Eulerian grid

% Observation parameters

comp_time = start:sol_h:finish;     % computational time domain
tlength   = length(comp_time);

% timestep, assimilation window, obs indices
num_steps   = round((finish-start)/obs_time);
obs_t_indices = linspace(round((tlength-1)/num_steps)+1,tlength,num_steps);
da_times    = [start comp_time(obs_t_indices)];

% number of Eulerian observations, observation mesh indices
spacing = N_true/num_obs;
obs_m_indices = linspace(1,N_true-spacing+1,num_obs);
%obs_m_indices = [  20 50 ];
num_obs = length(obs_m_indices);

% plotting parameters
num_plots = 5; % Number of plots
plot_time = (finish-start)/num_plots;
plot_step = plot_time/obs_time;

movie       = 0;
plot2file   = 1;
plot2screen = 4;
plotfolder  = strcat('FIG/',model,'_',otype,'_',ename,expno);

if (plot2file ~= 0)
    if (exist(plotfolder) == 0)
      mkdir(plotfolder)
%    else
%  	  err(stop); 'plotfolder exists';
    end
end

clear_all = 1;
