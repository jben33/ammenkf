% for i=1:30
%     sum((idx==i))
%     i
%     pause
%     
%     
% end

for i=1:30
   CS(:,i)=sort(C{i});
end


for i=1:65
    plot(CS(i,:),[1:1:30],'o')
    hold on
%     for ii=1:30
%        z=fc{ii}(length(fc{ii})/2+1:length(fc{ii}));
%         plot(z(idx{i}==i),ones(length(z(idx{i}==i)))+(ii-1),'*');
%         hold on
%     end
    hold off
    xlim([0 1]); 
    ylim([1 30]);
    pause;
end