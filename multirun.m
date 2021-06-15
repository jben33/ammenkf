

global clim_std xind inf_fac etype ...
       labelx labelt labelp
load LHSparams.mat

if (strcmp(model,'BGM'))
  if (strcmp(etype,'init_mesh'))
   ensparam=[ 50 60 70 80 90 ]; % init_emesh_size
   labelx='Initial Mesh Size';
   labelt='init_mesh';
   labelp='(c)'; 
  elseif (strcmp(etype,'obs_var'))
   ensparam=[ 0.01 0.02 0.03 0.04 0.05 0.06 0.07 ]; % obs_var
   labelx='Observational error';
   labelt='obs_error';
   labelp='(d)';
  elseif (strcmp(etype,'N_ens'))
   ensparam=[ 10 30 40 50 70 90 ]; % N_ens
   labelx='Ensemble size';
   labelt='ens__size';
   labelp='(a)';
  elseif (strcmp(etype,'inf_fac'))
   ensparam=[ 1.0 1.1 1.2 1.3 1.4 1.5 ]; %inf_fac BGM
   labelx='Inflation factor';
   labelt='inflation';
   labelp='(b)';
     elseif (strcmp(etype,'jitter'))
   ensparam=[0 0.001 0.005 0.01 0.05 0.1]; %jitter BGM; 
   labelx='Jitter';
   labelt='Jitter';
   labelp='(e)';
  elseif(strcmp(etype,'jitter_inflation'))
   %LHS=lhsdesign(25,2);
   if(fromlh==1)
   ensparam(1,:)=1+0.6*LHS(LHSstart:LHSfinish,1)';
   ensparam(2,:)=0.1*LHS(LHSstart:LHSfinish,2)';
   else
   ensparam(1,:)=LHS(LHSstart:LHSfinish,1)';
   ensparam(2,:)=LHS(LHSstart:LHSfinish,2)';
   end
  %ensparam(1,:)=[ones(1,11),.06+ones(1,11),.12+ones(1,11),.18+ones(1,11),.24+ones(1,11),.3+ones(1,11),.36+ones(1,11),.42+ones(1,11),.48+ones(1,11),.54+ones(1,11),.6+ones(1,11)];
 %ensparam(2,:)=repmat([0:.1/10:.1],1,11) ; 
  elseif(strcmp(etype,'everything'))
      ensparam(1,:)=LHS(LHSstart:LHSfinish,1)';%inflation
      ensparam(2,:)=LHS(LHSstart:LHSfinish,2)';%jitter
      ensparam(3,:)=LHS(LHSstart:LHSfinish,3)';%obs error
      ensparam(4,:)=LHS(LHSstart:LHSfinish,4)';%ensemble size
      ensparam(5,:)=LHS(LHSstart:LHSfinish,5)';%inital mesh
   elseif(strcmp(etype,'inflation_jitter_other1d')) 
      ensparam(1,:)=LHS(LHSstart:LHSfinish,1)';%inflation
      ensparam(2,:)=LHS(LHSstart:LHSfinish,2)';%jitter
      ensparam(3,:)=LHS(LHSstart:LHSfinish,3)';%Other1d

      

end
end


if (strcmp(model,'KSM'))
clim_std = 7.98; % KSM climate variance
  if (strcmp(etype,'init_mesh'))
   ensparam=[ 50 60 70 80 90 ]; % init_emesh_size
   labelx='Initial Mesh Size';
   labelt='init_mesh';
   labelp='(c)';
  elseif (strcmp(etype,'obs_var'))
   ensparam=[ clim_std*.01 clim_std*.03 clim_std*.06 clim_std*.075 ...
             clim_std*.10 clim_std*.15 clim_std*.20 clim_std*.250]; % KSM observational error
   labelx='Observational error';
   labelt='obs_error';
   labelp='(d)';
  elseif (strcmp(etype,'N_ens'))
   ensparam=[ 20 30 40 50 70 90 ]; % N_ens
   labelx='Ensemble size';
   labelt='ens__size';
   labelp='(a)';
  elseif (strcmp(etype,'inf_fac'))
   ensparam=[1.2 1.3 1.5 1.6 1.8 1.9];%[ 1.0 1.1 1.2 1.3 1.5]; %inf_fac KSM
   labelx='Inflation factor';
   labelt='inflation';
   labelp='(b)';
  elseif (strcmp(etype,'jitter'))
   ensparam=[0 0.05 0.1 0.5]; %jitter ksm; 
   labelx='Jitter';
   labelt='jitter';
   labelp='(e)';
