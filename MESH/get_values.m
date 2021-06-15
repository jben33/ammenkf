% input ensemble member
% returns values at mesh points of ensemble member, without placeholders

function u = get_values(em)

L = length(em);
temp = em(1:L/2);
temp(find(isnan(temp)))=[];
u = temp;