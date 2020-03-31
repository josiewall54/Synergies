%% summary plots

%% synNum vs. VAF - averages
avg.whole = [.32 .52 .68 .76 .8 .82];
avg.res2Whole = [.22 .40 .57 .69 .75 .77];
avg.control = [-1.02 -6.21 -5.67 -3.88 -4.75 -7.12]; %scrambled synergy weights
%avg.control = [0.27 0.20 0.47 0.54 0.61 0.67]; %scrambled steps (whole -> whole)


std.whole = [0.06 0.061 0.068 0.064 0.050 0.051];
std.res2Whole = [0.058 0.089 0.11 0.089 0.073 0.074];
std.control = [0.787 9.777 5.712 4.566 3.265 14.407]; %scrambled synergy weights
%std.control = [0.06 0.07 0.08 0.07 0.06 0.06]; %scrambled steps (whole -> whole)

synNums = 1:6;


figure
hold on

%--------------------plot means----------------------------------------
scatter(synNums + 0.05, avg.res2Whole, 120, 'MarkerEdgeColor', [.31, .45, .51], 'MarkerFaceColor', [.31, .45, .51])
scatter(synNums, avg.whole, 120, 'k', 'MarkerFaceColor', 'k')
scatter(synNums + 0.1, avg.control, 120, 'MarkerEdgeColor', [.6 .6 .6], 'MarkerFaceColor', [.6 .6 .6])

%legend 'Whole from whole' 'Whole from residual' 'Whole from step scramble (whole)'
legend 'Whole from whole' 'Whole from residual' 'Whole from scrambled whole'
legend boxoff

%--------------------plot std devs---------------------------------------
errorbar(synNums + 0.05, avg.res2Whole, std.res2Whole, 'LineStyle', 'none', 'Color', [.31, .45, .51])
errorbar(synNums, avg.whole, std.whole, 'LineStyle', 'none', 'Color', 'k')
errorbar(synNums + 0.1, avg.control, std.control, 'LineStyle', 'none', 'Color', [.6 .6 .6])

xlabel('Number of Synergies')
ylabel('VAF')
title('Summary (og analysis)')

%scatter(synNums, avg.res, 'c', 'MarkerFaceColor', 'c')
set(gca, 'XTick', 1:6)
%set(gca, 'YTick', [0 .2 .4 .6 .8 1])
set(gca, 'FontSize', 16)
set(gca, 'Color', 'none')

set(gca,'TickDir','out'); box off
%ylim([0 1])
axis square


%% decorrelated - averages
avg.whole = [0.24 0.37 0.44 0.5 0.56 0.64];
avg.res = [0.09 0.18 0.26 0.35 0.44 0.53];
avg.res2Whole = [0 0.09 0.17 0.24 0.33 0.41];

std.whole = [0.06 0.06 0.06 0.05 0.05 0.04];
std.res = [0.01 0.01 0.02 0.02 0.03 0.03];
std.res2Whole = [0.14 0.08 0.06 0.08 0.08 0.09];
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
title('Summary (decorrelated)')

%scatter(synNums, avg.res, 'c', 'MarkerFaceColor', 'c')
set(gca, 'XTick', 1:6)
set(gca, 'YTick', [0 .2 .4 .6 .8 1])
set(gca, 'FontSize', 16)
set(gca, 'Color', 'none')

set(gca,'TickDir','out'); box off
ylim([0 1])
axis square



%% summary subspace compare - all points
n2 = [21.62	32.78];
n3 = [14.70	25.13 32.70];
n4 = [9.34 19.78 29.69 53.07];
n5 = [7.70 13.11 21.22 28.52 51.56];
n6 = [8.11 14.48 21.24 26.34 38.38 60.25];

figure
hold on
scatter(ones(2, 1) * 2, n2, 'k', 'MarkerFaceColor', 'k')
scatter(ones(3, 1) * 3, n3, 'k', 'MarkerFaceColor', 'k')
scatter(ones(4, 1) * 4, n4, 'k', 'MarkerFaceColor', 'k')
scatter(ones(5, 1) * 5, n5, 'k', 'MarkerFaceColor', 'k')
scatter(ones(6, 1) * 6, n6, 'k', 'MarkerFaceColor', 'k')
set(gca,'TickDir','out'); box off
ylim([0 90])

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
title('Summary')
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

