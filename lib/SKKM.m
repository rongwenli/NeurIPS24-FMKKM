function [H_normalized, obj] = SKKM(K,nCluster)
K = (K+K')/2;
opt.disp = 0;
[H,~] = eigs(K,nCluster,'LA',opt);
obj = trace(H' * K * H) - trace(K);
H_normalized = H ./ repmat(sqrt(sum(H.^2, 2)), 1,nCluster);
%label = kmeans(H_normalized, nCluster, 'emptyaction', 'singleton', 'replicates', 100, 'display', 'off');
end