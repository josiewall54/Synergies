%% FIGURE 5a ------ ICAPCA Mean Predictions
resWhole1 = [0.28 0.25 0.17 0.12 0.23 0.29 0.26	0.25 0.17];
resMean1 = [0.22 0.23 -0.09	0.00 0.26 -0.04	0.31 0.04 -0.50];

resWhole2 = [0.51 0.42 0.31 0.25 0.51 0.42 0.47	0.37 0.36];
resMean2 = [0.49 0.49 0 0.3 0.51 0.02 0.36 0.39 -0.4];

resWhole3 = [0.65 0.72 0.65 0.39 0.58 0.52 0.67	0.46 0.5];
resMean3 = [0.68 0.82 0.46 0.43	0.55 0.39 0.67 0.49	0.41];

resWhole4 = [0.75 0.78 0.72	0.48 0.7 0.71 0.76 0.65	0.7];
resMean4 = [0.74 0.85 0.62 0.49	0.69 0.61 0.77 0.69 0.61];

resWhole5 = [0.81 0.8 0.74 0.59	0.72 0.72 0.77 0.83	0.8];
resMean5 = [0.83 0.87 0.55 0.62	0.71 0.62 0.72 0.89	0.79];

resWhole6 = [0.83 0.81 0.76	0.6	0.72 0.73 0.81 0.83	0.8];
resMean6 = [0.88 0.88 0.5 0.61 0.7 0.62	0.8	0.89 0.79];


meanVafs = vertcat(resMean1, resMean2, resMean3, resMean4, resMean5, resMean6).';
wholeVafs = vertcat(resWhole1, resWhole2, resWhole3, resWhole4, resWhole5, resWhole6).';

figure
hold on
scatter(1:6, mean(wholeVafs, 1), 150, 'k', 'filled')
scatter(1:6, mean(meanVafs, 1), 150, [139/255 0 0], 'filled')

legend 'Whole from residual' 'Mean from residual'
legend boxoff

errorbar(1:6, nanmean(wholeVafs, 1), nanstd(wholeVafs, 1), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k')
errorbar(1:6, nanmean(meanVafs, 1), nanstd(meanVafs, 1), 'LineStyle', 'none', 'LineWidth', 2, 'Color', [139/255 0 0])

ylim([0 1])
yticks(.2:.2:1)
xticks(1:6)

xlabel('Number of Synergies')
ylabel('VAF')

title('Mean Predictions - ICAPCA')
set(gca,'TickDir','out')
set(gca, 'FontSize', 15)
axis square
box off
