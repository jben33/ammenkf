% Input array of locations z and time t, and full truth u
% Output array of truth values u(t,z) at time t and locations z

function val = u_at(t,z)

global comp_time
global true_mesh N_true right
global u

L = length(z);                          % number of values
val = nan(1,L);
t_ind = find(abs(comp_time-t)<1e-4);    % find index of t in comp_time

val=spline(true_mesh,u(t_ind,1:N_true),z);


% Loop through locations
% for i=1:L
%     
%     loc = z(i);                         % placeholder
%     
%     % Find location within true_mesh
%     j = 1;
%     while(j < N_true && true_mesh(j+1) <= loc)
%         j = j+1;
%     end
%     if(abs(true_mesh(j)-loc)<1e-4)
%         val(i) = u(t_ind,j);
%     else
%         a = loc-true_mesh(j);
%         if (j == N_true)
%             b = right-loc;
%             val(i) = (b/(a+b))*u(t_ind,j)+(a/(a+b))+u(t_ind,1);
%         else
%             b = true_mesh(j+1)-loc;
%             val(i) = (b/(a+b))*u(t_ind,j)+(a/(a+b))*u(t_ind,j+1);
%         end
%     end
%     
% end