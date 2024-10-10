function cF = combFun(Merge1_H, gamma)

nKernel = size(Merge1_H, 3);
nSmp = size(Merge1_H, 1);
cF = zeros(nSmp);
for p =1 : nKernel
    cF = cF + Merge1_H(:, :, p) * Merge1_H(:, :, p)' * gamma(p);
end