M = 7;
alpha = randn(1) + 1j*randn(1);
u = randn(M, 1) + 1j*randn(M, 1);

count_Multiplications = 0;
count_Summations = 0;

au_real = zeros(M, 1);
au_imag = zeros(M, 1);

for m=1:M
    au_real(m) = real(alpha)*real(u(m)) - imag(alpha)*imag(u(m));
    au_imag(m) = real(alpha)*imag(u(m)) + imag(alpha)*real(u(m));
    count_Multiplications = count_Multiplications + 4;
    count_Summations = count_Summations + 2;
end

%%
au_ = au_real + 1j .* au_imag;
au = alpha * u;
error = round(au_ - au, 1)

%%
count_Multiplications
FLOPS_Multiplications_theory = 4*M

count_Summations
FLOPS_Summations = 2*M