% Takes embedded ensemble as input
% Outputs filled in ensemble member

function A = fill_in_HRA(embedded)

global left right d1 Nup NGS
Nup=size(embedded,2)/2;
Ne = size(embedded,1);
A = embedded;

for i=1:Ne
  
    for j=1:Nup
        
        % Check whether cell is empty
         if(isnan(A(i,j)))
            % A(i,j)=left+d1*(j-1);
            %A(i,j+Nup)=sp{i}(j);
            l_ind = j;  r_ind = j;  % Find nonempty cells to left and right
            while(isnan(A(i,l_ind)))
                l_ind = l_ind-1;
                if(l_ind == 0)
                    l_ind = Nup;
                end
            end
            while(isnan(A(i,r_ind)))
                r_ind = r_ind+1;
                if(r_ind == Nup+1)
                    r_ind = 1;
                end
            end
%             
%             if ((abs(left+d1*(j-1)-A(i,l_ind+Nup)))<(abs(left+d1*(j-1)-A(i,r_ind+Nup))))
% 
%              Atemp(i,j)=A(i,l_ind);
%              Atemp(i,j+Nup)=A(i,l_ind+Nup);
%             else
%              Atemp(i,j)=A(i,r_ind);
%              Atemp(i,j+Nup)=A(i,r_ind+Nup);
%             end
                     
          % Perform interpolation to fill in missing value
           inbounds=0;
           while(inbounds==0)
            A(i,j+Nup) = left+d1*(j-1)+d1/2+normrnd(0,d1/2); 
            if(A(i,j+Nup)<left || A(i,j+Nup)>right || A(i,j+Nup)<left+d1*(j-1) || A(i,j+Nup)>left+d1*(j) )
                inbounds=0;
            else
                inbounds=1;
            end
            end
            if(A(i,l_ind+Nup) > A(i,j+Nup))
                a = A(i,j+Nup)-left+right-A(i,l_ind+Nup);
            else
                a = A(i,j+Nup)-A(i,l_ind+Nup);
            end
            if(A(i,r_ind+Nup) < A(i,j+Nup))
                b = A(i,r_ind+Nup)-left+right-A(i,j+Nup);
            else
                b = A(i,r_ind+Nup)-A(i,j+Nup);
            end
            A(i,j) = b/(a+b)*A(i,l_ind)+a/(a+b)*A(i,r_ind); %+normrnd(0,3);
            
        end
        
    end
    
  
    
 
%  display('Fillinf in')
%  plot(embedded(i,Nup+1:2*Nup),embedded(i,1:Nup),'o')
%  pause
%  hold on
%  plot(A(i,Nup+1:2*Nup),A(i,1:Nup),'*')
%  pause;
%  hold off
end

%     lg1=left-abs(A(:,2*Nup-1)-right);
%     lg2=left-abs(A(:,2*Nup)-right);
%     rg1=right+abs(A(:,Nup+1)-left);
%     rg2=right+abs(A(:,Nup+2)-left);
%     
%     A=[A(:,Nup-1),A(:,Nup),A(:,1:Nup),A(:,1),A(:,2),lg1,lg2,A(:,Nup+1:2*Nup),rg1,rg2];

%  A_fullold=A_full;
%      lg1=left-abs(A_full(:,2*Nup-1)-right);
%      lg2=left-abs(A_full(:,2*Nup)-right);
%      rg1=right+abs(A_full(:,Nup+1)-left);
%      rg2=right+abs(A_full(:,Nup+2)-left);
%      A_full=[A_full(:,Nup-1),A_full(:,Nup),A_full(:,1:Nup),A_full(:,1),A_full(:,2),lg1,lg2,A_full(:,Nup+1:2*Nup),rg1,rg2];
    
% for j=1:Ne
%      display('Fillinf in')
%  plot(embedded(i,Nup+1:2*Nup),embedded(i,1:Nup),'o')
%  pause
%  hold on
%  plot(A(j,Nup+1:2*Nup),A(j,1:Nup),'*')
%  pause
%  Nup=Nup+4;
%  plot(B(j,Nup+1:2*Nup),B(j,1:Nup),'*')
%  Nup=Nup-4;
%  pause;
%  hold off
% end
%
% fill=Atemp~=0;
% A(fill)=Atemp(fill)

