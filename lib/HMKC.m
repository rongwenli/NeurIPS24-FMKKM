function [ H_normalized, H, HPs, beta, gamma, lambda, obj ] = HMKC( K, lambda, class_num, midclass_set)

base_kernel_num = size(K, 3);  % 每一层的12个核
sample_num = size(K, 1); 
layer_num = length(midclass_set);  %是mid_layer_nCluster，[1,1]c；[2,2]c；[4,4]c，长度永远都是2



%**************************************************************************
% initialization the embeddings in the hidden layers via kernel kmeans with
% different c;
%**************************************************************************
HPs = cell(layer_num, 1);
for t=1:layer_num    % 遍历每个子空间上的层数（1到q），这里面只有两个中间层，K->U11->U12->U1*
    tmp = zeros(sample_num, midclass_set(t), base_kernel_num);
    for p=1:base_kernel_num
        tmp(:,:,p) = my_kernel_kmeans(K(:,:,p),midclass_set(t));  % [n, 1c] 或者[n, 2c]的特征向量（单独子空间里面72个样本最后的聚类结果）                                                  %
    end
    HPs{t} = tmp;  % 每个子空间72个样本聚类以后的结果
end
%**************************************************************************
% initialization the coefficients gamma, beta, delta,
%**************************************************************************
gamma = cell(layer_num, 1);
for t=1:layer_num    % 遍历每个子空间上的层数（1到q），这里面只有两个中间层，K->U11->U12->U1*
    gamma{t}= ones(base_kernel_num,1)/base_kernel_num;  % 
end
beta = ones(base_kernel_num,1)/base_kernel_num;


iter = 0;
converges = 0;
while ~converges
    % update H
    H = update_H(beta, HPs{layer_num}, class_num);
    %     iter = iter+1;
    %     obj(t) = cal_obj(H, HP, K, midclass_set, beta, gamma, lambda);
    % update W
    %     HP = update_HP_nor(H, HP, K, beta, gamma, lambda, midclass_set);
    %     HP = update_HP_rev(H, HP, K, beta, gamma, lambda, midclass_set);
    if rem(iter, 2) == 0
        HPs = update_HP_nor(H, HPs, K, beta, gamma, lambda, midclass_set); %前向
    else
        HPs = update_HP_rev(H, HPs, K, beta, gamma, lambda, midclass_set);  %反向
    end
    %     t = t+1;
    %     obj(t) = cal_obj(H, HP, K, midclass_set, beta, gamma, lambda);
    %% update beta
    beta = update_beta(H, HPs{layer_num});
    %     t = t+1;
    %     obj(t) = cal_obj(H, HP, K, midclass_set, beta, gamma, lambda);
    %% update gamma
    gamma = update_gamma(HPs, K, midclass_set);
    
    iter = iter+1;
    obj(iter) = cal_obj(H, HPs, K, midclass_set, beta, gamma, lambda);
    if iter >= 2 && (abs((obj(iter-1)-obj(iter))/(obj(iter))<1e-5 || iter>100))
        converges = 1;
    end
end
H_normalized = H./ repmat(sqrt(sum(H.^2, 2)), 1,class_num);

end

