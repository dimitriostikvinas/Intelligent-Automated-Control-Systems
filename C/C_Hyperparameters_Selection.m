function [out_1, out_2, out_3, out_4, out_5, out_6, out_7, out_8] = C_Hyperparameters_Selection(w_n, zeta, km, q, gamma1, gamma2, gamma3, d)
    % Declare persistent variables to store values across function calls
    persistent w_n_out;
    persistent zeta_out;
    persistent km_out;
    persistent q_out;
    persistent gamma1_out;
    persistent gamma2_out;
    persistent gamma3_out;
    persistent d_out;

    % Check if input variables exist
    if exist('w_n', 'var')
        % Assign values from input parameters to persistent variables
        w_n_out = w_n;
        zeta_out = zeta;
        km_out = km;
        q_out = q;
        gamma1_out = gamma1;
        gamma2_out = gamma2;
        gamma3_out = gamma3;
        d_out = d;
    end
    
    % Assign values of persistent variables to output variables
    out_1 = w_n_out;
    out_2 = zeta_out;
    out_3 = km_out;
    out_4 = q_out;
    out_5 = gamma1_out;
    out_6 = gamma2_out;
    out_7 = gamma3_out;
    out_8 = d_out;
end