elseif(strcmp(etype,'jitter_inflation'))
   if(fromlh==1)
   ensparam(1,:)=1+0.6*LHS(LHSstart:LHSfinish,1)';
   ensparam(2,:)=0.5*LHS(LHSstart:LHSfinish,2)';
   else
   ensparam(1,:)=LHS(LHSstart:LHSfinish,1)';
   ensparam(2,:)=LHS(LHSstart:LHSfinish,2)';
   end
   
elseif(strcmp(etype,'everything'))
      ensparam(1,:)=LHS(LHSstart:LHSfinish,1)';%inflation
      ensparam(2,:)=LHS(LHSstart:LHSfinish,2)';%jitter
      ensparam(3,:)=LHS(LHSstart:LHSfinish,3)';%obs error
      ensparam(4,:)=LHS(LHSstart:LHSfinish,4)';%ensemble size
      ensparam(5,:)=LHS(LHSstart:LHSfinish,5)';%inital mesh
elseif(strcmp(etype,'inflation_jitter_other1d')) 
      ensparam(1,:)=LHS(LHSstart:LHSfinish,1)';%inflation
      ensparam(2,:)=LHS(LHSstart:LHSfinish,2)';%jitter
      ensparam(3,:)=LHS(LHSstart:LHSfinish,3)';%Other1d

  end
end



if(strcmp(etype,'jitter_inflation'))
en_size=size(ensparam,2);


for kk = 1:en_size
 xind=[0,0];
 xind(1) = ensparam(1,kk)
 xind(2) =ensparam(2,kk)
 run_AMMEnKF
  insize=length(da_times);

  %ststemp(kk).(resol) = resol;
  %ststemp2(kk).(resol)  = [xind(1) xind(2)];
  %ststemp3(kk).(resol) = mean(fc_rmse(21:insize));
  %ststemp4(kk).(resol)  = mean(an_rmse(21:insize));
  %ststemp5(kk).(resol)  = mean(fc_cov_trace(21:insize).^0.5);
  %ststemp6(kk).(resol)  = mean(an_cov_trace(21:insize).^0.5);
  
  
  sts(kk,1).(resol) = resol;
  sts(kk,2).(resol) = xind(1);
  sts(kk,3).(resol) = xind(2);
% %  sts(kk,3).(resol) = mean(fc_rmse((insize-1)/2:insize));
% %  sts(kk,4).(resol) = mean(an_rmse((insize-1)/2:insize));
% %  sts(kk,5).(resol) = mean(fc_cov_trace((insize-1)/2:insize).^0.5);
% %  sts(kk,6).(resol) = mean(an_cov_trace((insize-1)/2:insize).^0.5);
% 
% %half interval first
   sts(kk,4).(resol) = mean(fc_rmse(20:insize));
   sts(kk,5).(resol) = mean(an_rmse(20:insize));
   sts(kk,6).(resol) = mean(fc_cov_trace(20:insize).^0.5);
   sts(kk,7).(resol) = mean(an_cov_trace(20:insize).^0.5);
   sts(kk,8).(resol) = mean(fc_rmseD(20:insize));
   sts(kk,9).(resol) = mean(an_rmseD(20:insize));
   sts(kk,10).(resol) = mean(fc_cov_traceD(20:insize).^0.5);
   sts(kk,11).(resol) = mean(an_cov_traceD(20:insize).^0.5);
   sts(kk,12).(resol) = mean(fc_rmseH(20:insize));
   sts(kk,13).(resol) = mean(an_rmseH(20:insize));

   

end

elseif(strcmp(etype,'everything'))
en_size=size(ensparam,2);


for kk = 1:en_size
 xind=[0,0,0,0,0];
 xind(1) = ensparam(1,kk)
 xind(2) =ensparam(2,kk)
 xind(3) =ensparam(3,kk)
 xind(4)=ensparam(4,kk)
 xind(5)=ensparam(5,kk)
 run_AMMEnKF
  insize=length(da_times);

  %ststemp(kk).(resol) = resol;
  %ststemp2(kk).(resol)  = [xind(1) xind(2)];
  %ststemp3(kk).(resol) = mean(fc_rmse(21:insize));
  %ststemp4(kk).(resol)  = mean(an_rmse(21:insize));
  %ststemp5(kk).(resol)  = mean(fc_cov_trace(21:insize).^0.5);
  %ststemp6(kk).(resol)  = mean(an_cov_trace(21:insize).^0.5);
  
  
  sts(kk,1).(resol) = resol;
  sts(kk,2).(resol) = xind(1);
  sts(kk,3).(resol) = xind(2);
  sts(kk,4).(resol) = xind(3);
  sts(kk,5).(resol) = xind(4);
  sts(kk,6).(resol) = xind(5);
