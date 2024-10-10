function Ks = Xs_to_Ks_12k_origin(Xs)

kernel_type_option = [];
kernel_type_option.PolynomialDegrees = [2, 4];%2
kernel_type_option.PolyPlusDegrees = [2, 4];%2
kernel_type_option.GaussianDegrees = 2.^(-3:3);%7
kernel_type_option.Linear = 'Linear';%1

Ks = cell(length(Xs), 1);

for i1 = 1 : length(Xs)
    Xi = Xs{i1};
    Ki = buildKernels_v2(Xi, kernel_type_option);
    % Ki = kcenter(Ki); 
    % Ki = knorm(Ki);
    Ks{i1} = Ki;
end