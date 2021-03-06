global d1

Nup=size(A_full,2); % using Nup below since the state space dimension changes. 

if(strcmp(resol, 'HR') || strcmp(resol,'LR'))
    Nup=N;
end
    

if(strcmp(resol,'HRA'))

ind_fc_ens_sts{i+1}=A_full;

  %Nup=2*Nup;  
  for j=1:N_ens
   innov = obs_vals{i}{j} - ... %+normrnd(0,sqrt(obs_var),1,length(obs_vals{i}))-...
        get_HA(A_full(j,:),obs_locs{i})';
    if ( da_tag == 0 )
	    A_full(j,1:Nup) = A_full(j,1:Nup);
    else
%         size( A_full(j,1:Nup))
%         size((K*innov')')
      %figure;
      Temp= A_full(j,1:Nup);
	 % size(A_full)
      %size(K)
      %size(innov')
      A_full(j,1:Nup) = A_full(j,1:Nup)+(K*innov')';
              
%         blarg=K*innov';
%         plot(blarg)
%         blarg2=blarg(101:200);
%         max(blarg2(:))
%         size(K*innov')
%         
%         pause
      
      
    
%       is2small=A_full(j,Nup/2+1:Nup)<left;
%       is2big=A_full(j,Nup/2+1:Nup)>right;
%       if (max(is2small)>0 && max(is2big)==0)
%           A_full(j,Nup/2+is2small)=left;
%           A_full(j,is2small)=A_full(j,Nup);
%  %          display('small')
% %           find(is2small==1)
% %           pause;
%       end
%       if( max(is2big)>0 && max(is2small)==0 )
%           A_full(j,Nup/2+is2big)=right;
%           A_full(j,is2big)=A_full(j,Nup/2+1);
% %           display('big')
% %           find(is2big==1)
% %           pause;
%       end
%       if( max(is2big)>0 && max(is2small)>0 )
%           A_full(j,Nup/2+is2big)=right;
%           A_full(j,Nup/2+is2small)=left;
%           A_full(j,is2big)=mean([A_full(j,is2small),A_full(j,is2big)]);
% %           display('big')
% %           find(is2big==1)
% %           pause;
%       end
      
%sort them if z's were switched
      fctu=A_full(j,1:Nup/2);
      fctz=A_full(j,Nup/2+1:Nup);
      tooleft=fctz < left;
      tooright=fctz > right;
      %ml=0;
      %mr=0;
%       if (length(fctz(tooleft))>ml)
%       ml=length(fctz(tooleft))
%       end
%       
%       if (length(fctz(tooright))>mr)
%       mr=length(fctz(tooright))
%       end
%        fctz(tooleft)=left;%right - abs(fctz(tooleft)-left);
%       fctz(tooright)=right;% left + abs(fctz(tooright)-right);
%       trash=isnan(fctz);
%       fctu(trash)=NupaNup;
      %fctz=fctz(~isnan(fctz));
      %fctu=fctu(~isnan(fctu));
%         %plot(fctz,fctu,'o')
%         %hold on
%       
          


          [fctz, fczi]=sort(fctz);
          fctu=fctu(fczi);
          if(fctz(1)<left+d1/2 && abs(fctz(1)-left)<abs(fctz(Nup/2)-right))% && fctz(Nup/2)>right-d1/2 )
          fctu(Nup/2)=fctu(1);
         
          elseif(fctz(Nup/2)>right-d1/2 && abs(fctz(Nup/2)-right)<abs(fctz(1)-left))% && fctz(1)<left+d1/2 )
          fctu(1)=fctu(Nup/2);
          end


          
          
           %fctu(1)=fctu(Nup/2);
%           fctu(Nup/2)=fctu(1);
    %      fctz(1)=left;
     %     fctz(Nup/2)=right;
          A_full(j,:)=[fctu fctz];
          
%        % plot(fctz,fctu,'o')
%        % hold off

 %B=[A_full(:,3:Nup/2-2),A_full(:,Nup/2+3:Nup-2)];
 %A_full=B;
 %clear B
 %Nup=Nup-8
 
 


%remesh
 [T_full1(j,:),T_full2(j,:)]=remesh(A_full(j,1:Nup/2),A_full(j,Nup/2+1:Nup));
  
   %T_full(j,:)=[T_full1,T_full2];
   
 % clear T_full1
  % clear T_full2
  Nup=Nup/2;
  T_fullfill{1}=[T_full1(j,:),T_full2(j,:)];
  [T_full]=embed_HRA(T_fullfill);
  T_full2=fill_in_HRA(T_full);
  A_full(j,:)=T_full2;
  clear T_full;
  clear T_full2;
  clear T_full1;
  clear T_fullfill;
 Nup=2*Nup;





%       
%   %plotting results    
%        plot(Temp(Nup/2+1:5:Nup),Temp(1:5:Nup/2),'g+')
%        hold on
%        %pause
%         plot(A_full(j,Nup/2+1:5:Nup),A_full(j,1:5:Nup/2),'bo')
%         hold on
%         %plot([0:1/99:1],u(time,:))
%         plot([left:(right-left)/(length(u(time,:))-1):right],u(time,:),'Color','r','LineWidth',2)
%         %sc=u_at(da_times(i+1),[0+d1/2:d1:1-d1/2]); % should be i or i+1?
%         %plot([0+d1/2:d1:1-d1/2],sc)
%         pause(0.0001)
%          %pause
%         hold off
       
%         zup=K*innov';
%         zups=zup(Nup/2+1:Nup);
%         if(max(abs(zups(:))~=0))
%             zups
%             display('A z value was updated!!!')
%             pause;
%             close;
%         end;
       % plot(Temp(Nup/2+1:Nup)-A_full(j,Nup/2+1:Nup),'o')
        %figure
        %imagesc((K*innov')')
        %pause;
        
    end
end
    
    
elseif(strcmp(resol,'US')) 
    for j=1:N_ens
   
    innov = obs_vals{i}{j} - ... %+normrnd(0,sqrt(obs_var),1,length(obs_vals{i}))-...
        get_HA(A_full(j,:),obs_locs{i})';
    if ( da_tag == 0 )
	    A_full(j,1:Nup) = A_full(j,1:Nup);
    else
        Temp= A_full(j,1:Nup);
        A_full(j,1:Nup) = A_full(j,1:Nup)+(K*innov')';
        groupinnovations{j}=(K*innov')';
       % plot(A_full(j,Nup/2+1:Nup),A_full(j,1:Nup/2),'*')
   
        
    end

 
    
    
    %sort them if z's were switched
      fctu=A_full(j,1:Nup/2);
      fctz=A_full(j,Nup/2+1:Nup);
      tooleft=fctz < left;
      tooright=fctz > right;
      %ml=0;
      %mr=0;
%       if (length(fctz(tooleft))>ml)
%       ml=length(fctz(tooleft))
%       end
%       
%       if (length(fctz(tooright))>mr)
%       mr=length(fctz(tooright))
%       end
       
    fctz(tooleft)=left+abs(normrnd(0,0.001,1,sum(tooleft)));%right - abs(fctz(tooleft)-left);
       
     fctz(tooright)=right-abs(normrnd(0,0.001,1,sum(tooright)));% + abs(fctz(tooright)-right);
%       trash=isnan(fctz);
%       fctu(trash)=NaN;
      %fctz=fctz(~isnan(fctz));
      %fctu=fctu(~isnan(fctu));
%         %plot(fctz,fctu,'o')
%         %hold on
%       
          [fctz, fczi]=sort(fctz);
          fctu=fctu(fczi);
         %fctu(1)=fctu(Nup/2);
         %fctu(Nup/2)=fctu(1);
      
        
         
 A_full(j,:)=[fctu fctz];
         
         
 %if (strcmp(resol, 'US'))         
%[T_full1(j,:),T_full2(j,:)]=remesh(A_full(j,1:Nup/2),A_full(j,Nup/2+1:Nup));
  
%T_full{j,1}=[T_full1(j,:),T_full2(j,:)];
   
 %clear T_full1
 %clear T_full2
 end
   %Nup=Nup/2;
  % T_fullfill{1}=[T_full1(j,:),T_full2(j,:)];
  %[T_full,~]=embed_US(T_fullfill,size(A_full,2)/2);
%T_full=embed_HR(T_fullfill);
%T_full2=fill_in(T_full);
 %  A_fulltemp(j,:)=T_full2;
  % clear T_full;
  %clear T_full2;
  % clear T_full1;
  % clear T_fullfill;
  % Nup=2*Nup;
         
%         plot(Temp(Nup/2+1:Nup),Temp(1:Nup/2),'o')
%         hold on
%         plot(A_full(j,Nup/2+1:Nup),A_full(j,1:Nup/2),'+')
%         hold on
%        % sc=u_at(da_times(i),[0+d1/2:d1:1-d1/2]);
%         %plot([0+d1/2:d1:1-d1/2],sc)
%         hold on
%         plot([0:1/99:1],u(time,:))
%         pause
%         %pause
%        %pause
%          hold off
    
    
%end

an_ensemble = A_full;
%[A_full,gnums]=embed_US(T_full,0);
%A_full=A_fulltemp;
%Nup=size(A_full,2);
%clear A_fulltemp
for k=1:N_ens
        k
        for jj=1:length(gnums{k}{1})
        fc{k}(idxu{k}==gnums{k}{1}(jj))=fc{k}(idxu{k}==gnums{k}{1}(jj))+groupinnovations{k}(jj);
        fc{k}(idxz{k}==gnums{k}{1}(jj))=fc{k}(idxz{k}==gnums{k}{1}(jj))+groupinnovations{k}(jj+length(groupinnovations{k})/2);
        %plot(fc{k}(length(fc{k})/2+1:length(fc{k})),fc{k}(1:length(fc{k})/2),'*')
%         figure 
%         plot(groupinnovations{k})
%         figure
%         plot(groupinnovations{k}(jj),'o')
%         hold on
%         plot(groupinnovations{k}(2*jj),'*')
         %pause
        end
        %plot(fc{k}(length(fc{k})/2+1:length(fc{k})),fc{k}(1:length(fc{k})/2),'*')
%        figure
%         plot(groupinnovations{k})
        % pause
%        pause(0.001)
end


elseif(strcmp(resol,'HR') || strcmp(resol,'LR'))
ind_fc_ens_sts{i+1}=A_full;
    for j=1:N_ens
    innov = obs_vals{i}{j} - ... %+normrnd(0,sqrt(obs_var),1,length(obs_vals{i}))-...
        get_HA(A_full(j,:),obs_locs{i})';
    if ( da_tag == 0 )
	    A_full(j,1:Nup) = A_full(j,1:Nup);
    else
	    A_full(j,1:Nup) = A_full(j,1:Nup)+(K*innov')';
        
%         blarg=K*innov';
%         plot(blarg)
%         blarg2=blarg(101:200);
%         max(blarg2(:))
%         size(K*innov')
%         
%         pause
    end
end
    

end 
an_ensemble = A_full;
close all
%if (strcmp(resol , 'HR'))
% for ii=1:N_ens
%     memdiff(ii,:)=A_full(ii,1:Nup/2-1)-u_at(da_times(i),A_full(ii,Nup/2+1:Nup-1));
%   
%     plot(A_full(ii,Nup/2+1:Nup),(A_full(ii,1:Nup/2)))
%     plot(A_full(ii,Nup/2+1:Nup),gradient(A_full(ii,1:Nup/2),A_full(ii,Nup/2+1:Nup)));
%     hold on
%    %plot([left:(right-left)/(length(u(time,:))-1):right],(u(time,:)),'Color','Black')
%    plot([left:(right-left)/(length(u(time,:))-1):right],gradient(u(time,:),[left:(right-left)/(length(u(time,:))-1):right])); 
%    pause(0.5)
%     hold off
%     memdiff2(ii,:)=memdiff(ii,:).^2;
%     memrms(ii,i)=sqrt(sum(memdiff2(ii,:))/(Nup/2-1));
% end
%end
%an_means(i+1,:) = ens_mean(A_full);
an_means{i+1} = ens_mean(A_full);

% if(strcmp(resol,'HR'))
%      Nup=2*Nup;
%  end;
% 
%  plot(an_means{i+1}(Nup/2+1:Nup),an_means{i+1}(1:Nup/2),'+')
%  %plot(an_means{i+1}(Nup+1:2*Nup),an_means{i+1}(1:Nup),'+')
% 
%  hold on
%  plot([left:(right-left)/(length(u(time,:))-1):right],u(time,:))
%  hold off
%  pause(0.001)
 
 
 %pause
 
 %to look at gradients of means
 
% 
%  plot(an_means{i+1}(Nup/2+1:Nup),gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup)),'LineWidth',3);%,'+')
%  %plot(an_means{i+1}(Nup+1:2*Nup),an_means{i+1}(1:Nup),'+')
%  %plot(an_means{i+1}(Nup/2+1:Nup),gradient(gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup)),an_means{i+1}(Nup/2+1:Nup)),'LineWidth',3)%,'+')
%   %plot(abs(fft(gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup)))))
% 
%  hold on
%  plot([left:(right-left)/(length(u(time,:))-1):right],gradient(u(time,:),[left:(right-left)/(length(u(time,:))-1):right]),'LineWidth',3)
%  %plot([left:(right-left)/(length(u(time,:))-1):right],gradient(gradient(u(time,:),[left:(right-left)/(length(u(time,:))-1):right]),[left:(right-left)/(length(u(time,:))-1):right]),'LineWidth',3)
%   %plot(abs(fft(gradient(u(time,:),[left:(right-left)/(length(u(time,:))-1):right]))))
% 
%  hold off
%  %trapz(gradient(u(time,:),[left:(right-left)/(length(u(time,:))-1):right]),[left:(right-left)/(length(u(time,:))-1):right])
%  pause(1)
%  
%   if(strcmp(resol,'HR'))
%      Nup=Nup/2;
%  end;
 
 
% if(strcmp(resol,'HRA'))
%  %fdistHRA(i)=frechet(an_means{i+1}(Nup/2+1:Nup)',gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup))',[left:(right-left)/(length(u(time,:))-1):right]',gradient(u(time,:),[left:(right-left)/(length(u(time,:))-1):right])')
%   %fdistHRA(i)=frechet(an_means{i+1}(Nup/2+1:Nup)',an_means{i+1}(1:Nup/2)',an_means{i+1}(Nup/2+1:Nup)',[left:(right-left)/(length(u(time,:))-1):right]',u(time,:)')
%   %fdistHRA(i)=procrustes([an_means{i+1}(Nup/2+1:Nup)',gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup))'],[[left:(right-left)/(length(u(time,:))-1):right]',gradient(u(time,:),[left:(right-left)/(length(u(time,:))-1):right])'])
%   %fdistHRA(i)=trapz(an_means{i+1}(Nup/2+1:Nup),(gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup))-gradient(u_at(da_times(i+1),an_means{i+1}(Nup/2+1:Nup)),an_means{i+1}(Nup/2+1:Nup))).^2)
%   [La,Ra,Ka] = curvature([an_means{i+1}(Nup/2+1:Nup)',gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup))']);
%   [Lt,Rt,Kt] = curvature([an_means{i+1}(Nup/2+1:Nup)',gradient(u_at(da_times(i+1),an_means{i+1}(Nup/2+1:Nup)),an_means{i+1}(Nup/2+1:Nup))']);
%   fdistHRA(i)=norm(La(~isnan(La))-Lt(~isnan(Lt)))/length(La(~isnan(La)));
%   %fdistHRA(i)=norm([La(~isnan(La))',Ra(~isnan(Ra))']-[Lt(~isnan(Lt))',Rt(~isnan(Rt))'])
%    fdistHRA(i)=var(gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup))-gradient(u_at(da_times(i+1),an_means{i+1}(Nup/2+1:Nup)),an_means{i+1}(Nup/2+1:Nup)))
% 
% %   plot(La,Ra)
% %   hold on
% %   plot(Lt,Rt)
% %   hold off
% %   pause(1)
%   save('fdistHRA.mat','fdistHRA')
% end;
%  
%  if(strcmp(resol,'HR'))
%      Nup=2*N;
%  %fdistHR(i)=frechet(an_means{i+1}(Nup/2+1:Nup)',gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup))',[left:(right-left)/(length(u(time,:))-1):right]',gradient(u(time,:),[left:(right-left)/(length(u(time,:))-1):right])')
%  %fdistHR(i)=frechet(an_means{i+1}(Nup/2+1:Nup)',an_means{i+1}(1:Nup/2)',an_means{i+1}(Nup/2+1:Nup)',[left:(right-left)/(length(u(time,:))-1):right]',u(time,:)')
%  %fdistHR(i)=procrustes([an_means{i+1}(Nup/2+1:Nup)',gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup))'],[[left:(right-left)/(length(u(time,:))-1):right]',gradient(u(time,:),[left:(right-left)/(length(u(time,:))-1):right])'])
%  % fdistHR(i)=trapz(an_means{i+1}(Nup/2+1:Nup),(gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup))-gradient(u_at(da_times(i+1),an_means{i+1}(Nup/2+1:Nup)),an_means{i+1}(Nup/2+1:Nup))).^2)
%  [La,Ra,Ka] = curvature([an_means{i+1}(Nup/2+1:Nup)',gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup))']);
%   [Lt,Rt,Kt] = curvature([an_means{i+1}(Nup/2+1:Nup)',gradient(u_at(da_times(i+1),an_means{i+1}(Nup/2+1:Nup)),an_means{i+1}(Nup/2+1:Nup))']);
% %    plot(La,Ra)
% %   hold on
% %   plot(Lt,Rt)
% %   hold off
% %   pause(1)
%   fdistHR(i)=norm(La(~isnan(La))-Lt(~isnan(Lt)))/length(La(~isnan(La)));
%  %fdistHR(i)=norm([La(~isnan(La))',Ra(~isnan(Ra))']-[Lt(~isnan(Lt))',Rt(~isnan(Rt))'])
%  %fdistHR(i)=var(gradient(an_means{i+1}(1:Nup/2),an_means{i+1}(Nup/2+1:Nup))-gradient(u_at(da_times(i+1),an_means{i+1}(Nup/2+1:Nup)),an_means{i+1}(Nup/2+1:Nup)))
%   Nup=N;
%  save('fdistHR.mat','fdistHR')
% 
%  end;

