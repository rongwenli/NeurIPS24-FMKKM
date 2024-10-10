function avgH = generate_avgK_base_kkm(Ks, nCluster)
[nSmp, ~, nKernel] = size(Ks);
avgK = zeros(nSmp, nSmp);
for i1 = 1:nKernel % m - kernels
    Ks(:, :, i1) = (Ks(:, :, i1) + Ks(:, :, i1)')/2;
    avgK = avgK + (1/nKernel)*Ks(:, :, i1);
end
opt.disp = 0;
[avgH, ~] = eigs(avgK, nCluster, 'la', opt);