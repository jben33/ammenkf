% ----------------------------------
% Experiment setup in the manuscript
% ----------------------------------

global model resol da_tag expno etype otype

swid = [ 0 1 0 0; 0 0 0 0]; % switch for each set of experiments
% swid == 1 to run the below experiments
% swid(1,1) BGM for DA-free run
% swid(1,2) BGM for sensitivity analysis
% swid(1,3) BGM for DA run using eulerian obs
% swid(1,4) BGM for DA run using lagrangian ons
% swid(2,1) KSM for DA-free run
% swid(2,2) KSM for sensitivity analysis
% swid(2,3) KSM for DA run using eulerian obs
% swid(2,4) KSM for DA run using lagrangian obs

exid = [0 0 0 0 0 0 0 1]; % switch for each sensitivity experiment
% exid(1) ensemble size
% exid(2) inflation factor
% exid(3) observational error
% exid(4) initial mesh size
% exid(5) jitter
save('swid.mat', 'swid', '-mat');
save('exid.mat', 'exid', '-mat'); 

% DA-free run using Burgers' equation
  % call plot2compare_free for diagnostics
if (swid(1,1) ~= 0)
otype='EUL';
expno  = '30' ; model  = 'BGM'; da_tag =     0;

resol  = 'HRA' ; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));
resol  = 'HR' ; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));

plot2compare_free;
save_figure; pause(1);
close all; clear all; pause(1);
load('swid.mat'); load('exid.mat');

end

% Multirun DA experiments using Burgers' equation
  % call plot_multi_ens for diagnostics
if (swid(1,2) ~= 0)
  if (exid(1) ~= 0)
    otype='LAG';
    %  ensemble size
    expno  = '51.01' ; model  = 'BGM'; da_tag =     2;

    etype  = 'N_ens';
    fprintf('Experiment type: %s \n', etype);
        %clear A A_bar A_bar_diag A_bar_full A_prime A_prime_diag A_diag N_ens

    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
    %clear A A_bar A_bar_diag A_bar_full A_prime A_prime_diag A_diag
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));

    plot_multi_ens
    save_figure; pause(1);
    close all; clear all; pause(1);
    load('swid.mat'); load('exid.mat');

  end

  if (exid(2) ~= 0)
  %  inflation factor
    otype='EUL';
    expno  = '51' ; model  = 'BGM'; da_tag =     2;

    etype  = 'inf_fac';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
    
    plot_multi_ens
    save_figure; pause(1);
    close all; clear all; pause(1);
    load('swid.mat'); load('exid.mat');

      

end

  if (exid(3) ~= 0)
    %  observational error
    otype='EUL';
    expno  = '51' ; model  = 'BGM'; da_tag =     2;

    etype  = 'obs_var';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));

    plot_multi_ens
    save_figure; pause(1);
    close all; clear all; pause(1);
    load('swid.mat'); load('exid.mat');

  end

  if (exid(4) ~= 0)
    %  initial mesh size
    otype='EUL';
    expno  = '51' ; model  = 'BGM'; da_tag =     2;

    etype  = 'init_mesh';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));

    plot_multi_ens
    save_figure; pause(1);
    close all; clear all;pause(1);
    load('swid.mat'); load('exid.mat');
  end
  
   if (exid(5) ~= 0)
    %  jitter
    otype='EUL';
    expno  = '51' ; model  = 'BGM'; da_tag =     2;

    etype  = 'jitter';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));

    plot_multi_ens
    save_figure; pause(1);
    close all; clear all;pause(1);
    load('swid.mat'); load('exid.mat');
   end
  
     if (exid(6) ~= 0)
    %  jitter and inf
    otype='EUL';
    expno  = '51' ; model  = 'BGM'; da_tag =     2;

    etype  = 'jitter_inflation';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    !cp -r FIG/BGM*/* ../2paramdata
   % plot_multi_ens
    %save_figure; pause(1);
    %close all; clear all;pause(1);
    %load('swid.mat'); load('exid.mat');
     end
     
      if (exid(7)~= 0)
    %LHSeverything
    otype='EUL';
    expno  = '51' ; model  = 'BGM'; da_tag =     2;

    etype  = 'everything';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    !cp -r FIG/BGM*/* ../5paramdata
   % plot_multi_ens
    %save_figure; pause(1);
    %close all; clear all;pause(1);
    %load('swid.mat'); load('exid.mat');
      end
     
   if (exid(8)~= 0)
    %everything
   otype='LAG'; %otype='EUL'

    expno  = '51' ; model  = 'BGM'; da_tag =     2;
   
    etype  = 'inflation_jitter_other1d';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    !cp -r FIG/BGM*/* ../3paramdata
   % plot_multi_ens
    %save_figure; pause(1);
    %close all; clear all;pause(1);
    %load('swid.mat'); load('exid.mat');
   end
   
  % plot_multi_panel
end 

% Single DA experiments using Burgers' equation comparing HR/LR optimal solution
  % call plot2compare_enkf for diagnostics
if (swid(1,3) ~= 0)

otype='EUL';
expno  = '52' ; model  = 'BGM'; da_tag =     2;

resol  = 'HRA' ; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));
resol  = 'HR' ; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));

plot2compare_enkf;
save_figure; pause(1);
close all; clear all; pause(1);
load('swid.mat'); load('exid.mat');
end

% Single DA experiments using Burgers' equation comparing HR/LR optimal solution
% call plot2compare_enkf for diagnostics
if (swid(1,4) ~= 0)

expno  = '55' ; model  = 'BGM'; da_tag =     2;
resol  = 'HRA'; 
otype='EUL'; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));
otype='LAG'; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));

plot2compare_obse;
%plot2compare_enkf;
save_figure; pause(1);
close all; clear all; pause(1);
load('swid.mat'); load('exid.mat');
end

% KURAMOTO-SIVASHINSKY
% DA-free run using Kuramoto-Sivashinsky equation
  % call plot2compare_free for diagnostics
if (swid(2,1) ~= 0)

otype='EUL';
expno  = '30' ; model  = 'KSM'; da_tag =     0;

resol  = 'HRA' ; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));
resol  = 'HR' ; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));

plot2compare_free;
save_figure; pause(1);
close all; clear all; pause(1);
load('swid.mat'); load('exid.mat');

end


% Multirun DA experiments using Kuramoto-Sivashinsky equation
  % call plot_multi_ens for diagnostics
if (swid(2,2) ~= 0)
  if (exid(1) ~= 0)
    %  ensemble size
    otype='LAG';
    expno  = '32_0.5' ; model  = 'KSM'; da_tag =     2;

    etype  = 'N_ens';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));

    plot_multi_ens
    save_figure; pause(1);
    close all; clear all; pause(1);
    load('swid.mat'); load('exid.mat');

  end

  if (exid(2) ~= 0)
  %  inflation factor
    otype='EUL';
    expno  = '31' ; model  = 'KSM'; da_tag =     2;

    etype  = 'inf_fac';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));

    plot_multi_ens
    save_figure; pause(1);
    close all; clear all; pause(1);
    load('swid.mat'); load('exid.mat');
  end

  if (exid(3) ~= 0)
    %  observational error
    otype='EUL';
    expno  = '31' ; model  = 'KSM'; da_tag =     2;

    etype  = 'obs_var';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));

    plot_multi_ens
    save_figure; pause(1);
    close all; clear all; pause(1);
    load('swid.mat'); load('exid.mat');

  end

  if (exid(4) ~= 0)
    %  initial mesh size
    expno  = '31' ; model  = 'KSM'; da_tag =     2;
    
    otype='EUL';
    etype  = 'init_mesh';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
 
    plot_multi_ens
    save_figure; pause(1);
    close all; clear all;pause(1);
    load('swid.mat'); load('exid.mat');
  end
  
     if (exid(5) ~= 0)
    %  jitter
    otype='EUL';
    expno  = '31' ; model  = 'KSM'; da_tag =     2;

    etype  = 'jitter';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype)));

    plot_multi_ens
    save_figure; pause(1);
    close all; clear all;pause(1);
    load('swid.mat'); load('exid.mat');
     end
  
      if (exid(6) ~= 0)
    %  jitter and inflation
    otype='EUL';
    expno  = '31' ; model  = 'KSM'; da_tag =     2;

    etype  = 'jitter_inflation';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    !cp -r FIG/KSM*/* ../2paramdata
