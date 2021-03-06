fc_rmse = nan(1,num_steps+1);
an_rmse = nan(1,num_steps+1);
%pause;
%RMSE for physical u values
%if(divtrue==0 && h1norm==0)
    
    
for i=2:num_steps+1
    %fdiff = fc_means(i,ifm.stat)-u_at(da_times(i),fc_means(i,ifm.mesh));
    ifm.stat=[1:length(fc_means{i})/2];
    ifm.mesh=[length(fc_means{i})/2+1:length(fc_means{i})];
    fdiff = fc_means{i}(ifm.stat)-u_at(da_times(i),fc_means{i}(ifm.mesh));
    fdiff2 = fdiff.^2;
%     plot(fc_means{i}(ifm.mesh),fc_means{i}(ifm.stat),'*','Color', 'blue')
%     hold on
%     plot(fc_means{i}(ifm.mesh),u_at(da_times(i),fc_means{i}(ifm.mesh)),'o','Color', 'blue')
%     pause(0.001);
%     hold off
    fc_rmse(i) = sqrt(sum(fdiff2)/length(ifm.mesh));
    %adiff = an_means(i,ifm.stat)-u_at(da_times(i),an_means(i,ifm.mesh));
    ifm.stat=[1:length(an_means{i})/2];
    ifm.mesh=[length(an_means{i})/2+1:length(an_means{i})];
    adiff = an_means{i}(ifm.stat)-u_at(da_times(i),an_means{i}(ifm.mesh));
    adiff2 = adiff.^2;
%      plot(an_means{i}(ifm.mesh),an_means{i}(ifm.stat),'*','Color', 'red')
%     hold on
%     plot(an_means{i}(ifm.mesh),u_at(da_times(i),an_means{i}(ifm.mesh)),'o','Color', 'red')
%     pause(0.001);
%     hold off
    an_rmse(i) = sqrt(sum(adiff2)/length(ifm.mesh));
    
    for k=1:N_ens
    Ean_vars(i,k)=var(ind_an_ens_sts{i}(k,ifm.mesh)-u_at(da_times(i),ind_an_ens_sts{i}(k,ifm.mesh)));
    Ean_kurts(i,k)=kurtosis(ind_an_ens_sts{i}(k,ifm.mesh)-u_at(da_times(i),ind_an_ens_sts{i}(k,ifm.mesh)));
    Ean_rmses(i,k)=sqrt(mean((ind_an_ens_sts{i}(k,ifm.mesh)-u_at(da_times(i),ind_an_ens_sts{i}(k,ifm.mesh))).^2));
    
    Efc_vars(i,k)=var(ind_fc_ens_sts{i}(k,ifm.mesh)-u_at(da_times(i),ind_fc_ens_sts{i}(k,ifm.mesh)));
    Efc_kurts(i,k)=kurtosis(ind_fc_ens_sts{i}(k,ifm.mesh)-u_at(da_times(i),ind_fc_ens_sts{i}(k,ifm.mesh)));
    Efc_rmses(i,k)=sqrt(mean((ind_fc_ens_sts{i}(k,ifm.mesh)-u_at(da_times(i),ind_fc_ens_sts{i}(k,ifm.mesh))).^2));
    end

end

%error stats for first derivative
%elseif(divtrue==1 && h1norm==0)
    
  
for i=2:num_steps+1
    %fdiff = fc_means(i,ifm.stat)-u_at(da_times(i),fc_means(i,ifm.mesh));
    %ifm.stat=[2:length(fc_means{i})/2-1];
    ifm.stat=[1:length(fc_means{i})/2];
   % ifm.mesh=[length(fc_means{i})/2+2:length(fc_means{i})-1];
    ifm.mesh=[length(fc_means{i})/2+1:length(fc_means{i})];
    %fdiff = fc_means{i}(ifm.stat)-u_at(da_times(i),fc_means{i}(ifm.mesh));
    %fdiff2 = fdiff.^2;
    Dfdiff = gradient(fc_means{i}(ifm.stat),fc_means{i}(ifm.mesh))-gradient(u_at(da_times(i),fc_means{i}(ifm.mesh)),fc_means{i}(ifm.mesh));
    Dfdiff2 = (Dfdiff).^2;
