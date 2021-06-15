for i=1:least/2
    if(mod(i,2)==0)
        c='red';
    else
        c='blue';
    end
        for ii=1:N_ens
       z=fc{ii}(length(fc{ii})/2+1:length(fc{ii}));
       plot(z(idx{ii}==g{ii}(i)),ones(length(z(idx{ii}==g{ii}(i))))+(ii-1),'*','Color',c,'MarkerFaceColor',c);
       hold on
        end
        xlim([0 1]); 
        ylim([1 30]);
        pause
        %hold off
end

