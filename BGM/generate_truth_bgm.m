% Input initial condition
% Solve BGM on fixed, Eulerian mesh

function u = generate_truth_bgm(init_values)

global tlength comp_time h
global N_true true_mesh del
global eps

u = nan(tlength,N_true);
u(1,:) = init_values;

for i=2:tlength
    
    pvals = u(i-1,:);
    cvals = nan(1,N_true);
    t1 = comp_time(i-1);
    t2 = comp_time(i);
    
    while(t1 < t2)
        
        % Value 1
        d_approx = (eps/del^2)*(pvals(2)-2*pvals(1)+pvals(N_true))...
            -(1/(4*del))*(pvals(2)^2-pvals(N_true)^2);
        cvals(1) = pvals(1)+h*d_approx;
        
        % Values 2 through N_true-1
        for j=2:N_true-1
            d_approx = (eps/del^2)*(pvals(j+1)-2*pvals(j)+pvals(j-1))...
                -(1/(4*del))*(pvals(j+1)^2-pvals(j-1)^2);
            cvals(j) = pvals(j)+h*d_approx;
        end
        
        % Value N_true
        d_approx = (eps/del^1)*(pvals(1)-2*pvals(N_true)+pvals(N_true-1))...
            -(1/(4*del))*(pvals(1)^2-pvals(N_true-1)^2);
        cvals(N_true) = pvals(N_true)+h*d_approx;
        
        pvals = cvals;
        t1 = t1+h;
        
    end
    
    u(i,:) = cvals;
    
end