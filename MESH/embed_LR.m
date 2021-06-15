% Takes ensemble members as input
% Returns ensemble embedded in R^(2N)

function [embedded, indices]  = embed_LR(ensemble)

global right d2
global N

Ne  =  size(ensemble,1);
embedded =  zeros(Ne,2*N);
indices  = cell(Ne);

for i=1:Ne  % loop over ensemble
% % embed reference fixed mesh
  embedded(i,N+1) = 0; 

  for fm = 2:N  % set the reference fixed mesh
    embedded(i,N+fm) = embedded(i,N+fm-1) + d2;
  end

  em = ensemble{i};
  L  = length(em)/2;

  for  fm = 1:N
    % interval of containment for AMM mesh points
    nl = embedded(i,N+fm) - (d2/2); 
    nr = embedded(i,N+fm) + (d2/2);
    count = 0;
    % index the AMM mesh points mapping to fixed mesh
    for j=1:L
      if ( nl < em(L+j) && em(L+j) <= nr )
        if ( count == 0 )
	  indices{i,fm} =  j;
          count = count + 1;
        else
	  indices{i,fm} = [ indices{i,fm}, j ];
          count = count + 1;
        end
      end
       if ( fm == 1 && em(L+j) > right-(d2/2) )
        if ( count == 0 )
	  indices{i,fm} =  j;
          count = count + 1;
        else
	  indices{i,fm} = [ indices{i,fm}, j ];
          count = count + 1;
        end
      end

    end
     % compute the mean value of the AMM values on FRM
      embedded(i,fm) = sum(em(indices{i,fm})) / count; 
   end
end
