clear;clc;
%% Get Fisher Vector representation of all 1608 songs
load('AMG1608_SegmentsCell.mat'); % loads normalized segments_cell

load('AMGCampus_42K_GMMModel_256KM.mat');

AMG1608POST = MyAcousticGMMPosterior(segments_cell, ModelAMGCampusGMM); 

% Convert to diagonal covs for Fisher Kernels
K = size(ModelAMGCampusGMM.w,2);
for i = 1:K
    S = ModelAMGCampusGMM.Sigma(:,:,i);
    Sigma(:,i) = diag(S);
end
FV_AMG1608_256 = MyFisherVectorGMM(segments_cell, ModelAMGCampusGMM.mu, Sigma, (ModelAMGCampusGMM.w)');
save('FV_AMG1608_256.mat','FV_AMG1608_256');
VisualizePost(FV_AMG1608_256);