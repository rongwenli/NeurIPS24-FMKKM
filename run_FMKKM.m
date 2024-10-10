clear;
clc;
lib_path = fullfile(pwd, '.',  filesep, "lib", filesep);
addpath(lib_path);
code_path = fullfile(pwd, '.',  filesep, "FMKKM", filesep);
addpath(code_path);


data_name = 'jaffe_expression_213n_676d_10c_7g_uni_12k_';


clear Ks y g;


load(data_name);
nCluster = length(unique(y));
[nSmp, ~, nKernel] = size(Ks);


% **************************************************************************
% Parameter Configuration
% **************************************************************************
nMeasure = 4;
lambda_pre = 0;
mnce_pre = 0;
increase_rate = 1;

%**************************************************************************
% Initialization Y0
%**************************************************************************
opt.disp = 0;
Kw = sum(Ks, 3);
[H, ~] = eigs(Kw, nCluster,'LA',opt);
H_normalized = H ./ repmat(sqrt(sum(H.^2, 2)), 1,nCluster);
label0 = kmeans(H_normalized, nCluster, 'MaxIter', 50, 'Replicates', 10);
Y0 = full(ind2vec(label0'))';



%**************************************************************************
% FMKKM
%**************************************************************************

G = full(ind2vec(g'))';
F = G*G';
sigmm_max = max(sum(G,1));


while increase_rate > 0.005
    lambda_cur = lambda_pre + 1;
    beta = sigmm_max .* lambda_cur;
    Ks_fair = zeros(nSmp,nSmp,nKernel);
    for iKernel = 1:nKernel
        Ks_fair(:,:,iKernel) = Ks(:,:,iKernel) + beta.*eye(nSmp) -lambda_cur.*F;
    end
    [pre_y, ~, ~] = FMKKM(Ks_fair, Y0);
    result = my_fair_eval_y(pre_y,y,g);
    mnce_cur = result(4);
    increase_rate = mnce_cur - mnce_pre;
    mnce_pre = mnce_cur;
    lambda_pre = lambda_cur;
end

result






