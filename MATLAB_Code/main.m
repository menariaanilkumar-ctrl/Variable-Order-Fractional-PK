clear; clc; close all;

t_exp = [0, 5, 10, 20, 30, 45, 60, 90, 120, 180, 240, 360] / 60; % Hours
Fa_fasted = [0, 5.5, 6.4, 13.9, 14.6, 22.1, 27.1, 38.7, 49.2, 64.9, 70.0, 70.0] / 100;


t_sim = linspace(0, 6, 200);
Fa_fit_VOFPK = 0.70 * (1 - exp(-(t_sim/2.1).^1.45)) .* (1 - 0.15*exp(-1.2*t_sim));
Fa_fit_FPK   = 0.70 * (1 - exp(-(t_sim/1.8).^0.8)); % Fixed-order FPK (alpha=0.8)


Fa_VOFPK_pts = interp1(t_sim, Fa_fit_VOFPK, t_exp);
Fa_FPK_pts   = interp1(t_sim, Fa_fit_FPK, t_exp);
Fa_ODE_pts   = 0.70 * (1 - exp(-0.52 * t_exp));


res_VOFPK = Fa_fasted - Fa_VOFPK_pts;
res_FPK   = Fa_fasted - Fa_FPK_pts;
res_ODE   = Fa_fasted - Fa_ODE_pts;


figure('Color', [1 1 1], 'Position', [100, 100, 850, 420]);


stem(t_exp, res_ODE, 'k--o', 'LineWidth', 1.3, 'MarkerFaceColor', 'k', ...
     'DisplayName', 'Classical ODE Residuals'); hold on;


stem(t_exp, res_FPK, 'g--^', 'LineWidth', 1.5, 'MarkerFaceColor', 'g', ...
     'DisplayName', 'Fixed-Order FPK (\alpha=0.8) Residuals');


stem(t_exp, res_VOFPK, 'b-s', 'LineWidth', 2.0, 'MarkerFaceColor', 'b', ...
     'DisplayName', 'Proposed VO-FPK Residuals');


yline(0, 'r--', 'LineWidth', 1, 'DisplayName', 'Zero-Error Baseline');

grid on;
xlabel('Time (hours)', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Residual Error (F_{a,exp} - F_{a,pred})', 'FontSize', 11, 'FontWeight', 'bold');
title('Residual Error Comparison: Classical ODE vs. Fixed-Order FPK vs. Proposed VO-FPK', ...
      'FontSize', 11, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 9);


exportgraphics(gcf, 'VO_FPK_Residual_Analysis.png', 'Resolution', 300);
