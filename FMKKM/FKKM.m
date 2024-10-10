function [y, objHistory] = FKKM(K,Y)


objHistory = [];


for iter = 1:10
    [Y, obj]=solve_Y(K,Y);
    objHistory = [objHistory; obj];
    if iter > 2 && abs(objHistory(iter - 1) - objHistory(iter)) / abs(objHistory(iter - 1)) < 1e-10
        break;
    end
end
y = vec2ind(Y')';


end

