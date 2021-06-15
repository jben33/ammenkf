fsize=30;
% Load saved figures
f1=openfig('FIG/KSM_MULTIRUN/multi_error_ens_size_inf10.fig','reuse');
ax1 = findobj(gcf,'Type','axes');
f2=openfig('FIG/KSM_MULTIRUN/multi_error_inf_fac_ens30.fig','reuse');
ax2 = findobj(gcf,'Type','axes');
f3=openfig('FIG/KSM_MULTIRUN/multi_error_init_emesh_size.fig','reuse');
ax3 = findobj(gcf,'Type','axes');
f4=openfig('FIG/KSM_MULTIRUN/multi_error_obs_var','reuse');
ax4 = findobj(gcf,'Type','axes');
% Prepare subplots
figure('Name','Merged_sensitivity_KSM','DefaultAxesFontSize',fsize)
set(gcf,'Units','inches','OuterPosition', [1.0, 1.0, 25, 25])
h(1)=subplot(2,2,1);
h(2)=subplot(2,2,2);
h(3)=subplot(2,2,3);
h(4)=subplot(2,2,4);
fig1 = get(ax1,'children');
fig2 = get(ax2,'children');
fig3 = get(ax3,'children');
fig4 = get(ax4,'children');
% P4ste figures on the subplots
copyobj(fig1,h(1)); %copy children to new parent axes i.e. the subplot axes
copyobj(fig2,h(2));
copyobj(fig3,h(3));
copyobj(fig4,h(4));
