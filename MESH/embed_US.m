
% This code is to cluster etc

function [embedded,g,idxu,idxz] = embed_US(ensemble,groups)

N=100;
Ne = size(ensemble,1);
least=10^8;
clear idx;
clear C;
if(groups==0)
for ii=1:Ne
    if(length(ensemble{ii})<least)
        least=length(ensemble{ii});
        emnum=ii;
    end
end
else
    least=2*groups;
end

Cstart=[0:1/(least/2-1):1];

for ii=1:Ne
    len=length(ensemble{ii})/2;
   
    [idx{ii},C{ii}]=kmeans( ensemble{ii}(len+1:2*len)',least/2,'Start',Cstart');
   %plot(C{ii},ones(1,length(C(:,ii)))+(ii-1),'o')
   %hold on
   %pause;
end

for ii=1:Ne
    k=1;
    j=1;
    num=length(idx{ii});
    while(k<=num)
    g{ii}{1}(j)=idx{ii}(k);
    gsize=sum(idx{ii}==idx{ii}(k));
    g{ii}{2}(j)=gsize;
    k=k+gsize;
    j=j+1;
    end
end

embeded=NaN(Ne,least);

for ii=1:Ne
   %idxz=zeros(2*length(idx{ii}),1);
   idxu{ii}=[idx{ii}; zeros(length(ensemble{ii})/2,1)];
   %idxz(1+length(ensemble{ii})/2:length(ensemble{ii}))=idx{ii};
   idxz{ii}=[zeros(length(ensemble{ii})/2,1);idx{ii}];
   
  
   for jj=1:least/2
    
    embedded(ii,jj)=sum(ensemble{ii}(idxu{ii}==g{ii}{1}(jj)))/length(ensemble{ii}(idxu{ii}==g{ii}{1}(jj)));
    embedded(ii,jj+least/2)=sum(ensemble{ii}(idxz{ii}==g{ii}{1}(jj)))/length(ensemble{ii}(idxz{ii}==g{ii}{1}(jj)));
    end
end
%embedded=1;
end



    

