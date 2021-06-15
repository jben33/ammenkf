% Input initial condition
% Solve KSM on fixed, Eulerian mesh

function u = generate_truth_ksm(init_values)

global tlength comp_time h
global N_true true_mesh del
global nu

u = nan(tlength,N_true);
u(1,:) = init_values;

for i=2:tlength
    
    pvals = u(i-1,:);
    cvals = nan(1,N_true);
    t1 = comp_time(i-1);
    t2 = comp_time(i);
    
    while(t1 < t2)
        
        % Value 1
        d_approx = -1/(4*del)*(pvals(2)^2-pvals(N_true)^2)...
            -1/(del^2)*(pvals(2)-2*pvals(1)+pvals(N_true))...
            -nu/(del^4)*(pvals(3)-4*pvals(2)+6*pvals(1)-4*pvals(N_true)+pvals(N_true-1));
        cvals(1) = pvals(1)+h*d_approx;
        
        % Value 2
        d_approx = -1/(4*del)*(pvals(3)^2-pvals(1)^2)...
            -1/(del^2)*(pvals(3)-2*pvals(2)+pvals(1))...
            -nu/(del^4)*(pvals(4)-4*pvals(3)+6*pvals(2)-4*pvals(1)+pvals(N_true));
        cvals(2) = pvals(2)+h*d_approx;
        
        % Values 3 through N_true-2
        for j=3:N_true-2
            d_approx = -1/(4*del)*(pvals(j+1)^2-pvals(j-1)^2)...
                -1/(del^2)*(pvals(j+1)-2*pvals(j)+pvals(j-1))...
                -nu/(del^4)*(pvals(j+2)-4*pvals(j+1)+6*pvals(j)-4*pvals(j-1)+pvals(j-2));
            cvals(j) = pvals(j)+h*d_approx;
        end
        
        % Value N_true-1
        d_approx = -1/(4*del)*(pvals(N_true)^2-pvals(N_true-2)^2)...
            -1/(del^2)*(pvals(N_true)-2*pvals(N_true-1)+pvals(N_true-2))...
            -nu/(del^4)*(pvals(1)-4*pvals(N_true)+6*pvals(N_true-1)-4*pvals(N_true-2)+pvals(N_true-3));
        cvals(N_true-1) = pvals(N_true-1)+h*d_approx;
        
        % Value N_true
        d_approx = -1/(4*del)*(pvals(1)^2-pvals(N_true-1)^2)...
            -1/(del^2)*(pvals(1)-2*pvals(N_true)+pvals(N_true-1))...
            -nu/(del^4)*(pvals(2)-4*pvals(1)+6*pvals(N_true)-4*pvals(N_true-1)+pvals(N_true-2));
        cvals(N_true) = pvals(N_true)+h*d_approx;
        
        pvals = cvals;
        t1 = t1+h;

    end
    
    u(i,:) = cvals;
    
end