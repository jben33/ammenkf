% Input matrix A and observation locations
% Output H(A), observation operator applied to matrix A

function HA = get_HA(full_A,locs)

global N left right
Nup=size(full_A,2)/2; %N has been replaced whith this since analysis mesh changes dimension
p = length(locs);
Ne = size(full_A,1);
HA = nan(p,Ne);

for i=1:Ne                                      % loop through ensemble members
    
    em_vals = full_A(i,1:Nup);
    em_mesh = full_A(i,Nup+1:2*Nup);
    
    for j=1:p                                   % loop through observation locations
        
        loc = locs(j);
        
        % Find observation location within ensemble mesh
        if (loc < em_mesh(1))                       % check if location is far left
            l_ind = Nup;  r_ind = 1;
            a = loc-left+right-em_mesh(l_ind);
            b = em_mesh(r_ind)-loc;
        elseif(loc > em_mesh(Nup))                    % check if location is far right
            l_ind = Nup;  r_ind = 1;
            a = loc-em_mesh(l_ind);
            b = em_mesh(r_ind)-left+right-em_mesh(l_ind);
        else                                        % find location withing mesh
            r_ind = 1;
            while(em_mesh(r_ind) < loc)
                r_ind = r_ind+1;
            end
            l_ind = r_ind-1;
            if(l_ind == 0)
                l_ind = Nup;
            end
            a = loc-em_mesh(l_ind);
            b = em_mesh(r_ind)-loc;
        end
        
        HA(j,i) = b/(a+b)*em_vals(l_ind)+a/(a+b)*em_vals(r_ind);
        
    end
    
end