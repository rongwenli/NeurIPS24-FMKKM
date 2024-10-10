function label_kkm = kkm_n(K, nCluster, nRepeat)
K = (K + K')/2;
opt.disp = 0;
[H, ~] = eigs(K, nCluster,'LA', opt);
H_normalized = H ./ repmat(sqrt(sum(H.^2, 2)), 1, nCluster);
stream = RandStream.getGlobalStream;
reset(stream);
label_kkm = lite_kmeans(H_normalized, nCluster, 'MaxIter', 1000, 'Replicates', nRepeat);
label_kkm = label_kkm(:);