% %  sts(kk,3).(resol) = mean(fc_rmse((insize-1)/2:insize));
% %  sts(kk,4).(resol) = mean(an_rmse((insize-1)/2:insize));
% %  sts(kk,5).(resol) = mean(fc_cov_trace((insize-1)/2:insize).^0.5);
% %  sts(kk,6).(resol) = mean(an_cov_trace((insize-1)/2:insize).^0.5);
% 
% %half interval first
   sts(kk,7).(resol) = mean(fc_rmse(20:insize));
   sts(kk,8).(resol) = mean(an_rmse(20:insize));
   sts(kk,9).(resol) = mean(fc_cov_trace(20:insize).^0.5);
   sts(kk,10).(resol) = mean(an_cov_trace(20:insize).^0.5);
   sts(kk,11).(resol) = mean(fc_rmseD(20:insize));
   sts(kk,12).(resol) = mean(an_rmseD(20:insize));
   sts(kk,13).(resol) = mean(fc_cov_traceD(20:insize).^0.5);
   sts(kk,14).(resol) = mean(an_cov_traceD(20:insize).^0.5);
    sts(kk,15).(resol) = mean(fc_rmseH(20:insize));
   sts(kk,16).(resol) = mean(an_rmseH(20:insize));
   

end

elseif(strcmp(etype,'inflation_jitter_other1d'))
en_size=size(ensparam,2);


for kk = 1:en_size
 xind=[0,0,0];
 xind(1) =ensparam(1,kk)
 xind(2) =ensparam(2,kk)
 xind(3) =ensparam(3,kk)
 run_AMMEnKF
  insize=length(da_times);

  %ststemp(kk).(resol) = resol;
  %ststemp2(kk).(resol)  = [xind(1) xind(2)];
  %ststemp3(kk).(resol) = mean(fc_rmse(21:insize));
  %ststemp4(kk).(resol)  = mean(an_rmse(21:insize));
  %ststemp5(kk).(resol)  = mean(fc_cov_trace(21:insize).^0.5);
  %ststemp6(kk).(resol)  = mean(an_cov_trace(21:insize).^0.5);
  
  
  sts(kk,1).(resol) = resol;
  sts(kk,2).(resol) = xind(1);
  sts(kk,3).(resol) = xind(2);
  sts(kk,4).(resol)=xind(3);
% %  sts(kk,3).(resol) = mean(fc_rmse((insize-1)/2:insize));
% %  sts(kk,4).(resol) = mean(an_rmse((insize-1)/2:insize));
% %  sts(kk,5).(resol) = mean(fc_cov_trace((insize-1)/2:insize).^0.5);
% %  sts(kk,6).(resol) = mean(an_cov_trace((insize-1)/2:insize).^0.5);
% 
% %half interval first
   sts(kk,5).(resol) = mean(fc_rmse(20:insize));
   sts(kk,6).(resol) = mean(an_rmse(20:insize));
   sts(kk,7).(resol) = mean(fc_cov_trace(20:insize).^0.5);
   sts(kk,8).(resol) = mean(an_cov_trace(20:insize).^0.5);
   sts(kk,9).(resol) = mean(fc_rmseD(20:insize));
   sts(kk,10).(resol) = mean(an_rmseD(20:insize));
   sts(kk,11).(resol) = mean(fc_cov_traceD(20:insize).^0.5);
   sts(kk,12).(resol) = mean(an_cov_traceD(20:insize).^0.5);
    sts(kk,13).(resol) = mean(fc_rmseH(20:insize));
    sts(kk,14).(resol) = mean(an_rmseH(20:insize));
    sts(kk,15).(resol)=Ean_vars;
    sts(kk,16).(resol)=Ean_kurts;
    sts(kk,17).(resol)=Ean_rmses;
    sts(kk,19).(resol)=Efc_vars;
    sts(kk,20).(resol)=Efc_kurts;
    sts(kk,21).(resol)=Efc_rmses;

end

else
en_size=size(ensparam,2);
for kk = 1:en_size
 xind = ensparam(kk);
 run_AMMEnKF
 insize=length(da_times);

 sts(kk,1).(resol) = resol;
 sts(kk,2).(resol) = xind;
%  sts(kk,3).(resol) = mean(fc_rmse((insize-1)/2:insize));
%  sts(kk,4).(resol) = mean(an_rmse((insize-1)/2:insize));
%  sts(kk,5).(resol) = mean(fc_cov_trace((insize-1)/2:insize).^0.5);
%  sts(kk,6).(resol) = mean(an_cov_trace((insize-1)/2:insize).^0.5);

%half interval first
  sts(kk,3).(resol) = mean(fc_rmse(20:insize));
  sts(kk,4).(resol) = mean(an_rmse(20:insize));
  sts(kk,5).(resol) = mean(fc_cov_trace(20:insize).^0.5);
  sts(kk,6).(resol) = mean(an_cov_trace(20:insize).^0.5);

end
end
%if (en_size > 1)
% plot_multi_ens
%end
