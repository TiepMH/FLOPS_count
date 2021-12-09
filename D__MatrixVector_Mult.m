M = 8; N = 17;
A = randn(M, N) + 1j*randn(M, N);
v = randn(N, 1) + 1j*randn(N, 1);

Av_real = zeros(M, 1);
Av_imag = zeros(M, 1);

count_Multiplications = 0;
count_Summations = 0;

for m=1:M
    for n=1:N
        if n==1
            Av_real(m) = real(A(m, n))*real(v(n)) - imag(A(m,n))*imag(v(n));
            Av_imag(m) = real(A(m, n))*imag(v(n)) + imag(A(m,n))*real(v(n));
            count_Multiplications = count_Multiplications + 4;
            count_Summations = count_Summations + 2;
        else
            Av_real(m) = Av_real(m) + real(A(m, n))*real(v(n)) - imag(A(m,n))*imag(v(n));
            Av_imag(m) = Av_imag(m) + real(A(m, n))*imag(v(n)) + imag(A(m,n))*real(v(n));
            count_Multiplications = count_Multiplications + 4;
            count_Summations = count_Summations + 4;
        end
    end
end

%% We have to check if z_ = z or not.
z_ = A*v;
z = Av_real + 1j .* Av_imag;
error = round(sum(z_ - z), 1);
error

%% Check if the number of FLOPS counted through simulation maches up with that derived theoretically.

FLOPS_Multiplications_theory = 4*M*N
FLOPS_Summations_theory = M*(4*N-2)

count_Multiplications
count_Summations
