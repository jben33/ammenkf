#!/bin/bash

model=BGM
WD=${GITDIR}/AMMEnKF
FD=${WD}/FIG/${model}_EUL_AMM21
LD=${GITDIR}/AMM_modular_ctg/FIG/KSM_MULTIRUN
LN=legend.png

panel=3;


if [ ${panel} == 3 ]; then
convert +append ${FD}/${model}_error_ens__size_01.png\
 ${FD}/${model}_error_inflation_01.png ${FD}/${model}_error_init_mesh_01.png\
 ${FD}/${model}_error.png
fi

if [ ${panel} == 4 ]; then
convert ${LD}/${LN} -scale 75% -depth 1200 ${FD}/${LN}
convert +append ${FD}/${model}_error_obs_error_01.png ${FD}/${model}_error_init_mesh_01.png ${FD}/${model}_error_bot.png
convert +append ${FD}/${model}_error_inflation_01.png ${FD}/${model}_error_ens__size_01.png ${FD}/${model}_error_top.png
convert -append ${FD}/${LN} ${FD}/${model}_error_top.png ${FD}/${model}_error_bot.png ${FD}/${model}_error.png
rm ${FD}/${model}_error_top.png ${FD}/${model}_error_bot.png
fi
