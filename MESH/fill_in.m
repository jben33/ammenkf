% Takes embedded ensemble as input
% Outputs filled in ensemble member

function A = fill_in(embedded)

global left right d1 N
Ne = size(embedded,1);
A = embedded;

for i=1:Ne
    
    for j=1:N
        
        % Check whether cell is empty
        if(isnan(A(i,j)))
            
            l_ind = j;  r_ind = j;  % Find nonempty cells to left and right
            while(isnan(A(i,l_ind)))
                l_ind = l_ind-1;
                if(l_ind == 0)
                    l_ind = N;
                end
            end
            while(isnan(A(i,r_ind)))
                r_ind = r_ind+1;
                if(r_ind == N+1)
                    r_ind = 1;
                end
            end
            
            % Perform interpolation to fill in missing value
            A(i,j+N) = left+d1*(j-1);
            if(A(i,l_ind+N) > A(i,j+N))
                a = A(i,j+N)-left+right-A(i,l_ind+N);
            else
                a = A(i,j+N)-A(i,l_ind+N);
            end
            if(A(i,r_ind+N) < A(i,j+N))
                b = A(i,r_ind+N)-left+right-A(i,j+N);
            else
                b = A(i,r_ind+N)-A(i,j+N);
            end
            A(i,j) = b/(a+b)*A(i,l_ind)+a/(a+b)*A(i,r_ind);
            
        end
        
    end
    
end