%     plot_multi_ens
%     save_figure; pause(1);
%     close all; clear all;pause(1);
%     load('swid.mat'); load('exid.mat');
      end
  
     if (exid(7)~= 0)
    %everything
    otype='EUL';
    expno  = '51' ; model  = 'KSM'; da_tag =     2;

    etype  = 'everything';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    !cp -r FIG/KSM*/* ../5paramdata
   % plot_multi_ens
    %save_figure; pause(1);
    %close all; clear all;pause(1);
    %load('swid.mat'); load('exid.mat');
     end
     
       if (exid(8)~= 0)
    %everything
    otype='EUL';
    expno  = '51' ; model  = 'KSM'; da_tag =     2;

    etype  = 'inflation_jitter_other1d';
    fprintf('Experiment type: %s \n', etype);
    resol  = 'HRA' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    resol  = 'HR' ; multirun
    save(fullfile(plotfolder,strcat('output_',resol,'_',etype,'_',num2str(LHSstart),'_',num2str(LHSfinish))));
    !cp -r FIG/KSM*/* ../3paramdata
   % plot_multi_ens
    %save_figure; pause(1);
    %close all; clear all;pause(1);
    %load('swid.mat'); load('exid.mat');
     end
  
  
end
% Single DA experiments using Kuramoto-Sivashinsky equation comparing HR/LR optimal solution
  % call plot2compare_enkf for diagnostics
if (swid(2,3) ~= 0)

otype='EUL';
expno  = '32' ; model  = 'KSM'; da_tag =     2;

resol  = 'HRA' ; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));
resol  = 'HR' ; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));

plot2compare_enkf;
save_figure; pause(1);
close all; clear all; pause(1);
load('swid.mat');

end

%%%added by justin bennett (delete if not needed)

% Single DA experiments using KSM

% if (swid(2,4) ~= 0)
% 
% expno  = '31' ; model  = 'KSM'; da_tag =  2;
% otype = 'LAG';
% resol  = 'HRA' ; singlerun
% save(fullfile(plotfolder,strcat('output_',resol)));
% resol='HR'; singlerun
% save(fullfile(plotfolder,strcat('output_',resol)));
% 
% plot2compare_obse;
% save_figure; pause(1);
% close all; clear all; pause(1);
% load('swid.mat'); load('exid.mat');
% end

% lagrangian using KSM model
if (swid(2,4) ~= 0)
    
expno  = '0_0.6_01'; %(jitter|inflation|attempt#)
model  = 'KSM'; da_tag =  2;
resol = 'HRA'; 
otype= 'EUL'; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));
otype = 'LAG'; singlerun
save(fullfile(plotfolder,strcat('output_',resol)));

plot2compare_obse; 
%plot2compare_enkf;
save_figure; pause(1);
close all; clear all; pause(1);
load('swid.mat'); load('exid.mat');
end
