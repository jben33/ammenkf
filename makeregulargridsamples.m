


[x,y]=meshgrid(linspace(1,1.6,10),linspace(0,0.1,10));
n=size(x,1)
LHS(1:n,1)=x(:,1);
LHS(1:n,2)=y(:,1);
 for i=2:size(x,2)
     LHS((i-1)*n+1:i*n,1)=[x(:,i)];
     LHS((i-1)*n+1:i*n,2)=[y(:,i)];
    end

 save('LHSparams.mat','LHS');
