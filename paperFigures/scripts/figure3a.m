%% Figure 3a - summary synNum vs. VAF - ICAPCA
avg.whole = [.32 .52 .68 .76 .8 .82];
avg.res2Whole = [.22 .40 .57 .69 .75 .77];
%avg.control = [0.27 0.40 0.47 0.54 0.61 0.67]; %step scramble - w2w
avg.control = [0.08 0.17 0.26 0.33 0.41 0.50]; %r2w


std.whole = [0.06 0.061 0.068 0.064 0.050 0.051];
std.res2Whole = [0.058 0.089 0.11 0.089 0.073 0.074];
%std.control = [0.06 0.07 0.08 0.07 0.06 0.06]; %step scramble - w2w
std.control = [0.03 0.02 0.03 0.03 0.07 0.05]; %r2w

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
title('Summary - ICAPCA')

%scatter(synNums, avg.res, 'c', 'MarkerFaceColor', 'c')
set(gca, 'XTick', 1:6)
set(gca, 'YTick', [0 .2 .4 .6 .8 1])
set(gca, 'FontSize', 16)
set(gca, 'Color', 'none')

set(gca,'TickDir','out'); box off
ylim([0 1])
axis square