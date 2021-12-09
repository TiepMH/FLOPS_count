N = 17;
x = randn(N, 1) + 1j*randn(N, 1);
y = randn(N, 1) + 1j*randn(N, 1);

xH_y_real = zeros(1);
xH_y_imag = zeros(1);

count_Multiplications = 0;
count_Summations = 0;

for n=1:N
    if n==1
        xH_y_real = real(x(n))*real(y(n)) + imag(x(n))*imag(y(n));
        xH_y_imag = real(x(n))*imag(y(n)) - imag(x(n))*real(y(n));
        count_Multiplications = count_Multiplications + 4;
        count_Summations = count_Summations + 2;
    else
        xH_y_real = xH_y_real + real(x(n))*real(y(n)) + imag(x(n))*imag(y(n));
        xH_y_imag = xH_y_imag + real(x(n))*imag(y(n)) - imag(x(n))*real(y(n));
        count_Multiplications = count_Multiplications + 4;
        count_Summations = count_Summations + 4;
    end
end

%% We have to check if z_ = z or not.
z_ = x' *y;
z = xH_y_real + 1j .* xH_y_imag;
error = round(sum(z_ - z), 1);
error

%% Check if the number of FLOPS counted through simulation maches up with that derived theoretically. 

FLOPS_Multiplications_theory = 4*N
FLOPS_Summations_theory = 4*N-2

count_Multiplications
count_Summations



