%% Figure 2a - Single Animal VAF/synNum Scatter - ICAPCA

% synNum vs. VAF scatter plot on top half


%% Plot scatter for J8 synNums; just whole -> whole and residual -> whole,
% with grey background and new blue dot color

wholeToWhole = [0.36 0.55 0.67 0.77 0.84 0.85];
resToWhole = [0.28 0.51 0.65 0.75 0.81 0.83];
%stepScrambleWhole = [0.27 0.37 0.44 0.51 0.57 0.62]; %using this as a control
stepScramble = [0.08 0.16 0.25 0.32	0.37 0.47]; %residual to whole

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
title('J8 - ICAPCA')

legend 'Whole from whole' 'Whole from residual' 'Step scramble control (residual -> whole)'
legend boxoff

set(gca, 'TickDir', 'out')
set(gca, 'Color', 'none')
set(gca, 'FontSize', 15)
axis square
box off


%% example prediction traces on bottom half - start with all muscles, can
% pare down later

% --------------- Plot whole-from-whole against actual whole data ------------------------------
load('/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/paperFigures/figureData/J8_icapca.mat')
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
