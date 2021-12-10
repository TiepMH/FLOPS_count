M = 7; N = 8;
alpha = randn(1);  % alpha is real-valued 
A = randn(M, N) + 1j*randn(M, N);

aA_real = zeros(M, N);
aA_imag = zeros(M, N);

count_Multiplications = 0;
count_Summations = 0;

for m=1:M
    for n=1:N
        aA_real(m, n) = alpha * real(A(m, n));
        aA_imag(m, n) = alpha * imag(A(m, n));
        count_Multiplications = count_Multiplications + 2;
        count_Summations = count_Summations + 0;
    end
end

%%
aA_ = aA_real + 1j .* aA_imag
aA = alpha .* A
err = round(aA_ - aA, 1)

%%
count_Multiplications
FLOPS_Multiplications_theory = 2*M*N