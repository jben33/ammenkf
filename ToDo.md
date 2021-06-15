- What are the issues that forced you to change all these files?

1) The truth seems to be generated differently based on the observation type (EUL or LAG).  The truth should be generated on an Eulerian grid in all cases, regardless of the observation type.
2) The Lagrangian observations are not truly Lagrangian - the mesh locations undergo the remeshing procedure.
3) In the low-res case (for both EUL and LAG observations), I get a "too many input arguments" error in the forward_ensemble method.
4) The high-res case runs for both EUL and LAG observations, but all of the analysis ensemble members have the same mesh.  This should not be the case; each analysis ensemble member should have its own mesh, and it should be the same as its forecast mesh.


Some of the files are useless such as diff_ensemble.m or fixed_mesh_single.m. They are just to test an idea. However, some others such as map_admesh.m are needed for LR application. How should we implement them otherwise? Any suggestions?

-  BGM/HR/forecast_bgm.m       | 124 ++++++++++++++++++++++++++++++++++++++++++++
-  BGM/{ => LR}/forecast_bgm.m |  65 ++++++++++++++---------
-  EnKF/fw_ensemble.m          |   2 +-
-  KSM/HR/forecast_ksm.m       |  88 +++++++++++++++++++++++++++++++
-  KSM/HR/generate_truth_ksm.m | 106 +++++++++++++++++++++++++++++++++++++
-  KSM/LR/forecast_ksm.m       |  88 +++++++++++++++++++++++++++++++
-  KSM/LR/generate_truth_ksm.m | 106 +++++++++++++++++++++++++++++++++++++
-  KSM/forecast_ksm.m          |  70 -------------------------
-  KSM/generate_truth_ksm.m    |  61 ----------------------
-  load_parameter.m            |  17 +++---
-  run_AMMEnKF.m               |   4 +-
-  11 files changed, 563 insertions(+), 168 deletions(-)
- 
-  {Unused => EnKF}/active_cells.m         |   0         **Why don't we use this anymore?**
-  {Unused => EnKF}/compute_anomaly.m      |   0
-  {Unused => EnKF}/effective_size.m       |   0         **Why don't we use this anymore?**
-  {Unused => EnKF}/ens_cov.m              |   0
-  EnKF/ens_update.m                       |  32 +++++--
-  EnKF/forecast_stats.m                   |   8 --
-  {Unused => EnKF}/forward_ensemble.m     |   0
-  {Unused => EnKF}/get_Hx.m               |   0
-  EnKF/kalman_gain.m                      |  40 +++++---
-  {Unused => EnKF}/u_anomaly.m            |   0
-  {Unused => MESH/HR}/embed.m             |   0
-  {Unused => MESH/HR}/fill_ensemble.m     |   0
-  MESH/HR/fixed_mesh_single.m             |  13 +++
-  MESH/HR/insert_mesh.m                   |  22 +++++
-  {Unused => MESH/HR}/insert_mesh_lr.m    |   0
-  {Unused => MESH/LR}/fixed_mesh_single.m |   0
-  {Unused => MESH/LR}/insert_mesh.m       |   0
-  {Unused => MESH/LR}/map_admesh.m        |   0
-  {Unused => MESH}/insert_mesh_HR.m       |   0
-  MESH/insert_mesh_LR.m                   |  37 ++++++++
-  OBS/gen_obs.m                           |   3 +-
-  {Unused => POST}/Velocity_surface.m     |   0
-  {Unused => POST}/clear_after.m          |   0
-  POST/compute_error_stats.m              |  10 --
-  {Unused => POST}/diff_ensemble.m        |   0
-  POST/plot_error_stats.m                 | 145 ++++++++++++++++++++++++++--
-  POST/plot_time_evolution.m              |  93 ++++++++++++------
-  MESH/embed_HR.m => embed_HR.m           |   0
-  MESH/fill_in.m => fill_in.m             |   0
-  EnKF/fw_ensemble.m => fw_ensemble.m     |   6 +-
-  Unused/get_H.m => get_H.m               |   0
-  EnKF/get_HA.m => get_HA.m               |   0
-  load_parameter.m                        |  20 ++--
-  run_AMMEnKF.m                           | 161 ++++++++++++++++++++++++--------
-  34 files changed, 462 insertions(+), 128 deletions(-)


You two should talk soon to:
1) establish the final converged version of the code to use
2) list the experiments to run and, in case, share their execution and/or graphical output
3) decide how to share the edition charge, i.e., who is starting editing the paper and from where.
