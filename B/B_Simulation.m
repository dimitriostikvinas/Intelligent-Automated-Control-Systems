function [y, ym, epsilon, theta, t] = B_Simulation(tspan, initconds, Gamma_selected, ko_selected, km_selected, lo_selected, p0_selected, d_selected)
    % Call the B_Hyperparameters_Selection function to obtain hyperparameters
    [~] = B_Hyperparameters_Selection(Gamma_selected, ko_selected, km_selected, lo_selected, p0_selected, d_selected);

    % Solve the differential equation using ode45 with B_Direct_MRAC as the function
    [t, y_ode] = ode45(@B_Direct_MRAC, tspan, initconds);

    % Extract plant's and reference model's outputs
    y = y_ode(:, 1);
    ym = y_ode(:, 3);
    
    % Calculate the tracking error and extract the estimated parameters
    epsilon = y - ym;
    theta = y_ode(:, 11:14);
end
