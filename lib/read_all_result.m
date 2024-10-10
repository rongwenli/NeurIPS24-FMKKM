clear
clc
File = fullfile(pwd, '\all_algorithm\');
dirop = dir(fullfile(File));
File_name = {dirop.name};
for i = 3 : length(File_name)
    i_file = File_name{i};
    dirOutput = dir(fullfile(File, filesep, i_file, '*.mat'));
    file_name = {dirOutput.name};
    ACC = zeros(length(file_name), 3);
    NMI = zeros(length(file_name), 3);
    PUR = zeros(length(file_name), 3);
    ARI = zeros(length(file_name), 3);
    for i1 = 1 : length(file_name)
        ifile_name = file_name{i1};
        load(ifile_name, 'acc', 'nmi', 'pur', 'ari');
        nonzero_idx = (acc ~= 0);
        ACC(i1, :) = acc(nonzero_idx);
        NMI(i1, :) = nmi(nonzero_idx);
        PUR(i1, :) = pur(nonzero_idx);
        ARI(i1, :) = ari(nonzero_idx);
    end
    save(['./result_all_', i_file, '.mat'], 'ACC', 'NMI', 'PUR', 'ARI');
end