% Input ensemble, start time, end time
% Output that ensemble forecasted forward from start time to end time

function fc = fw_ensemble(ens,t1,t2)

global model

N1 = length(ens);
fc = cell(N1,1);


for i=1:N1
    if(strcmp(model,'BGM'))
        fc{i} = forecast_bgm(ens{i},t1,t2);
    elseif(strcmp(model,'KSM'))
        fc{i} = forecast_ksm(ens{i},t1,t2);
    end
end