function [res]= my_fair_eval_y(pre_y,y,g)
[acc,nmi,~,~]=ClusteringMeasure(y,pre_y);


G = full(ind2vec(g'))';
Y = full(ind2vec(pre_y'))';
C = G'*Y;
fair = compute_fair(C);
mnce = MNCE(C);
res = [acc,nmi,fair,mnce];
res = res';
end

