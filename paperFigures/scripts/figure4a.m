%% FIGURE 4a ------ Single Rat (J8)  Mean Predictions - ICAPCA

resToWhole = [0.28 0.51 0.65 0.75 0.81 0.83];
resToMean = [0.22 0.49 0.68 0.74 0.83 0.88];
synNums = 1:6;

figure
hold on
scatter(synNums, resToWhole, 120, 'k', 'filled')
scatter(synNums, resToMean, 120, [139/255 0 0], 'filled')

ylim([0 1])
yticks(0:0.2:1)
xticks(1:6)

legend({'Whole from residual' 'Mean from residual'}, 'FontSize', 20)
legend boxoff

ylabel('VAF')
xlabel('Number of Synergies')
title('J8 - Mean Prediction - ICAPCA')

set(gca, 'TickDir', 'out')
set(gca, 'Color', 'none')
set(gca, 'FontSize', 15)
box off
axis square
