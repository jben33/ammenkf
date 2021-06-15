# EnKF on Adaptive Moving Mesh Models

- BGM: Burger' Model
- KSM: Kuramoto - Sivashinsky Model
- OBS: Observation related code
- EnKF: Tool to perform data assimilation (DA)
- POST: Post processing tools (plotting, cleaning etc.)

Main executable is the **run_AMMENKF.m**.

**load_parameter** sets the constant parameters.

## Directory tree
README.md ToDo.md load_parameter.m run_AMMEnKF.m u_at.m

./BGM:
README.md forecast_bgm.m generate_truth_bgm.m

./EnKF:
README.md ens_mean.m ens_update.m forecast_stats.m fw_ensemble.m get_H.m
get_HA.m initialize_ensemble.m kalman_gain.m stat_forecast.m

./KSM:
README.md forecast_ksm.m generate_truth_ksm.m

./MESH:
embed_HR.m embed_LR.m fill_in.m get_mesh.m get_values.m remesh.m

./OBS:
README.md gen_obs.m 
./POST:
README.md compute_error_stats.m plot_error_stats.m plot_time_evolution.m

./Unused:
Velocity_surface.m
active_cells.m
clear_after.m
compute_anomaly.m
diff_ensemble.m
effective_size.m
embed.m
ens_cov.m
fill_ensemble.m
fixed_mesh_single.m
forward_ensemble.m
get_H.m
get_Hx.m
insert_mesh.m
insert_mesh_HR.m
insert_mesh_lr.m
map_admesh.m
u_anomaly.m
