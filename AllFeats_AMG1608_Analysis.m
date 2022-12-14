load('AMG1608GMMTopicPosteriors_256KM');
load('FV_AMG1608_256');
load('AMG1608_CPH_MPH');

% AllFeats_AMG1608 = [AMG1608POST FV_AMG1608_256 AMG1608_CPH];
AllFeats_AMG1608 = AMG1608POST;
% imagesc(AllFeats_AMG1608)

% Requires DR toolbox
% no_dims = round(intrinsic_dim(AllFeats_AMG1608, 'MLE'));
% AllFeats_AMG1608_KPCA = compute_mapping(AllFeats_AMG1608, 'KernelPCA', no_dims);
% AllFeats_AMG1608_KPCA = compute_mapping(AllFeats_AMG1608, 'KernelPCA',0.95);
AllFeats_AMG1608_KPCA = kernel_pca(AllFeats_AMG1608,0.95);

% AllFeats_AMG1608_KPCA = AllFeats_AMG1608;

load('AMG1608AnnotatorsConsensusCIWM.mat');
YValence = AMG1608AnnotatorsConsensusCIWM.YValence;
YArousal = AMG1608AnnotatorsConsensusCIWM.YArousal;

idx_Q1 = find(YValence>=0 & YArousal>=0);
AllFeats_Q1 = AllFeats_AMG1608_KPCA(idx_Q1,:);
mean_Q1 = mean(AllFeats_Q1,1);

idx_Q2 = find(YValence<0 & YArousal>=0);
AllFeats_Q2 = AllFeats_AMG1608_KPCA(idx_Q2,:);
mean_Q2 = mean(AllFeats_Q2,1);

idx_Q3 = find(YValence<0 & YArousal<0);
AllFeats_Q3 = AllFeats_AMG1608_KPCA(idx_Q3,:);
mean_Q3 = mean(AllFeats_Q3,1);

idx_Q4 = find(YValence>=0 & YArousal<0);
AllFeats_Q4 = AllFeats_AMG1608_KPCA(idx_Q4,:);
mean_Q4 = mean(AllFeats_Q4,1);

subplot(2,2,2);plot(mean_Q1);
subplot(2,2,1);plot(mean_Q2);
subplot(2,2,3);plot(mean_Q3);
subplot(2,2,4);plot(mean_Q4);

% subplot(2,2,2);boxplot(AllFeats_Q1);
% subplot(2,2,1);boxplot(AllFeats_Q2);
% subplot(2,2,3);boxplot(AllFeats_Q3);
% subplot(2,2,4);boxplot(AllFeats_Q4);
