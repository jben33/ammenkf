i=300; 
j=20;
resol='HRA'
kurts=[stsall(i,16).(resol)]
inf=[stsall(i,2).(resol)]
jitter=[stsall(i,3).(resol)]
mems=[stsall(i,23).(resol){j}]
size(mems)
[stsall(i,2).(resol)]
[stsall(i,3).(resol)]
for ii=1:50
    plot(mems(ii,101:200),mems(ii,1:100))
    hold on
    plot(true_mesh,u_at(da_times(j),true_mesh))
    hold off
    
    title(num2str(kurts(j,ii)))
    pause
end