%     plot(fc_means{i}(ifm.mesh),fc_means{i}(ifm.stat),'*','Color', 'blue')
%     hold on
%     plot(fc_means{i}(ifm.mesh),u_at(da_times(i),fc_means{i}(ifm.mesh)),'o','Color', 'blue')
%     pause%(0.001);
%     hold off
    %fc_rmse(i) = sqrt(sum(fdiff2)/length(ifm.mesh));
    %fc_rmse(i)=sqrt((1/(right-left))*trapz(fc_means{i}(ifm.mesh),fdiff2+Dfdiff2));
    fc_rmseD(i) = sqrt(sum(Dfdiff2)/length(ifm.mesh));
    %adiff = an_means(i,ifm.stat)-u_at(da_times(i),an_means(i,ifm.mesh));
    %ifm.stat=[2:length(an_means{i})/2-1];
    ifm.stat=[1:length(an_means{i})/2];
    %ifm.mesh=[length(an_means{i})/2+2:length(an_means{i})-1];
    ifm.mesh=[length(an_means{i})/2+1:length(an_means{i})];
    %adiff = an_means{i}(ifm.stat)-u_at(da_times(i),an_means{i}(ifm.mesh));
    %adiff2 = adiff.^2;
    Dadiff = gradient(an_means{i}(ifm.stat),an_means{i}(ifm.mesh))-gradient(u_at(da_times(i),an_means{i}(ifm.mesh)),an_means{i}(ifm.mesh));
    Dadiff2 = (Dadiff).^2;
    
%     plot(an_means{i}(ifm.mesh),an_means{i}(ifm.stat),'*','Color', 'red')
%     hold on
%     plot(an_means{i}(ifm.mesh),u_at(da_times(i),an_means{i}(ifm.mesh)),'o','Color', 'red')
%     pause(0.001);
%     hold off
    %an_rmse(i) = sqrt(sum(adiff2)/length(ifm.mesh));
    %an_rmse(i)=sqrt((1/(right-left))*trapz(an_means{i}(ifm.mesh),adiff2+Dadiff2));
    an_rmseD(i) = sqrt(sum(Dadiff2)/length(ifm.mesh));
end


%Error stats with H1 norm derivatives
%elseif(divtrue==1 && h1norm==1)
for i=2:num_steps+1
    %fdiff = fc_means(i,ifm.stat)-u_at(da_times(i),fc_means(i,ifm.mesh));
    %ifm.stat=[2:length(fc_means{i})/2-1];
    ifm.stat=[1:length(fc_means{i})/2];
   % ifm.mesh=[length(fc_means{i})/2+2:length(fc_means{i})-1];
    ifm.mesh=[length(fc_means{i})/2+1:length(fc_means{i})];
    fdiff = fc_means{i}(ifm.stat)-u_at(da_times(i),fc_means{i}(ifm.mesh));
    fdiff2 = fdiff.^2;
    Dfdiff = gradient(fc_means{i}(ifm.stat),fc_means{i}(ifm.mesh))-gradient(u_at(da_times(i),fc_means{i}(ifm.mesh)),fc_means{i}(ifm.mesh));
    Dfdiff2 = (Dfdiff).^2;
%     plot(fc_means{i}(ifm.mesh),fc_means{i}(ifm.stat),'*','Color', 'blue')
%     hold on
%     plot(fc_means{i}(ifm.mesh),u_at(da_times(i),fc_means{i}(ifm.mesh)),'o','Color', 'blue')
%     pause%(0.001);
%     hold off
    %fc_rmse(i) = sqrt(sum(fdiff2)/length(ifm.mesh));
    fc_rmseH(i)=sqrt((1/(right-left))*trapz(fc_means{i}(ifm.mesh),fdiff2+Dfdiff2));
    %fc_rmse(i) = sqrt(sum(fdiff2+Dfdiff2)/length(ifm.mesh));
    %adiff = an_means(i,ifm.stat)-u_at(da_times(i),an_means(i,ifm.mesh));
    %ifm.stat=[2:length(an_means{i})/2-1];
    ifm.stat=[1:length(an_means{i})/2];
    %ifm.mesh=[length(an_means{i})/2+2:length(an_means{i})-1];
    ifm.mesh=[length(an_means{i})/2+1:length(an_means{i})];
    adiff = an_means{i}(ifm.stat)-u_at(da_times(i),an_means{i}(ifm.mesh));
    adiff2 = adiff.^2;
    Dadiff = gradient(an_means{i}(ifm.stat),an_means{i}(ifm.mesh))-gradient(u_at(da_times(i),an_means{i}(ifm.mesh)),an_means{i}(ifm.mesh));
    Dadiff2 = (Dadiff).^2;
    
