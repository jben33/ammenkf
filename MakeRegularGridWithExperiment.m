

clear
 clim_std=7.98;
[x,y]=meshgrid(linspace(1,1.6,10),linspace(0,0.1,10)); %use .5 for upper jitter limit for KSM .1 for BGM
n=size(x,1)
LHS(1:n,1)=x(:,1);
LHS(1:n,2)=y(:,1);
%LHS(1:n,3)=i*ones(length(x(:,1)),1);
 for i=2:size(x,2)
     LHS((i-1)*n+1:i*n,1)=[x(:,i)];
     LHS((i-1)*n+1:i*n,2)=[y(:,i)];
     %LHS((i-1)*n+1:i*n,3)=[i*ones(length(x(:,1)),1)];
 end
 l=size(LHS,1);

P=[20,30,50,70,90];% ensemble size
%P=[ clim_std*.01 clim_std*.03 clim_std*.06 clim_std*.075 clim_std*.10 clim_std*.15 clim_std*.20 clim_std*.250];% obs error KSM
LHS=repmat(LHS,length(P),1);
P1=repmat(P(1),l,1);
P2=repmat(P(2),l,1);
P3=repmat(P(3),l,1);
P4=repmat(P(4),l,1);
P5=repmat(P(5),l,1);
%P6=repmat(P(6),l,1);
%P7=repmat(P(7),l,1);
%P8=repmat(P(8),l,1);

LHS(:,3)=[P1;P2;P3;P4;P5]%;P6;P7;P8];

save('LHSparams.mat','LHS');