A = A_full(:,1:Nup)';

%A_bar = repmat(an_means(i+1,1:Nup),N_ens,1)';
A_bar = repmat(an_means{i+1}(1:Nup),N_ens,1)';


A_prime = 1/sqrt(N_ens-1)*(A-A_bar);

% if(strcmp(resol, 'HRA') && divtrue==0)
         ifm.stat=[1:Nup];
% elseif(strcmp(resol, 'HRA') && divtrue==1)
%          ifm.stat=[1:Nup/2];
% elseif(strcmp(resol, 'HR'))
%        ifm.stat=[1:Nup];
% end

%if(divtrue==0)
Adiag = A_full(:,ifm.stat)';
A_bar_diag = repmat(an_means{i+1}(ifm.stat),N_ens,1)'; 
A_prime_diag = 1/sqrt(N_ens-1)*(Adiag-A_bar_diag);
an_cov = A_prime_diag*A_prime_diag';
an_cov_trace(i+1) = sum(diag(an_cov))/length(ifm.stat);
%elseif(divtrue==1)

if(strcmp(resol,'HRA'))
ifm.stat=[1:Nup/2];
end

for kd=1:N_ens
AdiagD(:,kd) = gradient(A_full(kd,ifm.stat),A_full(kd,ifm.stat+N))';
end

