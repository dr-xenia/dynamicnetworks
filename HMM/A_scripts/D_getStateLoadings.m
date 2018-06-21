%Get mean values for each HMM state and save in Nifty format
% Note that each state is defined across subjects

% 180614 Julian Kosciessa

%% get mean values for each state

pn.root = '/Users/kosciessa/OHBM18/A_BrainHack/HMM_complete/';

addpath(genpath([pn.root, 'T_tools/HMM-MAR-master/']))

load([pn.root, 'B_data/A_HMMoutput_allSubs.mat'])

for k = 1:12
    meanState(k,:) = getMean(hmm,k);
end

figure; imagesc(meanState)

%% load parcellated image, replace with mean values for each state

pn.dataOut = [pn.root, 'B_data/B_stateNiftys/']; mkdir(pn.dataOut);

BrainPacel = niftiread('/Users/kosciessa/OHBM18/A_BrainHack/dynamicnetworks-master/basc_2mm_scale064.nii.gz');

for k = 1:12
    StateValues = zeros(size(BrainPacel));
    for indRegion = 1:size(meanState,2)
        StateValues(BrainPacel==indRegion) = meanState(k,indRegion);
    end
    % save as nifty output
    niftiwrite(StateValues, [pn.dataOut, 'HMM_State_', num2str(k)]);
end