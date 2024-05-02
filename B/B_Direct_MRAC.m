function dydt = B_Direct_MRAC(t, y)
    % Reference signal(rich enough)
    r = 1.5*sin(1.3*t) + 1.8*cos(1.6*t);
    
    % Obtain hyperparameters from B_Hyperparameters_Selection
    [gamma_1, gamma_2, gamma_3, gamma_4, ko, km, lo, p0, d] = B_Hyperparameters_Selection();
    Gamma = diag([gamma_1, gamma_2, gamma_3, gamma_4]);

    % System parameters
    M = 1;
    G = 10;
    C = 1;

    % System matrices
    A = [0 1; -G/M -C/M];
    B = [0; 1/M];
    Cc = [1 0];

    % Model matrices
    Am = [0 1; -ko^2 -2*ko];
    Bm = [0; km];
    Ccm = [1 0];

    % Actual system's state variables
    x = y(1:2);

    % Identification system's state variables
    xm = y(3:4);

    % Error
    epsilon = Cc*x - Ccm*xm;

    % w
    w = y(5:6);
    w = [w(1) w(2) Cc*x r]';

    % phi
    phi = y(7:10);

    % Parameter estimations
    theta = y(11:14);

    dydt = zeros(size(y));

    % Control law
    u = theta' * w - phi'*Gamma*phi*epsilon + d*(t > 10 & t < 15);

    % Actual system's dynamics
    dydt(1:2) = A*[sin(x(1)); x(2)] + B*u;

    % Model system's dynamics
    dydt(3:4) = Am*xm + Bm*r;

    % w
    dydt(5:6) = -lo * w(1:2) + [u; Cc*x];

    % phi
    dydt(7:10) = -p0 * phi + w;

    % theta, Adaptive Law
    dydt(11:14) = -Gamma * epsilon * phi;
end