%     plot(an_means{i}(ifm.mesh),an_means{i}(ifm.stat),'*','Color', 'red')
%     hold on
%     plot(an_means{i}(ifm.mesh),u_at(da_times(i),an_means{i}(ifm.mesh)),'o','Color', 'red')
%     pause(0.001);
%     hold off
    %an_rmse(i) = sqrt(sum(adiff2)/length(ifm.mesh));
    an_rmseH(i)=sqrt((1/(right-left))*trapz(an_means{i}(ifm.mesh),adiff2+Dadiff2));
    %an_rmse(i) = sqrt(sum(adiff2+Dadiff2)/length(ifm.mesh));
end

% elseif(divtrue==1 && h1norm==0)
%     
%   
% for i=2:num_steps+1
%     %fdiff = fc_means(i,ifm.stat)-u_at(da_times(i),fc_means(i,ifm.mesh));
%     %ifm.stat=[2:length(fc_means{i})/2-1];
%     ifm.stat=[1:length(fc_means{i})/2];
%    % ifm.mesh=[length(fc_means{i})/2+2:length(fc_means{i})-1];
%     ifm.mesh=[length(fc_means{i})/2+1:length(fc_means{i})];
%     %fdiff = fc_means{i}(ifm.stat)-u_at(da_times(i),fc_means{i}(ifm.mesh));
%     %fdiff2 = fdiff.^2;
%     Dfdiff = gradient(gradient(fc_means{i}(ifm.stat),fc_means{i}(ifm.mesh)),fc_means{i}(ifm.mesh))-gradient(gradient(u_at(da_times(i),fc_means{i}(ifm.mesh)),fc_means{i}(ifm.mesh)),fc_means{i}(ifm.mesh));
%     Dfdiff2 = (Dfdiff).^2;
% %     plot(fc_means{i}(ifm.mesh),fc_means{i}(ifm.stat),'*','Color', 'blue')
% %     hold on
% %     plot(fc_means{i}(ifm.mesh),u_at(da_times(i),fc_means{i}(ifm.mesh)),'o','Color', 'blue')
% %     pause%(0.001);
% %     hold off
%     %fc_rmse(i) = sqrt(sum(fdiff2)/length(ifm.mesh));
%     %fc_rmse(i)=sqrt((1/(right-left))*trapz(fc_means{i}(ifm.mesh),fdiff2+Dfdiff2));
%     fc_rmse(i) = sqrt(sum(Dfdiff2)/length(ifm.mesh));
%     %adiff = an_means(i,ifm.stat)-u_at(da_times(i),an_means(i,ifm.mesh));
%     %ifm.stat=[2:length(an_means{i})/2-1];
%     ifm.stat=[1:length(an_means{i})/2];
%     %ifm.mesh=[length(an_means{i})/2+2:length(an_means{i})-1];
%     ifm.mesh=[length(an_means{i})/2+1:length(an_means{i})];
%     %adiff = an_means{i}(ifm.stat)-u_at(da_times(i),an_means{i}(ifm.mesh));
%     %adiff2 = adiff.^2;
%     Dadiff = gradient(gradient(an_means{i}(ifm.stat),an_means{i}(ifm.mesh)),an_means{i}(ifm.mesh))-gradient(gradient(u_at(da_times(i),an_means{i}(ifm.mesh)),an_means{i}(ifm.mesh)),an_means{i}(ifm.mesh));
%     Dadiff2 = (Dadiff).^2;
%     
% %     plot(an_means{i}(ifm.mesh),an_means{i}(ifm.stat),'*','Color', 'red')
% %     hold on
% %     plot(an_means{i}(ifm.mesh),u_at(da_times(i),an_means{i}(ifm.mesh)),'o','Color', 'red')
% %     pause(0.001);
% %     hold off
%     %an_rmse(i) = sqrt(sum(adiff2)/length(ifm.mesh));
%     %an_rmse(i)=sqrt((1/(right-left))*trapz(an_means{i}(ifm.mesh),adiff2+Dadiff2));
%     an_rmse(i) =  sqrt(sum(Dadiff2)/length(ifm.mesh));
% end

%end
