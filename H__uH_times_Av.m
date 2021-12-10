M = 5; N = 9;
u = randn(M, 1) + 1j*randn(M, 1);
A = randn(M, N) + 1j*randn(M, N);
v = randn(N, 1) + 1j*randn(N, 1);

count_Multiplications = 0;
count_Summations = 0;

%% We calculate z = Av and store the real and imag part of z in 2 arrays
z_real = zeros(M, 1);
z_imag = zeros(M, 1);
for m=1:M
    for n=1:N
        if n == 1
            z_real(m) = real(A(m, n))*real(v(n)) - imag(A(m, n))*imag(v(n));
            z_imag(m) = real(A(m, n))*imag(v(n)) + imag(A(m, n))*real(v(n));
            count_Multiplications = count_Multiplications + 4;
            count_Summations = count_Summations + 2;
        else
            z_real(m) = z_real(m) + real(A(m, n))*real(v(n)) - imag(A(m, n))*imag(v(n));
            z_imag(m) = z_imag(m) + real(A(m, n))*imag(v(n)) + imag(A(m, n))*real(v(n));
            count_Multiplications = count_Multiplications + 4;
            count_Summations = count_Summations + 4;
        end
    end
end

z = z_real + 1j .* z_imag;

%% We now calculate a = uH * (Av) = uH * z as follows:
a_real = zeros(1);
a_imag = zeros(1);
for k=1:M
    if k == 1
        a_real = real(u(k))*z_real(k) + imag(u(k))*z_imag(k);
        a_imag = real(u(k))*z_imag(k) - imag(u(k))*z_real(k);
        count_Multiplications = count_Multiplications + 4;
        count_Summations = count_Summations + 2;
    else
        a_real = a_real + real(u(k))*z_real(k) + imag(u(k))*z_imag(k);
        a_imag = a_imag + real(u(k))*z_imag(k) - imag(u(k))*z_real(k);
        count_Multiplications = count_Multiplications + 4;
        count_Summations = count_Summations + 4;
    end
end

%% Check if a_real + 1j .* a_imag = u' * A * v = u' * z or not
u' * z
u' * A * v
a = a_real + 1j * a_imag

%% Check if the number of FLOPS counted through simulation maches up with that derived theoretically. 
count_Multiplications
count_Summations

FLOPS_Multiplications_theory = 4*M*(N+1)
FLOPS_Summations_theory = 4*M*N + 2*M - 2