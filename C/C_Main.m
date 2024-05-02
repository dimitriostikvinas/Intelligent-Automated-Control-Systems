clear all

% Set disturbance pulse magnitude 'd'
d = 0;

% Set system parameters and hyperparameters
zeta = 0.7;  % 0.7
w_n = 1;     % 1
km = 1;
q = 100;
gamma1 = 10;
gamma2 = 10;
gamma3 = 10;

% Set initial conditions
initconds = [0 0 0 0 0 0 0 0];

% Set time span for simulation
tspan = 0:0.01:500;

% Simulate the system using C_Simulation function
[x, xm, e, K, L, N, t] = C_Simulation(tspan, initconds, w_n, zeta, km, q, gamma1, gamma2, gamma3, d);

% Generate reference signal
r = 1.5*sin(1.3*t) + 1.8*cos(1.6*t);

% Calculate control input u for plotting
u = zeros(length(x), 1);
for i = 1:length(u)
    u(i) = -K(i, :) * x(:, i) - L(i) * r(i) - N(i)*sin(x(1, i)) + d*(t(i) >= 100 & t(i) <= 105);
end

% Calculate Lyapunov function values
[V, k1star, k2star, lstar, nstar] = C_Lyapunov_function(e, K, L, N);

% Subplot 1
subplot(2, 2, 1)
plot(t, x(1, :), 'LineWidth', 1.2, 'DisplayName', 'Plant First State');
hold on;
plot(t, xm(1, :), 'LineWidth', 1.2, 'DisplayName', 'Reference Model First State');
hold off;
title("First State", 'Interpreter', 'Latex', 'FontSize', 14);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'FontSize', 12);
legend('Location', 'Best', 'Interpreter', 'Latex');
if (d)
    xline(100, 'r', 'LineWidth', 2, 'Label', 'start', 'HandleVisibility', 'off');
    xline(105, 'g', 'LineWidth', 2, 'Label', 'end', 'HandleVisibility', 'off');
end
xlim([min(t), max(t)]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 12);

% Subplot 2
subplot(2, 2, 2)
plot(t, x(2, :), 'LineWidth', 1.2, 'DisplayName', 'Plant Second State');
hold on;
plot(t, xm(2, :), 'LineWidth', 1.2, 'DisplayName', 'Reference Model Second State');
hold off;
title("Second State", 'Interpreter', 'Latex', 'FontSize', 14);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'FontSize', 12);
legend('Location', 'Best', 'Interpreter', 'Latex');
if (d)
    xline(100, 'r', 'LineWidth', 2, 'Label', 'start', 'HandleVisibility', 'off');
    xline(105, 'g', 'LineWidth', 2, 'Label', 'end', 'HandleVisibility', 'off');
end
xlim([min(t), max(t)]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 12);

% Subplot 3
subplot(2, 2, 3)
plot(t, e(1, :), 'LineWidth', 1.2, 'DisplayName', '$e$');
title('Tracking Error $\epsilon$', 'Interpreter', 'Latex', 'FontSize', 14);
ylabel('$\epsilon$', 'Interpreter', 'Latex', 'FontSize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'FontSize', 12);
legend('Location', 'Best', 'Interpreter', 'Latex');
if (d)
    xline(100, 'r', 'LineWidth', 2, 'Label', 'start', 'HandleVisibility', 'off');
    xline(105, 'g', 'LineWidth', 2, 'Label', 'end', 'HandleVisibility', 'off');
end
xlim([min(t), max(t)]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 12);

% Subplot 4
subplot(2, 2, 4)
plot(t, e(2, :), 'LineWidth', 1.2, 'DisplayName', '$\dot{e}$');
title('Tracking Error $\epsilon$', 'Interpreter', 'Latex', 'FontSize', 14);
ylabel('$\epsilon$', 'Interpreter', 'Latex', 'FontSize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'FontSize', 12);
legend('Location', 'Best', 'Interpreter', 'Latex');
if (d)
    xline(100, 'r', 'LineWidth', 2, 'Label', 'start', 'HandleVisibility', 'off');
    xline(105, 'g', 'LineWidth', 2, 'Label', 'end', 'HandleVisibility', 'off');
end
xlim([min(t), max(t)]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 12);

% Set a title for the overall plot
sgtitle(sprintf('Direct Full-State MRAC\n  Parameters: km=%.2f, q=%.2f, gamma_1=%.2f, gamma_2=%.2f, gamma_3=%.2f, d=%.2f', km, q, gamma1, gamma2, gamma3, d));
