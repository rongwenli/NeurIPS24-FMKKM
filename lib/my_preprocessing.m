function X_output = my_preprocessing(X_input)

% assert(size(X_input, 1) < size(X_input, 2));
%****************************************************
% gene filter step :
% remove the genes whose expressions(the 
% expression of the gene is non-zero) are < 5%
% of all cells.
%****************************************************

[nCell, ~]=size(X_input);
non_zero_flag = ( X_input ~= 0);
non_zero_flag_count = sum(non_zero_flag, 1);
gene_filter_index = non_zero_flag_count > ( nCell * 0.05);
temp_X = X_input(:, gene_filter_index);

%****************************************************
% L2-norm : 
%****************************************************
x_norm = max(sqrt(sum(temp_X.^2, 2)), eps);
X_output = bsxfun(@rdivide, temp_X, x_norm);
