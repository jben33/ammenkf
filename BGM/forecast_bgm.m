% input ensemble member, start and end time
% output that ensemble member forecasted forward (using Lagrangian mesh)
% from initial to final time

function frcst = forecast_bgm(em,t1,t2)

global left right
global h
global eps


L = length(em)/2;
pvals = em(1:L);
pmesh = em(L+1:2*L);

while(t1 < t2)
    
    cvals = nan(1,L);
    
    % Value 1
    d_approx = (pvals(2)-pvals(L))/(pmesh(2)-left+right-pmesh(L))*pvals(1)+...
        2*eps/(pmesh(2)-left+right-pmesh(L))*((pvals(2)-pvals(1))/(pmesh(2)-pmesh(1))-(pvals(1)-pvals(L))/(pvals(1)-left+right-pvals(L)))-...
        0.5*((pvals(2)^2-pvals(L)^2))/(pmesh(2)-left+right-pvals(L));
    cvals(1) = pvals(1)+h*d_approx;
    
    % Values 2 through L-1
    for j=2:L-1
        d_approx = (pvals(j+1)-pvals(j-1))/(pmesh(j+1)-pmesh(j-1))*pvals(j)+...
            2*eps/(pmesh(j+1)-pmesh(j-1))*((pvals(j+1)-pvals(j))/(pmesh(j+1)-pmesh(j))-(pvals(j)-pvals(j-1))/(pmesh(j)-pmesh(j-1)))-...
            0.5*(pvals(j+1)^2-pvals(j-1)^2)/(pmesh(j+1)-pmesh(j-1));
        cvals(j) = pvals(j)+h*d_approx;
    end
    
    % Value L
    d_approx = (pvals(1)-pvals(L-1))/(pmesh(1)-left+right-pmesh(L-1))*pvals(L)+...
        2*eps/(pmesh(1)-left+right-pmesh(L-1))*((pvals(1)-pvals(L))/(pmesh(1)-left+right-pmesh(L))-(pvals(L)-pvals(L-1))/(pmesh(L)-pmesh(L-1)))-...
        0.5*(pvals(1)^2-pvals(L-1)^2)/(pmesh(1)-left+right-pmesh(L-1));
    cvals(L) = pvals(L)+h*d_approx;
    
    % Advect mesh
    cmesh = pmesh+h*pvals;
    
    % Remesh, if necessary
    [cvals, cmesh] = remesh(cvals,cmesh);
    
    L = length(cvals);
    pvals = cvals;
    pmesh = cmesh;
    
    t1 = t1+h;
    
end

frcst = [cvals cmesh];