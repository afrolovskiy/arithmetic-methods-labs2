a = 1;
b = 1;

Nx = 25;
hx = a / Nx;
x = 0:hx:a;

Ny = 25;
hy = b / Ny;
y = 0:hy:b;

% инициализируем начальное приближение
u = zeros(Ny + 1, Nx + 1);
for j = 1:Nx+1
    u(1, j) = psi0(x(j));
    u(Ny + 1, j) = psib(x(j));
end;
for i = 1:Ny+1
    u(i, 1) = phi0(y(i));
    u(i, Nx + 1) = phia(y(i));
end;

omg = omega(Nx);
eps = 1e-4;

reqDelta = (2-omg)*eps;

norm = norma(u);
K = log(eps/norm);
N = max(Nx, Ny);
maxIteration = K*N/2/pi;

koeff = 2*(hx^2 + hy^2);

iteration = 0;
while true
    delta = 0;
    for i = 2:Ny
        for j = 2:Nx
            old = u(i, j);
            u(i,j) = (1 - omg)*u(i, j) + omg*(...
                hy^2*(u(i - 1, j) + u(i + 1, j))/koeff + ...
                hx^2*(u(i, j - 1) + u(i, j + 1))/koeff + ...
                hx^2*hy^2*f(x(j), y(i)));
            d = abs(u(i, j) - old);
            if d > delta
                delta = d;
            end
        end;
    end;
    
    if iteration >= maxIteration || reqDelta < delta
        break;
    end
end;

[Y, X] = meshgrid(y, x);
mesh(X, Y, u);
xlabel('x')
ylabel('y')



