function Hs = generate_sk_base_kkm(Ks, nCluster)
[nSmp, ~, nKernel] = size(Ks);
Hs = zeros(nSmp, nCluster, nKernel);
opt.disp = 0;
for i1 = 1:nKernel % m - kernels
    Ks(:, :, i1) = (Ks(:, :, i1) + Ks(:, :, i1)')/2;
    [Hi, ~] = eigs(Ks(:, :, i1), nCluster, 'la', opt);    
    Hs(:, :, i1) = Hi;
end