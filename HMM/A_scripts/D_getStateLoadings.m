%Get mean values for each HMM state and save in Nifty format
% Note that each state is defined across subjects

% 180614 Julian Kosciessa

%% get mean values for each state

addpath(genpath('/Users/kosciessa/BrainHack/HMM_complete/T_tools/HMM-MAR-master/'))

load('/Users/kosciessa/BrainHack/HMM_complete/B_data/A_HMMoutput.mat')

for k = 1:12
    meanState(k,:) = getMean(hmm,k);
end

figure; imagesc(meanState)

%% load parcellated image, replace with mean values for each state

pn.dataOut = '/Users/kosciessa/BrainHack/HMM_complete/B_data/B_stateNiftys/'; mkdir(pn.dataOut);

BrainPacel = niftiread("/Users/kosciessa/Downloads/dynamicnetworks-master/basc_2mm_scale064.nii.gz");

for k = 1:12
    StateValues = zeros(size(BrainPacel));
    for indRegion = 1:size(meanState,2)
        StateValues(BrainPacel==indRegion) = meanState(k,indRegion);
    end
    % save as nifty output
    niftiwrite(StateValues, [pn.dataOut, 'HMM_State_', num2str(k)]);
end