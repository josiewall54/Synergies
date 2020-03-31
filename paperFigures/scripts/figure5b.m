%% FIGURE 5b ------ FA Mean Predictions
resWhole1 = [0.30 0.24 0.19	0.22 0.26 0.33 0.29	0.25 0.23];
resMean1 = [0.30 0.22 0.14 0.24	0.27 0.38 0.24 0.27	0.22];

resWhole2 = [0.54 0.58 0.43	0.41 0.53 0.50 0.52	0.57 0.47];
resMean2 = [0.54 0.62 0.34 0.45	0.57 0.52 0.47 0.61 0.41];

resWhole3 = [0.75 0.79 0.75	0.60 0.67 0.69 0.72	0.74 0.73];
resMean3 = [0.82 0.88 0.77 0.64	0.67 0.72 0.74 0.82	0.71];

resWhole4 = [0.83 0.83 0.81	0.76 0.76 0.77 0.78	0.80 0.79];
resMean4 = [0.87 0.91 0.83 0.85	0.77 0.78 0.77 0.87	0.77];

resWhole5 = [0.86 0.87 0.82	0.81 0.82 0.83 0.86	0.86 0.83];
resMean5 = [0.89 0.91 0.82 0.90	0.82 0.84 0.86 0.91	0.82];

resWhole6 = [0.89 NaN 0.86 0.88	0.84 0.86 0.88 0.88	0.87];
resMean6 = [0.91 NaN 0.86 0.94 0.83	0.85 0.88 0.93 0.85];


meanVafs = vertcat(resMean1, resMean2, resMean3, resMean4, resMean5, resMean6).';
wholeVafs = vertcat(resWhole1, resWhole2, resWhole3, resWhole4, resWhole5, resWhole6).';

figure
hold on
scatter(1:6, nanmean(wholeVafs, 1), 150, 'k', 'filled')
scatter(1:6, nanmean(meanVafs, 1), 150, [139/255 0 0], 'filled')

legend 'Whole from residual' 'Mean from residual'
legend boxoff

errorbar(1:6, nanmean(wholeVafs, 1), nanstd(wholeVafs, 1), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k')
errorbar(1:6, nanmean(meanVafs, 1), nanstd(meanVafs, 1), 'LineStyle', 'none', 'LineWidth', 2, 'Color', [139/255 0 0])

ylim([0 1])
yticks(.2:.2:1)
xticks(1:6)

xlabel('Number of Synergies')
ylabel('VAF')

title('Mean Predictions - FA')
set(gca,'TickDir','out')
set(gca, 'FontSize', 15)
axis square
box off
