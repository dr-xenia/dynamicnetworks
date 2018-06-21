% Create a plot for the presentation

pn.root = '/Users/kosciessa/OHBM18/A_BrainHack/HMM_complete/'; 
pn.dataDir = [pn.root, 'B_data/'];

load([pn.dataDir, 'A_HMMoutput_allSubs.mat'], 'options', 'hmm', 'Gamma', 'maxFO', 'FO', 'LifeTimes', 'Intervals', 'SwitchingRate')

%% plot results

h = figure; 
subplot(2,2,[1,2]); imagesc(FO)
hold on;
for indSub = 0:4:40
    line([0 12.5], [indSub+.5 indSub+.5],  'Color','k', 'LineWidth', 2)
end
xlabel('State'); ylabel('Scan'); title('State Occupancy'); colorbar;
subplot(2,2,3); plot(SwitchingRate)
xlabel('Scan'); ylabel('Switching Rate'); title('Switching Rate');
subplot(2,2,4); plot(maxFO)
xlabel('Scan'); ylabel('maximum Fractional Occupancy'); title('maximum Fractional Occupancy');

pn.plotFolder = [pn.root,'C_figures/'];
figureName = 'A_HMMoutput';

saveas(h, [pn.plotFolder, figureName], 'fig');
saveas(h, [pn.plotFolder, figureName], 'epsc');
saveas(h, [pn.plotFolder, figureName], 'png');

%% sort FOs by maximum FO and average across runs

averageVec = 0:4:40;

for indAvgBin = 2:numel(averageVec)
    FOIndividual(indAvgBin-1,:) = nanmean(FO(averageVec(indAvgBin-1)+1:averageVec(indAvgBin),:),1);
end

[maxVal, maxIdx] = max(FOIndividual,[],1);
[sortVal, sortIdx]  = sort(maxIdx, 'descend');

%% plot state maps

pn.dataOut = [pn.root, '/B_data/B_stateNiftys/'];

for k = 1:12
    BrainParcel{k} = niftiread([pn.dataOut, 'HMM_State_', num2str(k)]);
end

figure;
for indPlot = 1:12
    subplot(3,6,indPlot)
    dataToPlot = rot90(squeeze(BrainParcel{indPlot}(:,50,:)));
    dataToPlot(dataToPlot==0) = NaN;
    imagesc(dataToPlot)
    title(['State ', num2str(indPlot)]);
end
subplot(3,6,[13:18]);
% hold on;
% imagesc(FO)
% for indSub = 0:4:40
%     line([0 12.5], [indSub+.5 indSub+.5],  'Color','k', 'LineWidth', 2)
% end
% xlabel('Subject'); ylabel('Scan'); title('State Occupancy'); colorbar;
% xlim([0.5 12.5]); ylim([0 40]); 

imagesc(FOIndividual(:,sortIdx))
xlabel('Subject'); ylabel('State'); title('Individul State Occupancy'); colorbar;
xlim([0.5 12.5]); ylim([0.5 10.5]); 
set(gca,'Ydir','Normal');

%% plot brain states

h = figure;
for indPlot = 1:12
    subplot(2,6,indPlot)
    dataToPlot = rot90(squeeze(BrainParcel{indPlot}(:,50,:)));
    dataToPlot(dataToPlot==0) = NaN;
    imagesc(dataToPlot)
    title(['State ', num2str(indPlot)]);
    set(gca, 'box', 'off');
    set(gca, 'xtick', []);
    set(gca, 'ytick', []);
end
colormap(gray)
set(findall(gcf,'-property','FontSize'),'FontSize',18)

pn.plotFolder = [pn.root, 'C_figures/'];
figureName = 'B_states';

saveas(h, [pn.plotFolder, figureName], 'fig');
saveas(h, [pn.plotFolder, figureName], 'epsc');
saveas(h, [pn.plotFolder, figureName], 'png');