%--------------------------------------------------------------------------
% Copyright @ Ehsan Elhamifar, 2012
%--------------------------------------------------------------------------

function Cp = thrC(C,ro)

if (nargin < 2)
    ro = 1;
end

if (ro < 1)                    %ro是上层程序的alpha
    N = size(C,2);             %返回矩阵C的列数
    Cp = zeros(N,N);
    [S,Ind] = sort(abs(C),1,'descend');%按照降序排列矩阵'abs(C)'的每一列，S是排序结果，Ind是相应元素在原矩阵中的位置
    for i = 1:N
        cL1 = sum(S(:,i));      %矩阵S第i列的和
        stop = false;
        cSum = 0; t = 0;
        while (~stop)
            t = t + 1;
            cSum = cSum + S(t,i);
            if ( cSum >= ro*cL1 )
                stop = true;
                Cp(Ind(1:t,i),i) = C(Ind(1:t,i),i);
            end
        end
    end
else
    Cp = C;
end