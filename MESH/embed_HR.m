% Takes ensemble members as input
% Returns ensemble embedded in R^(2N)

function embedded = embed_HR(ensemble)

global left right d1
global N

Ne = size(ensemble,1);
embedded = nan(Ne,2*N);

for i=1:Ne

    em = ensemble{i};
    L = length(em)/2;

    % Loop through ensemble mesh points, find them in state space
    for j=1:L

        loc = em(L+j);                      % current ensemble mesh point
        if (loc < left+d1/2 || loc > right-d1/2)
            embedded(i,N+1) = left;
        else
            k = 2;
            while (loc > left+(k-1)*d1+(d1/2) || loc <= left+(k-1)*d1-(d1/2))
                k = k+1;
            end
            embedded(i,N+k) = left+(k-1)*d1;
        end

    end

    indices = ~isnan(embedded(i,N+1:2*N));
    
    embedded(i,indices) = em(1:L);

end
