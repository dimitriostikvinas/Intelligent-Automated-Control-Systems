function [x, xm, e, K, L, N, t] = C_Simulation(tspan, initconds, w_n_selected, zeta_selected, km_selected, q_selected, gamma1_selected, gamma2_selected, gamma3_selected, d_selected)
    % Call the C_Hyperparameters_Selection function to obtain hyperparameters
    [~] = C_Hyperparameters_Selection(w_n_selected, zeta_selected, km_selected, q_selected, gamma1_selected, gamma2_selected, gamma3_selected, d_selected);

    % Solve the differential equation using ode45 with C_Direct_MRAC as the function
    [t, y_ode] = ode45(@C_Direct_MRAC, tspan, initconds);

    % Extract the plant's and reference model's state variables
    x = y_ode(:, 1:2)';
    xm = y_ode(:, 3:4)';
    
    % Calculate the errors and the control parameter estimations
    e = x - xm;
    K = y_ode(:, 5:6);
    L = y_ode(:, 7);
    N = y_ode(:, 8);
end
