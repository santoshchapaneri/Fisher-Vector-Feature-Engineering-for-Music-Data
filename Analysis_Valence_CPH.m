load('AMG1608AnnotatorsConsensusCIWM.mat');
load('AMG1608_CPH.mat');

negVal = find(AMG1608AnnotatorsConsensusCIWM.YValence<0);
posVal = find(AMG1608AnnotatorsConsensusCIWM.YValence>=0);

if 1
negperm = randperm(length(negVal));
posperm = randperm(length(posVal));
% s = [negVal(negperm(1)),posVal(posperm(1))]; % Songs to compare
s = [posVal(posperm(1)),posVal(posperm(2))]; % Songs to compare
% s = [negVal(negperm(1)),negVal(negperm(2))]; % Songs to compare
subplot(211);plot(AMG1608_CPH(s(1),:),'r','LineWidth',3);
ylim([0 1]);
strTitle1 = sprintf('Valence: %f',AMG1608AnnotatorsConsensusCIWM.YValence(s(1)));
title(strTitle1);
subplot(212);plot(AMG1608_CPH(s(2),:),'b','LineWidth',3);
ylim([0 1]);
strTitle2 = sprintf('Valence: %f',AMG1608AnnotatorsConsensusCIWM.YValence(s(2)));
title(strTitle2);
end

% Dominant bins of +ve Valence
allPosVal_CPH = AMG1608_CPH(posVal,:);
allNegVal_CPH = AMG1608_CPH(negVal,:);
% 
% startIdx = 10; total = 20;
% imagesc(allPosVal_CPH(startIdx:startIdx+total-1,:));
% figure;
% imagesc(allNegVal_CPH(startIdx:startIdx+total-1,:));

if 1
% 25 possible chords
Chords = {'C','C#','D','D#','E','F', 'F#','G','G#','A','A#','B', ...
          'c','c#','d','d#','e','f', 'f#','g','g#','a','a#','b','N'};
CP = cell(25,25);
for i=1:25
    for j=1:25
        tmp = [Chords(i),Chords(j)];
        CP{i,j} = strjoin(tmp,'->');
    end
end
tr = tril(ones(25,25),-1);
idxToKeep = find(tr==1);
CP = reshape(CP,1,625);
ChordProg = CP(idxToKeep'); % 1 x 300 chord progressions

[MajorMajorIdx,MajorMinorIdx,MinorMinorIdx] = getMajorMinorIndices();
% These are in range 1 to 625.
% allPosVal_CPH is N x 300
% Mapping needed for indices

for i = 1:size(allPosVal_CPH,1)
    tmp=allPosVal_CPH(i,:);
    [val,idx] = sort(tmp,'descend');
    idxPosDominant(i) = idx(1);
    valPosDominant(i) = val(1);
    CP_PosDominant{i,1} = ChordProg{idx(1)};
    
%     valMajMaj(i,:) = allPosVal_CPH(1,MajorMajorIdx);
%     valMajMin(i,:) = allPosVal_CPH(1,MajorMinorIdx);
%     valMinMin(i,:) = allPosVal_CPH(1,MinorMinorIdx);
    
end
uniqueCP_PosValence = unique(idxPosDominant);
[countPosDominant, binsPosDominant] = hist(idxPosDominant,uniqueCP_PosValence);
hist(idxPosDominant,uniqueCP_PosValence)

for i = 1:size(allNegVal_CPH,1)
    tmp=allNegVal_CPH(i,:);
    [val,idx] = sort(tmp,'descend');
    idxNegDominant(i) = idx(1);
    valNegDominant(i) = val(1);
    CP_NegDominant{i,1} = ChordProg{idx(1)};
end
figure;
uniqueCP_NegValence = unique(idxNegDominant);
[countNegDominant, binsNegDominant] = hist(idxNegDominant,uniqueCP_NegValence);
hist(idxNegDominant,uniqueCP_NegValence)

x=2;

end