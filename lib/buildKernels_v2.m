function Ks = buildKernels_v2(X, kernel_type_option)

[nSmp, ~] = size(X);
kernel_option = [];

if ~isfield(kernel_type_option, 'PolynomialDegrees')
    len1 = 0;
else
    PolynomialDegrees = kernel_type_option.PolynomialDegrees;
    len1 = length(PolynomialDegrees);
end

if ~isfield(kernel_type_option, 'PolyPlusDegrees')
    len2 = 0;
else
    PolyPlusDegrees = kernel_type_option.PolyPlusDegrees;
    len2 = length(PolyPlusDegrees);
end

if ~isfield(kernel_type_option, 'GaussianDegrees')
    len3 = 0;
else
    GaussianDegrees = kernel_type_option.GaussianDegrees;
    len3 = length(GaussianDegrees);
end

if ~isfield(kernel_type_option, 'Linear')
    len4 = 0;
else
    kernel_option.KernelType = kernel_type_option.Linear;
    len4 = 1;
end

nKernel = len1 + len2 + len3 + len4;  

Ks = zeros(nSmp, nSmp, nKernel);  % 72*72*12

if isfield(kernel_option, 'KernelType')
    Ks(:, :, 1) = constructKernel(X, [], kernel_option);
end

if exist('PolynomialDegrees', 'var')
    for i1 = 1 : len1
        kernel_option = [];
        kernel_option.KernelType = 'Polynomial';
        kernel_option.d = PolynomialDegrees(i1);
        Ks(:, :, i1 + len4) = constructKernel(X, [], kernel_option);  
    end
end

if exist('PolyPlusDegrees', 'var')
    for i1 = 1:len2
        kernel_option = [];
        kernel_option.KernelType = 'PolyPlus';
        kernel_option.d = PolyPlusDegrees(i1);
        Ks(:, :, i1 + len1 + len4) = constructKernel(X, [], kernel_option);  
    end
end

D = EuDist2(X, X, 1);  %
s = mean(D(:));    %？

if exist('GaussianDegrees', 'var')
    for i1 = 1:len3
        kernel_option = [];
        kernel_option.KernelType = 'Gaussian';
        kernel_option.t = sqrt(GaussianDegrees(i1)) * s;
        Ks(:, :, i1 + len1 + len2 + len4) = constructKernel(X, [], kernel_option);
    end
end