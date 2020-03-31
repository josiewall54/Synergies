%% Figure 7b - Subspace Compare - Factor Analysis

%% summary subspace compare - averages - FACTOR ANALYSIS (w/varimax)

%summary numbers
n1 = 57.36;
n2 = [20.89	43.37];
n3 = [15.95	17.43 28.84];
n4 = [14.17	17.46 22.20	40.63];
n5 = [15.05	20.01 24.24	31.08 65.35];
n6 = [13.90	18.89 20.51	22.68 38.01 52.81];

%scrambled synergies - averaged across subjects
n1_s = 75.99;
n2_s = [67.94 75.50];
n3_s = [64.33 70.42	75.76];
n4_s = [59.95 66.97	71.73 76.52];
n5_s = [55.74 62.86	67.74 73.14	78.30];
n6_s = [53.84 59.05 63.45 68.05	70.98 78.72];

avg = [mean(n1) mean(n2) mean(n3) mean(n4) mean(n5) mean(n6)];
stdDev = [std(n1) std(n2) std(n3) std(n4) std(n5) std(n6)];

avg_s = [mean(n1_s) mean(n2_s) mean(n3_s) mean(n4_s) mean(n5_s) mean(n6_s)];
stdDev_s = [std(n1_s) std(n2_s) std(n3_s) std(n4_s) std(n5_s) std(n6_s)];

synNums = 1:6;

figure
hold on

%plot real numbers
scatter(synNums, avg, 120, 'MarkerEdgeColor', [.31 .45 .51], 'MarkerFaceColor', [.31 .45 .51])
scatter(synNums, avg_s, 120, 'MarkerEdgeColor', [.2, .2, .2], 'MarkerFaceColor', [.2, .2, .2])

legend 'Actual angles' 'Scrambled weights'
legend boxoff

errorbar(synNums, avg, stdDev, 'LineStyle', 'none', 'Color', [.31 .45 .51])
errorbar(synNums, avg_s, stdDev_s, 'LineStyle', 'none', 'Color', [.2, .2, .2])

%plot scatter numbers
%scatter(synNums, avg.res, 'c', 'MarkerFaceColor', 'c')
title('Summary - Factor Analysis')
xlabel('Number of Synergies')
ylabel('Angle between basis vectors (degrees)')

set(gca, 'XTick', 1:6)
set(gca, 'YTick', 0:15:90)
set(gca, 'FontSize', 16)
set(gca, 'Color', 'none')
set(gca,'TickDir','out')
box off
ylim([0 90])
axis square
