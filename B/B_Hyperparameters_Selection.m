function [out_1, out_2, out_3, out_4, out_5, out_6, out_7, out_8, out_9] = B_Hyperparameters_Selection(Gamma, ko, km, l0, p0, d)
    % Declare persistent variables to store values across function calls
    persistent gamma_1_out;
    persistent gamma_2_out;
    persistent gamma_3_out;
    persistent gamma_4_out;
    persistent ko_out;
    persistent km_out;
    persistent l0_out;
    persistent p0_out;
    persistent d_out;

    % Check if the input variable 'Gamma' exists
    if exist('Gamma','var')
        % Extract and assign values from the 'Gamma' input matrix to persistent variables
        gamma_1_out = Gamma(1, 1);
        gamma_2_out = Gamma(2, 2);
        gamma_3_out = Gamma(3, 3);
        gamma_4_out = Gamma(4, 4);
        
        % Assign values from other input variables to corresponding persistent variables
        ko_out = ko;
        km_out = km;
        l0_out = l0;
        p0_out = p0;
        d_out = d;
    end
    
    % Assign values of persistent variables to output variables
    out_1 = gamma_1_out;
    out_2 = gamma_2_out;
    out_3 = gamma_3_out;
    out_4 = gamma_4_out;
    out_5 = ko_out;
    out_6 = km_out;
    out_7 = l0_out;
    out_8 = p0_out;
    out_9 = d_out;
end
