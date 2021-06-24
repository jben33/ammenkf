clear
load output_HR_inflation_jitter_other1d_1_10.mat
stsall=sts;
inc=10
for ii=10:inc:495
   % file=strcat('output_HR_jitter_inflation_',num2str(ii+1),'_',num2str(ii+inc),'.mat');
     %file=strcat('output_HR_everything_',num2str(ii+1),'_',num2str(ii+inc),'.mat');
    file=strcat('output_HR_inflation_jitter_other1d_',num2str(ii+1),'_',num2str(ii+inc),'.mat');
ii
if isfile(file)
    load(file)
    stsall=[stsall;sts];
else
     display(file);
    continue;
end
end
