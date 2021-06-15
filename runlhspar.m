% 
% 
!rm runall.sh
inc=10;
for ll=0:inc:490
    worker=strcat('../LHS_WorkerForParams',num2str(ll+1),'_',num2str(ll+inc));
    makeworkers=strcat('mkdir',{' '},worker);
    system(makeworkers{1})
    copyworkers=strcat('cp -r',{' '},'*',{' '},worker)
    system(copyworkers{1})
    range=[ll+1,ll+inc];
    save(strcat(worker,'/range.mat'),'range')
  %  makebatchfiles=strcat('echo',{' '}, '"matlab',{' '},'-nodesktop',{' '}, '-nosplash',{' '},'-singleCompThread',{' '}, '-r',{' '}, '"runrun(',num2str(ll),',',num2str(ll+5),')"',{' '}, '-logfile',{' '}, 'singlerun.out"','>>',worker,'/runLHS.sb')
      makebatchfiles=strcat('echo',{' '}, '"matlab',{' '},'-nodesktop',{' '}, '-nosplash',{' '},'-singleCompThread',{' '}, '-r',{' '}, 'runrunrun',{' '}, '-logfile',{' '}, 'singlerun.out"','>>',worker,'/runLHS.sb')
    system(makebatchfiles{1})
    movetoworker=strcat('echo',{' '},'"cd',{' '},worker,'"',{' '}, '>>runall.sh')
    system(movetoworker{1})
    runbat=strcat('echo',{' '},'"sbatch',{' '},'runLHS.sb"',{' '},'>>runall.sh')
    system(runbat{1})
end
