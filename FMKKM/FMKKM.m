function [y, theta, objective] = FMKKM(Km, Y0)

numker = size(Km, 3);
theta = ones(numker,1)/numker;
maxIter = 10;
Y = Y0;
objHistory1 = [];
for iter1 = 1:maxIter
    K_theta = mycombFun(Km, theta.^2);
    for iter2 = 1
        [Y, obj2]=solve_Y(K_theta,Y);  
    end
    [theta,obj1] = updateabsentkernelweightsV3(Y,Km);
    objHistory1 = [objHistory1; obj1];
    if iter1 > 2 && abs(objHistory1(iter1 - 1) - objHistory1(iter1)) / abs(objHistory1(iter1 - 1)) < 1e-10
        break;
    end
end
y = vec2ind(Y')';
objective = objHistory1;
end

