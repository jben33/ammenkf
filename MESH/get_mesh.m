% input ensemble member
% returns mesh points of ensemble member, without placeholders

function z = get_mesh(em)

  L = length(em);
  temp = em(L/2+1:L);
  temp(find(isnan(temp)))=[];
  z = temp;
