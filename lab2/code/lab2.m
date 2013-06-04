a = 1;

N = 100;
L = 1.0;
h = L / N;

T = 1.0;
M = 200;
tau = T / M;

x = 0:h:L;
t = 0:tau:T;

u = zeros(N + 1, M + 1);

% вычисляем значения на нулевом слое
for i = 1:N+1 
    u(i, 1) = phi(x(i));
end;

% вычисляем значения на первом слое
u(1, 2) = mu(t(2));
u(N + 1, 2) = nu(t(2));
for i = 2:N
    u(i, 2) = u(i, 1) + psi(x(i))*tau + tau^2 * ( ...
        u(i - 1, 1) - 2*u(i, 1) + u(i + 1, 1)) / h^2 / 2.0;
end;

% вычисляем значения на всех остальных слоях
koeff = a^2*tau^2/h^2;
for j = 2:M
    u(1, j + 1) = mu(t(j + 1));
    u(N + 1, j + 1) = nu(t(j + 1));
    for i = 2:N
        u(i, j + 1) = 2*u(i, j) - u(i, j - 1) + ...
            koeff*(u(i - 1, j) - 2*u(i, j) + u(i + 1, j));
    end;    
end;

[T, X] = meshgrid(t, x);
mesh(X, T, u);
xlabel('x')
ylabel('t')
