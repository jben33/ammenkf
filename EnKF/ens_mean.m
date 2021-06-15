% input ensemble
% output ensemble mean

function mean = ens_mean(ensemble)

s = size(ensemble);
N_ens = s(1);
N = s(2)/2;
mean = nan(1,2*N);

for i=1:2*N
    sum = 0;
    count = 0;
    for j=1:N_ens
        if (~isnan(ensemble(j,i)))
            sum = sum+ensemble(j,i);
            count = count+1;
        end
    end
    if (count > 0)
        mean(i) = sum/count;
    end
end