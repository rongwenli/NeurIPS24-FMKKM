clear;
clc;
datasets ={'australian_690n_14d_2c_uni','balance_625n_4d_3c_uni','breast_699n_10d_2c_uni',...
    'control_600n_60d_6c_uni', 'Cora_DS_751n_6234d_9c_uni', 'Cora_HA_400n_3989d_7c_uni',...
    'Cora_OS_1246n_6737d_4c_uni','crx_690n_15d_2c_uni', 'diabetes_768n_8d_2c_uni',...
    'pima_768n_8d_2c_uni','TDT2_10_653n_36771d_30c_uni','tr41_878n_7454d_10c_tfidf_uni',...
    'tr45_690n_8261d_10c_tfidf_uni','WebKB_cornell_827n_4134d_7c_uni', 'WebKB_texas_814n_4029d_7c_uni'};

kernel_type_option = [];
kernel_type_option.PolynomialDegrees = [2, 4];
kernel_type_option.PolyPlusDegrees = [2, 4];
kernel_type_option.GaussianDegrees = 2.^(-3:3);
kernel_type_option.Linear = 'Linear';

for i1 =1:length(datasets)
    dn = datasets{i1};
    buildKernels_v2(dn, kernel_type_option);
end