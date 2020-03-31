%% Figure 8b - Step Scramble Summary - Factor Analysis

avg.whole = [0.32 0.48 0.55 0.62 0.67 0.71];
avg.res = [0.09 0.17 0.26 0.35 0.44 0.52];
avg.res2Whole = [0.08 0.16 0.25 0.34 0.43 0.51];

std.whole = [0.04 0.06 0.06 0.06 0.05 0.02];
std.res = [0.01 0.01 0.02 0.02 0.03 0.02];
std.res2Whole = [0.02 0.03 0.03 0.04 0.05 0.04];
synNums = 1:6;

figure
hold on
scatter(synNums, avg.whole, 120, 'k', 'MarkerFaceColor', 'k')
scatter(synNums, avg.res2Whole, 120, 'MarkerEdgeColor', [.31, .45, .51], 'MarkerFaceColor', [.31, .45, .51])
scatter(synNums, avg.res, 120, 'c', 'filled')

legend 'Whole from whole' 'Whole from residual' 'Residual from residual'
legend boxoff

errorbar(synNums, avg.whole, std.whole, 'LineStyle', 'none', 'Color', 'k')
errorbar(synNums, avg.res2Whole, std.res2Whole, 'LineStyle', 'none', 'Color', [.31, .45, .51])
errorbar(synNums, avg.res, std.res, 'LineStyle', 'none', 'Color', 'c')

xlabel('Number of Synergies')
ylabel('VAF')
title('Step Scramble Summary - FA')

%scatter(synNums, avg.res, 'c', 'MarkerFaceColor', 'c')
set(gca, 'XTick', 1:6)
set(gca, 'YTick', [0 .2 .4 .6 .8 1])
set(gca, 'FontSize', 16)
set(gca, 'Color', 'none')

set(gca,'TickDir','out'); box off
ylim([0 1])
axis square