%% predicting mean vs. whole
meanVafs = [.49 .82 .85 .87 .88;...
            0 .46 .62 .55 .5;...
            .3 .43 .49 .62 .61;...
            .51 .55 .69 .71 .7];
wholeVafs = [.42 .72 .78 .8 .81;...
            .31 .65 .72 .74 .76;...
            .25 .39 .48 .59 .6;...
            .51 .58 .7 .72 .72];
residualVafs = [];
rats = {'J10', 'J12', 'J13', 'J15'};
markers =  {'o', 's', '*', 'd'};

figure
hold on
for i = 1:length(rats)
    scatter(2:1:6, meanVafs(i,:), 60, ['k' markers{i}], 'filled')
    scatter(2:1:6, wholeVafs(i,:), 60, ['b' markers{i}], 'filled')
    ylabel('VAF')
end

xlabel('Number of synergies')
legend('Mean from residuals', 'Whole from residuals')


%% predicting mean - summary

resToWhole = [0.22 0.4 0.57 0.69 0.75 0.77];
resToMean = [0.05 0.24 0.54 0.67 0.73 0.74];

stdResToWhole = [0.058 0.089 0.11 0.089 0.073 0.074];
stdResToMean = [0.251 0.307 0.148 0.106 0.12 0.14];

synNums = 1:6;

figure
hold on
scatter(synNums, resToWhole, 120, [.31 .45 .51], 'filled')
scatter(synNums, resToMean, 120, [0.8 0.26 0.3], 'filled')

legend 'Whole from residual' 'Mean from residual'
legend boxoff

errorbar(synNums, resToWhole, stdResToWhole, 'LineStyle', 'none', 'Color', [.31 .45 .51])
errorbar(synNums, resToMean, stdResToMean, 'LineStyle', 'none', 'Color', [0.8 0.26 0.3])

ylim([0 1])
yticks(0:0.2:1)
xticks(1:6)

ylabel('VAF')
xlabel('Number of Synergies')
title('Summary (mean predictions)')

set(gca, 'TickDir', 'out')
set(gca, 'Color', 'none')
set(gca, 'FontSize', 15)
box off
axis square


%% stepScramble - summary
avg.whole = [0.27 0.4 0.47 0.54 0.61 0.67];
avg.res = [0.09 0.17 0.26 0.34 0.43 0.52];
avg.res2Whole = [0.08 0.17 0.26 0.33 0.41 0.5];

std.whole = [0.06 0.07 0.08 0.07 0.06 0.06];
std.res = [.01 .01 .02 .02 .03 .04];
std.res2Whole = [.03 .02 .03 .03 .07 .05];
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
title('Summary (stepScramble)')

%scatter(synNums, avg.res, 'c', 'MarkerFaceColor', 'c')
set(gca, 'XTick', 1:6)
set(gca, 'YTick', [0 .2 .4 .6 .8 1])
set(gca, 'FontSize', 16)
set(gca, 'Color', 'none')

set(gca,'TickDir','out'); box off
ylim([0 1])
axis square

%% factor analysis - VAF vs. synNum - summary
avg.whole = [0.35 0.58 0.76 0.83 0.87 0.91];
avg.res = [0.28 0.50 0.66 0.74 0.80 0.85];
avg.res2Whole = [0.26 0.50 0.72 0.79 0.84 0.87];

std.whole = [0.06 0.06 0.05 0.03 0.03 0.02];
std.res = [0.03 0.03 0.05 0.03 0.03 0.03];
std.res2Whole = [0.04 0.06 0.06 0.03 0.02 0.02];
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
title('Summary (Factor Analysis)')

%scatter(synNums, avg.res, 'c', 'MarkerFaceColor', 'c')
set(gca, 'XTick', 1:6)
set(gca, 'YTick', [0 .2 .4 .6 .8 1])
set(gca, 'FontSize', 16)
set(gca, 'Color', 'none')

set(gca,'TickDir','out'); box off
ylim([0 1])
axis square

%% summary subspace compare - averages - FACTOR ANALYSIS

%summary numbers
n1 = 57.36;
n2 = [31.46	37.13];
n3 = [24.98	30.66 39.95];
n4 = [21.98	33.09 36.49	50.71];
n5 = [28.83	33.79 45.33	50.95 62.61];
n6 = [26.16	32.92 36.59	43.12 48.14	67.05];

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
title('Summary (Factor Analysis)')
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
