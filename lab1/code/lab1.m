clc;

global a; a = 5.0;
global b; b = 0.1;
global sigma; sigma = 2.5;

global t0; t0 = 0.5;
global Q; Q = 10.0;

u0 = 0.05;
c = 2.0;
ro = 1.0;
L = 1.0;

T = 1.0;
N = 20;
M = 5000;

tau = T / M;
h = L / N;

t = 0:tau:T;
x = 0:h:L;   

koeff = tau / (c * ro * h^2);

Umax = 0;
Tmax = 0;
Kmax = 0;

U = zeros(N + 1, M + 1);
U(:, 1) = u0;

Ur = zeros(1, M + 1); 
Ur(1, 1) = u0;

for j=1:M
    U(1, j + 1) = u0;
    for i=2:N
        U(i, j + 1) = U(i, j) + koeff*( ...
            Kplus(U(i, j), U(i + 1, j))*(U(i + 1, j) - U(i, j)) - ...
            Kminus(U(i - 1, j), U(i, j))*(U(i, j) - U(i - 1, j)));  
        %fprintf('u(%d,%d)=%d\n', i, j + 1, U(i, j + 1));
        
        if U(i, j + 1) > Umax && (x(i) - L/2) < 1e-3
            Umax = U(i, j + 1);
            Tmax = t(j + 1);
        end; 
        
        k = K(U(i, j + 1));
        if k > Kmax
            Kmax = k;
        end;        
    end;
    
    Ur(1, j + 1) = Ur(1, j) + 4*koeff*( ...
        Kplus( Ur(1, j), U(N + 1, j))*(U(N + 1, j) - Ur(1, j)) - ...
        Kminus(U(N, j), Ur(1, j))*(Ur(1, j) - U(N, j)));        
    %fprintf('ur(%d)=%d\n', j, Ur(1, j + 1));
    U(N + 1, j + 1) = h.*W(t(j + 1))./ K(Ur(1, j + 1)) + U(N, j + 1);
    %fprintf('u(%d,%d)=%d\n', N + 1, j + 1, U(N + 1, j + 1));
end;

[T, X] = meshgrid(t, x);
mesh(T, X, U);

fprintf('Umax=%d\n', Umax);
fprintf('Kmax=%d\n', Kmax);
xlabel('t');
ylabel('x');
