%% Figure 7a - Subspace Compare - ICAPCA

%% summary subspace compare - averages

%summary numbers
n1 = 32.04;
n2 = [21.62, 32.78];
n3 = [14.70	, 25.13, 32.70];
n4 = [9.34, 19.78, 29.69, 53.07];
n5 = [7.70, 13.11, 21.22, 28.52, 51.56];
n6 = [8.11, 14.48, 21.24, 26.34, 38.38, 60.25];

%scrambled synergies - averaged across subjects
n1_s = 73.6;
n2_s = [65.8, 77.78];
n3_s = [56.73, 69.26, 75.45];
n4_s = [56.55, 65.84, 73.34, 77.35];
n5_s = [52.65, 60.24, 69.04, 73.71, 78.79];
n6_s = [45.65, 57.41, 63.97, 70.75, 74.81, 80.51];

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
title('Summary - ICAPCA')
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