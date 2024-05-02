function dydt = C_Direct_MRAC(t, y)
    
    r = 1.5*sin(1.3*t) + 1.8* cos(1.6*t) ;
    
    [w_n, zeta, km, q, gamma1, gamma2, gamma3, d] = C_Hyperparameters_Selection();

    M = 1;
    G = 10;
    C = 1;

    A = [0 1 ; 0 -C/M];
    B = [0 ; 1];
    Lambda = 1/M;

    Am = [0 1; -w_n^2 -2*zeta*w_n];
    Bm = [0 ; km*w_n^2];

    %Lyapunov equation
    Q = [0 q*(w_n^2 - 1) ; q*(w_n^2 - 1)  4*q*zeta*w_n];
    
    P = lyap(Am, Q);
    

    %actual system's state variables
    x = y(1:2); 

    %identification system's state variables
    xm = y(3:4);  
    
    % error
    e = x - xm; % 2x1
    
    K = y(5:6)';
    L = y(7);
    N = y(8);

    phi = sin(x(1));
    f = -G*phi;

    u = -K * x - L * r - N * phi + d* (t > 100 & t < 105);

    dydt = zeros(size(y));

    % Actual system's dynamics
    dydt(1:2) = A*x+ B*Lambda*(u + f);

    % Model system's dynamics
    dydt(3:4) = Am*xm + Bm*r;
    
    % K1 
    dydt(5:6) = gamma1*Bm'*P*e*x';

    % K2 
    dydt(7) = gamma2*Bm'*P*e*r;
    
    % L 
    dydt(8) = gamma3*Bm'*P*e*phi;

end
