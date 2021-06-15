for ii=1:30
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

