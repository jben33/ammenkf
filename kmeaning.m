%idx=kmeans((fc{1:30}(1:140/2))', 65);
eml=0;
clear X
clear L
N_ens=30
L=0
least=10^8;
clear idx
clear C

for ii=1:N_ens
    if(length(fc{ii})<least)
        least=length(fc{ii});
        emnum=ii;
    end
end
Cstart=[0:1/(least/2-1):1];
for ii=1:N_ens
    len=length(fc{ii})/2;
   %x= fc{ii}(len+1:2*len)';
    [idx{ii},C{ii}]=kmeans( fc{ii}(len+1:2*len)',least/2,'Start',Cstart');
    
    %plot(C{ii},ones(1,length(C(:,ii)))+(ii-1),'o')
   
    %hold on
%     pause;
end



    

% for ii=1:N_ens
%     em_idx(ii,1)=eml+1%store indices for later recall from X
%     emf=length(fc{ii})/2
%     em_idx(ii,2)=emf+eml
%     X(eml+1:eml+emf,1)=(fc{ii}(length(fc{ii})/2+1:length(fc{ii})))';
%     eml=length(X);
%    
% end

 %[idx,C]=kmeans(X,least/2,'Start',fc{emnum}(length(fc{emnum})/2+1:length(fc{emnum}))');
% plot(C,ones(1,length(C)),'o')


%
%pause
A=zeros(N_ens,least);
% for ii=1:Nens
%     for jj=1:least/2
%      
%         A(ii,jj)   
        
        




% for i=1:30
%     i
%     
%     max(abs(fc{i}(1+length(fc{i})/2:length(fc{i}))-(X(em_idx(i,1):em_idx(i,2)))'))
%     
%     pause
% end;

%for i=1:N_ens
    
% for i=1:length(idx)
%     plot(fc{1}(idx==i),ones(1,length(fc{1}(idx==i))),'*')
%     text(fc{1}(idx==i),ones(1,length(fc{1}(idx==i))),num2str(i));
%     hold on
% end

% for i=1:length(idx)
%     plot(X(idx==i),ones(1,length(X(idx==i))),'*')
%     text(X(idx==i),ones(1,length(X(idx==i))),num2str(i));
%     hold on
% end
