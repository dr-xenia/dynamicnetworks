% get state transition probabilities

addpath(genpath('/Users/kosciessa/OHBM18/A_BrainHack/HMM_complete/T_tools/HMM-MAR-master/'))

pn.dataDir = '/Users/kosciessa/OHBM18/A_BrainHack/HMM_complete/B_data/';
load([pn.dataDir, 'A_HMMoutput_allSubs.mat'], 'options', 'hmm', 'Gamma', 'maxFO', 'FO', 'LifeTimes', 'Intervals', 'SwitchingRate')

transitionProbabilities = getTransProbs(hmm); 
figure; imagesc(transitionProbabilities)

for indState1 = 1:12
    for indState2 = 1:12
        tempcorr = corrcoef(FO(indState1,:),FO(indState2,:));
        RMat(indState1, indState2) = tempcorr(2);
    end
end

figure; imagesc(RMat)
xlabel('State 1'); ylabel('State 2');

save([pn.dataDir, 'C_matricesForKmeans.mat'], 'transitionProbabilities', 'RMat')