A_bar_diagD = repmat(gradient(an_means{i+1}(ifm.stat),an_means{i+1}(ifm.stat+N)),N_ens,1)'; 
A_prime_diagD = 1/sqrt(N_ens-1)*(AdiagD-A_bar_diagD);
an_covD = A_prime_diagD*A_prime_diagD';
an_cov_traceD(i+1) = sum(diag(an_covD))/length(ifm.stat);
%end
%store intividual ens members 
ind_an_ens_sts{i+1}=A_full;



% here was using ifm.stat to get node locations to look at variances. 
%if(strcmp(resol, 'HRA'))
%    for i=1:N_ens
%        
%        plot(A_full(i,ifm.stat),i*ones(1,length(ifm.stat)),'o')
%        hold on
%      
%    end
% varplt=var(A_full(:,ifm.stat));
% plot(varplt)
%    pause
%end


% imagesc(an_cov)
% pause;
% 
% Zdiag=A_full(:,1+Nup/2:Nup)';
% Z_bar_diag=repmat(an_means{i+1}(1+Nup/2:Nup),N_ens,1)';
% Z_prime_diag = 1/sqrt(N_ens-1)*(Zdiag-Z_bar_diag);
% Zn_cov = Z_prime_diag*Z_prime_diag';
% Zn_cov_trace(i+1) = sum(diag(Zn_cov))/length(Nup/2);
% 
% imagesc(Zn_cov)
% pause;
