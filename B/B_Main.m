clear all

% Set a large value for the disturbance pulse magnitude 'd'
d = 0;

% Define hyperparameters and initial conditions
[gamma_1, gamma_2, gamma_3, gamma_4] = deal(5, 1, 1, 1000);
Gamma = diag([gamma_1, gamma_2, gamma_3, gamma_4]);
ko = 10;
km = 100;
p0 = 0.01;
l0 = 0.01;

% Initialize state variables
initconds = zeros(14, 1);

% Set the time span for simulation
tspan = 0:0.01:50;

% Simulate the system using B_Simulation function
[y, ym, epsilon, theta, t] = B_Simulation(tspan, initconds, Gamma, ko, km, l0, p0, d);

% Generate the reference signal(rich enough)
r = 1.5*sin(1.3*t) + 1.8*cos(1.6*t);

% Subplot 1
subplot(2, 1, 1)
plot(t, y, 'LineWidth', 1.2, 'DisplayName', 'Plant Output');
hold on;
plot(t, ym, 'LineWidth', 1.2, 'DisplayName', 'Reference Model Output');
hold on;
plot(t, r, 'LineWidth', 1.2, 'DisplayName', 'Input');
hold off;
title("Plant's and Reference Model's Outputs", 'Interpreter', 'Latex', 'FontSize', 14);
ylabel('Output', 'Interpreter', 'Latex', 'FontSize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'FontSize', 12);
legend('Location', 'Best', 'Interpreter', 'Latex'); 
if (d)
    xline(10, 'r', 'LineWidth', 2, 'Label', 'start', 'HandleVisibility', 'off');
    xline(15, 'g', 'LineWidth', 2, 'Label', 'end', 'HandleVisibility', 'off');
end

xlim([min(t), max(t)]);
ylim([min(min(min(y, ym), r)), max(max(max(y, ym), r))]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 12);

% Subplot 2
subplot(2, 1, 2)
plot(t, epsilon, 'LineWidth', 1.2, 'DisplayName', '$\epsilon$');
title('Tracking Error $\epsilon$', 'Interpreter', 'Latex', 'FontSize', 14);
ylabel('$\epsilon$', 'Interpreter', 'Latex', 'FontSize', 12);
xlabel('Time (sec)', 'Interpreter', 'Latex', 'FontSize', 12);
legend('Location', 'Best', 'Interpreter', 'Latex');
xlim([min(t), max(t)]);
ylim([min(epsilon), max(epsilon)]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 12);

if (d)
    xline(10, 'r', 'LineWidth', 2, 'Label', 'start', 'HandleVisibility', 'off');
    xline(15, 'g', 'LineWidth', 2, 'Label', 'end', 'HandleVisibility', 'off');
end

% Set a title for the overall plot
sgtitle(sprintf('Direct MRAC for n* = 2 \n  Parameters: ko=%.2f, km=%.2f, l0=%.2f, p0=%.2f, Gamma=diag(%.2f, %.2f, %.2f, %.2f), d = %.2f', ko, km, l0, p0, gamma_1, gamma_2, gamma_3, gamma_4, d));



