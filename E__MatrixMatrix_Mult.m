M = 8; N = 17; L = 2;
A = randn(M, N) + 1j*randn(M, N);
B = randn(N, L) + 1j*randn(N, L);
AB_real = zeros(M, L);
AB_imag = zeros(M, L);

count_Multiplications = 0;
count_Summations = 0;


for m=1:M
    for ell=1:L
        AB_real(m, ell) = 0;
        AB_imag(m, ell) = 0;
        for n=1:N
            if n==1
                %% calculate the real part of the (m, ell)-th of AB
                AB_real(m, ell) = real(A(m, n))*real(B(n,ell)) - imag(A(m, n))*imag(B(n,ell));
                % the above operation has 2 multiplications and 1 summation
                count_Multiplications = count_Multiplications + 2;
                count_Summations = count_Summations + 1;
                %% calculate the imag. part of the (m, ell)-th of AB
                AB_imag(m, ell) = real(A(m, n))*imag(B(n,ell)) + imag(A(m, n))*real(B(n,ell));
                % the above operation has 2 multiplications and 1 summation
                count_Multiplications = count_Multiplications + 2;
                count_Summations = count_Summations + 1;
            else
                %% calculate the real part of the (m, ell)-th of AB
                AB_real(m, ell) = AB_real(m, ell) + real(A(m, n))*real(B(n,ell)) - imag(A(m, n))*imag(B(n,ell));
                % the above operation has 2 multiplications and 2 summation
                count_Multiplications = count_Multiplications + 2;
                count_Summations = count_Summations + 2;
                %% calculate the imag. part of the (m, ell)-th of AB
                AB_imag(m, ell) = AB_imag(m, ell) + real(A(m, n))*imag(B(n,ell)) + imag(A(m, n))*real(B(n,ell));
                % the above operation has 2 multiplications and 2 summation
                count_Multiplications = count_Multiplications + 2;
                count_Summations = count_Summations + 2;
            end
        end
    end
end

%%
AB_ = A*B;
AB = AB_real + 1j .* AB_imag;
error = round(sum(AB_ - AB), 1);
error

%% 
FLOPS_Multiplications_theory = M*L*(4*N);
FLOPS_Summations_theory = M*L*(4*N-2);

count_Multiplications
FLOPS_Multiplications_theory

count_Summations
FLOPS_Summations_theory

