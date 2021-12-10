M = 6; N = 15;
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

%% We now calculate || Av ||^2 = || z ||^2 as follows:
sqNorm = zeros(1);
for m=1:M
    if m == 1
        sqNorm = z_real(1)^2 + z_imag(1)^2;
        count_Multiplications = count_Multiplications + 2;
        count_Summations = count_Summations + 1;
    else
        sqNorm = sqNorm + z_real(m)^2 + z_imag(m)^2;
        count_Multiplications = count_Multiplications + 2;
        count_Summations = count_Summations + 2;
    end
end


%% We have to check if || Av ||^2 = sqNorm or not.
sqNorm_ = norm(A*v, 2)^2
sqNorm
error = round(sqNorm_ - sqNorm, 1);
error

%% Check if the number of FLOPS counted through simulation matches up with that derived theoretically. 

FLOPS_Multiplications_theory = 2*M*(2*N + 1)
FLOPS_Summations_theory = 4*M*N - 1
 
count_Multiplications
count_Summations