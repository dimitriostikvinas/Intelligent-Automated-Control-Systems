function [V, k1star, k2star, lstar, nstar] = C_Lyapunov_function(e, K, L, N)

    [w_n, zeta, km, q, gamma1, gamma2, gamma3, d] = C_Hyperparameters_Selection();

    M = 1;
    G = 10;
    C = 1;

    k1star = M*w_n^2;
    k2star = 2*M*zeta*w_n - C;
    lstar = -M*km*w_n^2;
    nstar = -G;

    k1tilde = K(:, 1) - k1star;
    k2tilde = K(:, 2) - k2star;
    Ktilde = [k1tilde k2tilde];
    Ltilde = L - lstar;
    Ntilde = N - nstar;

    Am = [0 1; -w_n^2 -2*zeta*w_n];
    Q = [0  q*(w_n^2 - 1) ; q*(w_n^2 - 1)  4*q*zeta*w_n];
    P = lyap(Am, Q);

    Gamma = -1/lstar;

   

    V = zeros(length(K), 1);
    for i=1:length(V)
        V(i) = e(:, i)'*P*e(:, i) + trace(Ktilde(i, :)'*Gamma*Ktilde(i, :))/gamma1 + trace(Ltilde(i)'*Gamma*Ltilde(i))/gamma2 +...
            trace(Ntilde(i)'*Gamma*Ntilde(i))/gamma3;
    end

end
