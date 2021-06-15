d1=0.01;
d2=2*d1;
L=1;
maxinitmesh=length(0:d1:L)-1;
mininitmesh=length(0:d2:L)-1;
M=8;
for i=1:M
n=maxinitmesh-mininitmesh; %number of samples
p=3; %number of paramaters
%
%LHS(1) inflation factor
%LHS(2) jitter
%LHS(3) observation error
LHST=lhsdesign(n,p);
LHST(:,1)=1+0.6*LHST(:,1);
LHST(:,2)=0.1*LHST(:,2);
LHST(:,3)=0.00001+0.01*LHST(:,3);
%LHS(4) ensemble size
LHST(:,4)=10+randperm(80,n);
%LHS(5) inital mesh size
LHST(:,5)=mininitmesh+randperm(maxinitmesh-mininitmesh,n);
if(i==1)
    LHS=LHST;
else
LHS=[LHS; LHST];
end
end
save('LHSparams.mat','LHS')