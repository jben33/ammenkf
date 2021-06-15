
% This code is to cluster etc

function embedded = embed_Un(ensemble)
N=100;
Ne = size(ensemble,1);
least=10^8;
clear idx;
clear C;

for ii=1:Ne
    if(length(ensemble{ii})<least)
        least=length(ensemble{ii});
        emnum=ii;
    end
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
    g{ii}(j)=idx{ii}(k);
    gsize=sum(idx{ii}==idx{ii}(k));
    k=k+gsize;
    j=j+1;
    end
end


for ii=1:Ne
   idxz=zeros(2*length(idx),1);
   idxz(N+1:2*N)=idx;
    for jj=1:least/2
    embedded(ii,jj)=sum(ensemble{ii}(idx{ii}==g{ii}))/length(ensemble{ii}(idx{ii}==g{ii}));
    embedded(ii,jj+N)=sum(ensemble{ii}(idxz{ii}==g{ii}))/length(ensemble{ii}(idxz{ii}==g{ii}));
    end
end

end



    

