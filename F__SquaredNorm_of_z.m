N = 14;
z = randn(N, 1) + 1j*randn(N, 1);

sqNorm = zeros(1);

count_Multiplications = 0;
count_Summations = 0;

for n=1:N
    if n==1
        sqNorm = real(z(n))*real(z(n)) + imag(z(n))*imag(z(n));
        count_Multiplications = count_Multiplications + 2;
        count_Summations = count_Summations + 1;
    else
        sqNorm = sqNorm + real(z(n))*real(z(n)) + imag(z(n))*imag(z(n));
        count_Multiplications = count_Multiplications + 2;
        count_Summations = count_Summations + 2;
    end
end

%% We have to check if z_ = z or not.
sqNorm_ = z' * z;
error = round(sum(sqNorm_ - sqNorm), 1);
error

%% Check if the number of FLOPS counted through simulation maches up with that derived theoretically. 

FLOPS_Multiplications_theory = 2*N
FLOPS_Summations_theory = 2*N-1

count_Multiplications
count_Summations