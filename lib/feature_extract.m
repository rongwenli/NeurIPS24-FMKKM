function Xs = feature_extract(X, nSubspaces, feature_sampling_ratio)

[~, nFea] = size(X);

if ~exist('nSubspaces', 'var')
    nSubspaces = 5;
end
if ~exist('feature_sampling_ratio', 'var')
    feature_sampling_ratio = 0.5 + zeros(1, nSubspaces);
end
stream = RandStream.getGlobalStream;
reset(stream);
Xs = cell(nSubspaces, 1);
for i1 = 1 : nSubspaces
    tmp_idx = randperm(nFea, ceil(nFea * feature_sampling_ratio(1, i1)));
    Xs{i1} = X(:, tmp_idx);
end