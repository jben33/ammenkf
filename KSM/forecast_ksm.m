% input ensemble member, start and end time
% output that ensemble member forecasted forward (using Lagrangian mesh)
% from initial to final time

function frcst = forecast_ksm(em,t1,t2)

global left right
global h
global nu

L = length(em)/2;
pvals = em(1:L);
pmesh = em(L+1:2*L);

while(t1 < t2)
    
    cvals = nan(1,L);
    
    % Value 1
    uplus = (pvals(3)-pvals(2))/(pmesh(3)-pmesh(2))-...
        (pvals(2)-pvals(1))/(pmesh(2)-pmesh(1));
    u0 = (pvals(2)-pvals(1))/(pmesh(2)-pmesh(1))-...
        (pvals(1)-pvals(L))/(pmesh(1)-left+right-pmesh(L));
    uminus = (pvals(1)-pvals(L))/(pmesh(1)-left+right-pmesh(L))-...
        (pvals(L)-pvals(L-1))/(pmesh(L)-pmesh(L-1));
    u1 = 4/(pmesh(3)-pmesh(1))*uplus-4/(pmesh(2)-left+right-pmesh(L))*u0;
    u2 = 4/(pmesh(2)-left+right-pmesh(L))*u0-4/(pmesh(1)-left+right-pmesh(L-1))*uminus;
    d_approx4 = 2/(pmesh(2)-left+right-pmesh(L))*...
        (u1/(pmesh(2)-left+right-pmesh(L))-u2/(pmesh(1)-left+right-pmesh(L-1)));
    d_approx = (pvals(2)-pvals(L))/(pmesh(2)-left+right-pmesh(L))*pvals(1)...
        -2/(pmesh(2)-left+right-pmesh(L))*u0...
        -0.5*(pvals(2)^2-pvals(L)^2)/(pmesh(2)-left+right-pmesh(L))...
        -nu*d_approx4;
    cvals(1) = pvals(1)+h*d_approx;

    % Value 2     
    uplus = (pvals(4)-pvals(3))/(pmesh(4)-pmesh(3))-...
        (pvals(3)-pvals(2))/(pmesh(3)-pmesh(2));
    u0 = (pvals(3)-pvals(2))/(pmesh(3)-pmesh(2))-...
        (pvals(2)-pvals(1))/(pmesh(2)-pmesh(1));
    uminus = (pvals(2)-pvals(1))/(pmesh(2)-pmesh(1))-...
        (pvals(1)-pvals(L))/(pmesh(1)-left+right-pmesh(L));
    u1 = 4/(pmesh(4)-pmesh(2))*uplus-4/(pmesh(3)-pmesh(1))*u0;
    u2 = 4/(pmesh(3)-pmesh(1))*u0-4/(pmesh(2)-left+right-pmesh(L))*uminus;
    d_approx4 = 2/(pmesh(3)-pmesh(1))*...
        (u1/(pmesh(3)-pmesh(1))-u2/(pmesh(2)-left+right-pmesh(L)));
    d_approx = (pvals(3)-pvals(1))/(pmesh(3)-pmesh(1))*pvals(2)...
        -2/(pmesh(3)-pmesh(1))*u0...
        -0.5*(pvals(3)^2-pvals(1)^2)/(pmesh(3)-pmesh(1))...
        -nu*d_approx4;
    cvals(2) = pvals(2)+h*d_approx;

    % Values 3 through L-2        
    for j=3:L-2
        uplus = (pvals(j+2)-pvals(j+1))/(pmesh(j+2)-pmesh(j+1))-...
            (pvals(j+1)-pvals(j))/(pmesh(j+1)-pmesh(j));
        u0 = (pvals(j+1)-pvals(j))/(pmesh(j+1)-pmesh(j))-...
            (pvals(j)-pvals(j-1))/(pmesh(j)-pmesh(j-1));
        uminus = (pvals(j)-pvals(j-1))/(pmesh(j)-pmesh(j-1))-...
            (pvals(j-1)-pvals(j-2))/(pmesh(j-1)-pmesh(j-2));
        u1 = 4/(pmesh(j+2)-pmesh(j))*uplus-4/(pmesh(j+1)-pmesh(j-1))*u0;
        u2 = 4/(pmesh(j+1)-pmesh(j-1))*u0-4/(pmesh(j)-pmesh(j-2))*uminus;
        d_approx4 = 2/(pmesh(j+1)-pmesh(j-1))*...
            (u1/(pmesh(j+1)-pmesh(j-1))-u2/(pmesh(j)-pmesh(j-2)));
        d_approx = (pvals(j+1)-pvals(j-1))/(pmesh(j+1)-pmesh(j-1))*pvals(j)...
            -2/(pmesh(j+1)-pmesh(j-1))*u0...
            -0.5*(pvals(j+1)^2-pvals(j-1)^2)/(pmesh(j+1)-pmesh(j-1))...
            -nu*d_approx4;
        cvals(j) = pvals(j)+h*d_approx;
    end

    % Value L-1
    uplus = (pvals(1)-pvals(L))/(pmesh(1)-left+right-pmesh(L))-...
        (pvals(L)-pvals(L-1))/(pmesh(L)-pmesh(L-1));
    u0 = (pvals(L)-pvals(L-1))/(pmesh(L)-pmesh(L-1))-...
        (pvals(L-1)-pvals(L-2))/(pmesh(L-1)-pmesh(L-2));
    uminus = (pvals(L-1)-pvals(L-2))/(pmesh(L-1)-pmesh(L-2))-...
        (pvals(L-2)-pvals(L-3))/(pmesh(L-2)-pmesh(L-3));
    u1 = 4/(pmesh(1)-left+right-pmesh(L-1))*uplus-4/(pmesh(L)-pmesh(L-2))*u0;
    u2 = 4/(pmesh(L)-pmesh(L-2))*u0-4/(pmesh(L-1)-pmesh(L-3))*uminus;
    d_approx4 = 2/(pmesh(L)-pmesh(L-2))*...
        (u1/(pmesh(L)-pmesh(L-2))-u2/(pmesh(L-1)-pmesh(L-3)));
    d_approx = (pvals(L)-pvals(L-2))/(pmesh(L)-pmesh(L-2))*pvals(L-1)...
        -2/(pmesh(L)-pmesh(L-2))*u0...
        -0.5*(pvals(L)^2-pvals(L-2)^2)/(pmesh(L)-pmesh(L-2))...
        -nu*d_approx4;
    cvals(L-1) = pvals(L-1)+h*d_approx;

    % Value L
    uplus = (pvals(2)-pvals(1))/(pmesh(2)-pmesh(1))-...
        (pvals(1)-pvals(L))/(pmesh(1)-left+right-pmesh(L));
    u0 = (pvals(1)-pvals(L))/(pmesh(1)-left+right-pmesh(L))-...
        (pvals(L)-pvals(L-1))/(pmesh(L)-pmesh(L-1));
    uminus = (pvals(L)-pvals(L-1))/(pmesh(L)-pmesh(L-1))-...
        (pvals(L-1)-pvals(L-2))/(pmesh(L-1)-pmesh(L-2));
    u1 = 4/(pmesh(2)-left+right-pmesh(L))*uplus-4/(pmesh(1)-left+right-pmesh(L-1))*u0;
    u2 = 4/(pmesh(1)-left+right-pmesh(L-1))*u0-4/(pmesh(L)-pmesh(L-2))*uminus;
    d_approx4 = 2/(pmesh(1)-left+right-pmesh(L-1))*...
        (u1/(pmesh(1)-left+right-pmesh(L-1))-u2/(pmesh(L)-pmesh(L-2)));
    d_approx = (pvals(1)-pvals(L-1))/(pmesh(1)-left+right-pmesh(L-1))*pvals(L)...
        -2/(pmesh(1)-left+right-pmesh(L-1))*u0...
        -0.5*(pvals(1)^2-pvals(L-1)^2)/(pmesh(1)-left+right-pmesh(L-1))...
        -nu*d_approx4;
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