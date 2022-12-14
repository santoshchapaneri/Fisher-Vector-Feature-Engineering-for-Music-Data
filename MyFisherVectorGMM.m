function Theta = MyFisherVectorGMM(features, means, covariances, priors)

J = length(features);
K = size(priors,1);
D = size(features{1},2);
Theta = zeros(J, 2*K); % J*(2*D*K) matrix whose row represents the distribution over K for song j
for j = 1:J
    j
    % process for each features{j} aka jth song
    tmp = vl_fisher(features{j}', means, covariances, priors,'Improved'); % 1 x 2*D*K
    % Compute the gradient magnitude as a compact representation
    gradmag = zeros(1,2*K);
    k = 1; idx = 1;
    for i=1:2*K
        t1 = tmp(idx:idx+D-1);
        gradmag(k) = norm(t1);
        k = k + 1;
        idx = idx + D;
    end
    Theta(j,:) = gradmag;
end
    