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
delta = (2-omg)*eps;

K = abs(log(eps/norm1(u)));
N = max(Nx, Ny);
maxIteration = K*N/2/pi;

koeff = 2*(hx^2 + hy^2);
koeffx = hx^2 / koeff;
koeffy = hy^2 / koeff;
koeffxy = hx^2*hy^2 / koeff;



iteration = 0;
while true
    iteration = iteration + 1;
    delta = 0;
    oldu = u;
    for i = 2:Ny
        for j = 2:Nx
            u(i,j) = (1 - omg)*u(i, j) + omg*(...
                koeffy *(u(i - 1, j) + u(i + 1, j)) + ...
                koeffx*(u(i, j - 1) + u(i, j + 1)) + ...
                koeffxy*f(x(j), y(i)));
        end;
    end;
    
    norm1(oldu)
    if (iteration >= maxIteration) || (norm1(oldu) < delta)
        break;
    end
end;

[Y, X] = meshgrid(y, x);
mesh(X, Y, u);
xlabel('x')
ylabel('y')



