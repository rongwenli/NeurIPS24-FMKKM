function [Y, objHistory] = optimize_Y(A, B, Y0)
%**************************************************************************
% min tr(Y' A Y) + tr(Y' B)
% s.t. Y'Y = I, Y >=0
%**************************************************************************

[nSmp, nCluster] = size(B);
A = (A + A')/2;

if ~exist('Y0', 'var')
    opt.disp = 0;
    [Y0, ~] = eigs(A, nCluster, 'sa', opt);
    % Y = bsxfun(@rdivide, Y0, max(sqrt(sum(Y0.^2, 2)), eps));
    Y = Y0;
else
    Y = Y0;
end

% This par of code initialize the gamma and sigma
converges = false;
max_mu = 1e8;
myeps = 1e-4;
maxIter = 500;
iter = 0;
rho = 1.1;
mu = 1;
sigma = zeros(nSmp, nCluster);
objHistory = [];
while ~converges
    %**************************************************************************
    %  算法一
    % Step 1: update H   U_i
    %**************************************************************************
    temp = Y + 1/mu * sigma - 1/mu * ( A' * Y);   % 公式13  代码核论文略有不同，用的是2.1.2
%     H = max(temp, 0);    
    H = temp;
    %**************************************************************************
    % Step 2: update Y     U_i^
    %**************************************************************************
    temp2 = H - 1/mu * sigma - 1/mu * (A * H + B);     % 公式15
    [U, ~, V] = svd(temp2, 0);
    Y = U * V';
    
    %**************************************************************************
    % Step 3: update sigma and mu   
    %**************************************************************************
    sigma = sigma + mu * (Y - H);
    mu = max(rho * mu, max_mu);
    
    iter = iter + 1;
    
    o1 = trace(Y' * (A * H));    
    o2 = trace(Y' * B);   % 公式 10
    E = Y - H + 1/mu * sigma;    
    o3 = sum(sum(E.^2)) * .5 * mu;
    obj = o1 + o2 + o3;    % 公式11
    objHistory = [objHistory; obj]; %？
    
    if (iter > 2 && (abs(objHistory(end - 1) - objHistory(end) ) / abs(objHistory(end) ) < myeps ))...
            || iter > maxIter
        converges = true;
    end
end