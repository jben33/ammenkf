% input ensemble member and observation locations
% output observation operator H

function H = get_H(em,obs_locs)

global left right N
Nup=length(em)/2; % N has been replaced with this since the dimension of the analysis space changes
num_obs = length(obs_locs);
temp = zeros(num_obs,length(em));
m = get_mesh(em);
v = get_values(em);
len = length(m);

for j=1:num_obs
    
    % Check whether observation location is on the edge
    if(obs_locs(j) < m(1) || obs_locs(j) > m(len))
        ind_R = 1;
        ind_L = len;
        if(obs_locs(j) < m(1))
            a = m(1)-obs_locs(j);
            b = obs_locs(j)-left+right-m(len);
        else
            a = m(1)-left+right-obs_locs(j);
            b = obs_locs(j)-m(len);
        end
    
    % Find observation location within ensemble member
    else
        
        ind_L = len;
        while(m(ind_L) > obs_locs(j))
            ind_L = ind_L-1;
        end
        ind_R = ind_L+1;
        if(abs(m(ind_L)-obs_locs(j))<0.0001)
            a = 1;
            b = 0;
        elseif(abs(m(ind_R)-obs_locs(j))<0.0001)
            a = 0;
            b = 1;
        else
            a = m(ind_R)-obs_locs(j);
            b = obs_locs(j)-m(ind_L);
        end
        
    end
    
    ind1 = find(abs(em(Nup+1:2*Nup)-m(ind_L))<0.0001);
    ind2 = find(abs(em(Nup+1:2*Nup)-m(ind_R))<0.0001);
    temp(j,ind1) = a/(a+b);
    temp(j,ind2) = b/(a+b);
    
end

H = temp(:,1:Nup);
