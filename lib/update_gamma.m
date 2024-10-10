function gamma = update_gamma( HPs, K, mid_layer_width)

base_kernel_num = size(K, 3);
layer_num = length(mid_layer_width);

gamma = cell(layer_num, 1);

for t=1:layer_num
    V = zeros(base_kernel_num,1);
    if t == 1
        tmpHPt = HPs{t};
        for p=1:base_kernel_num
            V(p) = trace(tmpHPt(:,:,p)*tmpHPt(:,:,p)'*K(:,:,p));
        end
    else
        tmpHPt = HPs{t};
        tmpHPt0 = HPs{t-1};
        for p=1:base_kernel_num
            V(p) = trace(tmpHPt0(:,:,p)*tmpHPt0(:,:,p)'*tmpHPt(:,:,p)*tmpHPt(:,:,p)');
        end
    end

    gamma{t} = V./norm(V,2);
end 

end

