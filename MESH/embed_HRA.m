% Takes ensemble members as input
% Returns ensemble embedded in R^(2N)

function [embedded] = embed_HRA(ensemble)

global left right d1
global N

Ne = size(ensemble,1);
embedded = nan(Ne,2*N);


% ensemble{1}
% N
% pause


%size(embedded);
for i=1:Ne
    em = ensemble{i};
   
    
    L = length(em)/2;
%     for j=1:L
% 
%         loc = em(L+j);                      % current ensemble mesh point
%         if (loc < left+d1/2 || loc > right-d1/2)
%             embedded(i,N+1) = loc; %left;
%         else
%             k = 2;
%             while (loc > left+(k-1)*d1+(d1/2) || loc <= left+(k-1)*d1-(d1/2))
%                 k = k+1
%             end
%             embedded(i,N+k) = loc; %left+(k-1)*d1;
%         end
% 
%     end




%Placing things starting with 0 as first end point
j=1;
for k=1:N
   loc=em(L+j);
   %pause
%     loc
%     [(k-1)*d1,k*d1]
%     pause
     

   
%       if(loc<left+d1/2)
%           embedded(i,N+k)=left;
%           j=j+1;
%       elseif(loc>right-d1/2)
%               embedded(i,N+k)=right;
%               j=j+1;
     if(loc>(k-1)*d1 && loc<(k*d1)) 

              embedded(i,N+k)=loc;
              j=j+1;
              %disp('inbetween')
              %pause
      elseif(loc==(k-1)*d1 || loc==right || abs(loc-(k-1)*d1)<1e-15)
            embedded(i,N+k)=loc;
              j=j+1;
              %disp('equal')
              %pause
              
      end
   if(j>L)
      break;
  end
end


%placing things treating the first interval as peridic
% em
% pause
%  j=1
% for k=1:N
%    loc=em(L+j)
% 
% %     loc
% %     [(k-1)*d1,k*d1]
% %     pause
%     if (loc< left+ d1/2 || loc > right- d1/2)
%         embedded(i,N+1)=loc;
%         j=j+1
%     end;
% 
%     if(loc>=(k-1)*d1+d1/2 && loc<=((k)*d1+d1/2))
%         embedded(i,N+k)=loc;
%         j=j+1
%     end;
%     if(j>L)
%       break;
%   end
% end;



    indices = ~isnan(embedded(i,N+1:2*N));
   
    %ind2= isnan(embedded(i,N+1:2*N));
 
    %embedded(i,indices)
  
    embedded(i,indices) = em(1:L);
    
%     k=1;
%     firstloc=N+find(~isnan(embedded(i,N+1:2*N)), 1, 'first');
%     lastloc=N+find(~isnan(embedded(i,N+1:2*N)), 1, 'last');
% if(embedded(i,firstloc)<left)
%     embedded(i,firstloc)=left;
% end
% 
% if (embedded(i,lastloc)>right)
%     embedded(i,lastloc)=right;
% end;
%   
%    
    % if(embedded(i,firstloc) < left+d1/2 || embedded(i,lastloc)>right -d1/2)
     %    embedded(i,lastloc-N)=embedded(i,firstloc-N);         
     %end;
     
     
   
   
    
        
    
   
    %fcspline{i}=spline(em(L+1:2*L),em(1:L),[left:d1/2:right]);
    
% plot(em(L+1:2*L),em(1:L),'o')
% hold on
% plot(embedded(i,N+1:2*N),embedded(i,1:N),'*')
% i
% display('here')
% pause;
% hold off


end
