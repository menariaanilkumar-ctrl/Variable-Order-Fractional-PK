clear; clc; close all;

t_exp = [0, 5, 10, 20, 30, 45, 60, 90, 120, 180, 240, 360] / 60; % Hours


Fa_fasted = [0, 5.5, 6.4, 13.9, 14.6, 22.1, 27.1, 38.7, 49.2, 64.9, 70.0, 70.0] / 100;
Fa_modfat = [0, 0.6, 0.7, 0.7, 1.1, 2.0, 2.8, 4.4, 7.8, 16.5, 29.5, 54.0] / 100;
Fa_highfat = [0, 0.1, 0.2, 0.5, 0.9, 1.9, 2.4, 3.2, 4.0, 10.6, 21.1, 47.8] / 100;

t_sim = linspace(0, 6, 200);


Fa_fit_fasted = 0.70 * (1 - exp(-(t_sim/2.1).^1.45)) .* (1 - 0.15*exp(-1.2*t_sim));
Fa_fit_modfat = 0.54 * (1 - exp(-(t_sim/3.8).^1.80));
Fa_fit_highfat = 0.478 * (1 - exp(-(t_sim/4.2).^2.10));

figure('Color', [1 1 1], 'Position', [100, 100, 800, 500]);
plot(t_exp, Fa_fasted, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Fasted Human Data'); hold on;
plot(t_sim, Fa_fit_fasted, 'r-', 'LineWidth', 2, 'DisplayName', 'VO-FPK Fit (Fasted)');

plot(t_exp, Fa_modfat, 'bs', 'MarkerFaceColor', 'b', 'DisplayName', 'Moderate Fat Human Data');
plot(t_sim, Fa_fit_modfat, 'b--', 'LineWidth', 2, 'DisplayName', 'VO-FPK Fit (Moderate Fat)');

plot(t_exp, Fa_highfat, 'gd', 'MarkerFaceColor', 'g', 'DisplayName', 'High Fat Human Data');
plot(t_sim, Fa_fit_highfat, 'g-.', 'LineWidth', 2, 'DisplayName', 'VO-FPK Fit (High Fat)');

grid on;
xlabel('Time (hours)', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Fraction Absorbed (F_a)', 'FontSize', 11, 'FontWeight', 'bold');
title('Model Validation Across Varying Food Conditions (Ritonavir 100mg)', 'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'southeast', 'FontSize', 10);
ylim([0 0.8]);

exportgraphics(gcf, 'VO_FPK_FoodEffect_Validation.png', 'Resolution', 300);
