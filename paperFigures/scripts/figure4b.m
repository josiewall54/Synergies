%% FIGURE 4b ------ Single Rat (J8)  Mean Predictions - FA

resToWhole = [0.30 0.54	0.75 0.83 0.86 0.89];
resToMean = [0.30 0.54 0.82	0.87 0.89 0.91];
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
title('J8 - Mean Prediction - FA')

set(gca, 'TickDir', 'out')
set(gca, 'Color', 'none')
set(gca, 'FontSize', 15)
box off
axis square
