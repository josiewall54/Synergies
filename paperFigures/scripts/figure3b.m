%% Figure 3b - summary synNum vs. VAF - Factor Analysis
avg.whole = [0.35 0.58 0.76 0.83 0.87 0.91];
avg.res2Whole = [0.26 0.50 0.72 0.79 0.84 0.87];
%avg.control = [0.32 0.48 0.55 0.62 0.67 0.71]; %step scramble - w2w
avg.control = [0.08 0.16 0.25 0.34 0.43 0.51]; %r2w


std.whole = [0.06 0.06 0.05 0.03 0.03 0.02];
std.res2Whole = [0.04 0.06 0.06 0.03 0.02 0.02];
%std.control = [0.04 0.06 0.06 0.06 0.05 0.02]; %step scramble = w2w
std.control = [0.02 0.03 0.03 0.04 0.05 0.04]; %r2w

synNums = 1:6;


figure
hold on

%--------------------plot means----------------------------------------
scatter(synNums + 0.05, avg.res2Whole, 120, 'MarkerEdgeColor', [.31, .45, .51], 'MarkerFaceColor', [.31, .45, .51])
scatter(synNums, avg.whole, 120, 'k', 'MarkerFaceColor', 'k')
scatter(synNums + 0.1, avg.control, 120, 'MarkerEdgeColor', [.6 .6 .6], 'MarkerFaceColor', [.6 .6 .6])

%legend 'Whole from whole' 'Whole from residual' 'Whole from step scramble (whole)'
legend 'Whole from whole' 'Whole from residual' 'Step Scramble'
legend boxoff

%--------------------plot std devs---------------------------------------
errorbar(synNums + 0.05, avg.res2Whole, std.res2Whole, 'LineStyle', 'none', 'Color', [.31, .45, .51])
errorbar(synNums, avg.whole, std.whole, 'LineStyle', 'none', 'Color', 'k')
errorbar(synNums + 0.1, avg.control, std.control, 'LineStyle', 'none', 'Color', [.6 .6 .6])

xlabel('Number of Synergies')
ylabel('VAF')
title('Summary - FA')

%scatter(synNums, avg.res, 'c', 'MarkerFaceColor', 'c')
set(gca, 'XTick', 1:6)
set(gca, 'YTick', [0 .2 .4 .6 .8 1])
set(gca, 'FontSize', 16)
set(gca, 'Color', 'none')

set(gca,'TickDir','out'); box off
ylim([0 1])
axis square