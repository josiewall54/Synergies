%% Figure 2b - Single Animal VAF/synNum Scatter - Factor Analysis

% synNum vs. VAF scatter plot on top half


%% Plot scatter for J8 synNums; just whole -> whole and residual -> whole,

wholeToWhole = [0.38 0.59 0.79 0.85	0.89 0.92];
resToWhole = [0.30 0.54 0.75 0.83 0.86 0.89];
%stepScrambleWhole = [0.31 0.47 0.53 0.60 0.66 0.71]; %using this as a control
stepScramble = [0.08 0.15 0.26 0.41 0.49 0.51]; %residual to whole

synNums = 1:6;

figure
hold on
scatter(synNums, wholeToWhole, 120, 'k', 'filled')
scatter(synNums, resToWhole, 120, [.31 .45 .51], 'filled')
scatter(synNums, stepScramble, 120, [.6 .6 .6], 'filled')
ylim([0 1])
yticks(0:0.2:1)
xticks(1:6)

xlabel('Number of Synergies')
ylabel('VAF')
title('J8 - FA')

legend 'Whole from whole' 'Whole from residual' 'Step scramble control (residual -> whole)'
legend boxoff

set(gca, 'TickDir', 'out')
set(gca, 'Color', 'none')
set(gca, 'FontSize', 15)
axis square
box off


%% example prediction traces on bottom half - start with first half of muscles, can
% pare down later

% --------------- Plot whole-from-whole against actual whole data ------------------------------
load('/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/paperFigures/figureData/J8_fa.mat')
muscleCount = size(testData.whole, 1);
figure
for iMuscle = 1:floor(muscleCount / 2)
    subplot(floor(muscleCount / 2), 1, iMuscle)
    hold on
    
    plot(testData.whole(iMuscle, :), 'Color', [105/255 105/255 105/255])
    plot(builtData.reg{4}(iMuscle, :), 'k')
    
    ylabel(labels{iMuscle})
    
    axis tight; xlim([1000 2000])
    set(gca,'TickDir','out'); box off
    set(gca, 'YTick', [])
end

subplot(floor(muscleCount / 2), 1, floor(muscleCount / 2))
legend 'Actual Whole Data' 'Whole Reconstructed from Whole Synergies'
legend boxoff

% --------------- Plot whole-from-residual against actual whole data ------------------------------
figure
for iMuscle = 1:floor(muscleCount / 2)
    subplot(floor(muscleCount / 2), 1, iMuscle)
    hold on
    
    plot(testData.whole(iMuscle, :), 'Color', [105/255 105/255 105/255])
    plot(builtData.resReg{4}(iMuscle, :), 'Color', [.31 .45 .51])
    
    ylabel(labels{iMuscle})
    
    axis tight; xlim([1000 2000])
    set(gca,'TickDir','out'); box off
    set(gca, 'YTick', [])
    
end

subplot(floor(muscleCount / 2), 1, floor(muscleCount / 2))
legend 'Actual Whole Data' 'Whole Reconstructed from Residual Synergies'
legend boxoff
