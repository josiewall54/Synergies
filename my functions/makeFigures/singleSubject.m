%% Plot Traces
%This is ran at breakpoint in computeEval
% in future, save data for easy access

figure

for i = 1:2
    subplot(5,1,i)
    hold on
    plot(testData.whole(i + 10,:), 'k')
    plot(builtData.resReg{3}(i + 10,:), 'b')
    
    axis tight
    set(gca,'TickDir','out'); box off
    xlim([500 2000])
end


%% Subspace difference plot
% number for J15
corr.n2 = [0.978, 0.919];
corr.n3 = [0.986, 0.940, 0.909];
corr.n4 = [0.993, 0.989, 0.962, 0.864];
corr.n5 = [0.996, 0.993, 0.988, 0.984, 0.807];
corr.n6 = [0.988, 0.965, 0.942, 0.884, 0.778, 0.610];
corr.n7 = [0.997, 0.989, 0.973, 0.950, 0.915, 0.789, 0.397];
corr.n8 = [0.995, 0.985, 0.983, 0.970, 0.913, 0.873, 0.787, 0.671];

ang.n2 = [12.8, 25.8];
ang.n3 = [8.58, 19.9, 25.4];
ang.n4 = [8.33, 8.44, 15.5, 26.9];
ang.n5 = [5.09, 8.84, 10.1, 12.7, 32.1];
ang.n6 = [10.2, 17.6, 22.1, 27.6, 37.7, 46.5];
ang.n7 = [5.06, 9.19, 12.3, 18.5, 23.2, 40.5, 64.1];
ang.n8 = [5.72, 10.8, 10.8, 14.1, 21.6, 28.8, 40.5, 37.9];

figure
hold on
for i = 2:8
    x = ones(i, 1) * i;
    str = ['y = ang.n' num2str(i)];
    eval(str)
    
    scatter(x, y, 'MarkerFaceColor', 'k')
end

%% res -> res, mean, whole

resRes = [0.49 0.58 0.67 0.71 0.73 0.79 0.81];
resWhole = [0.55 0.67 0.78 0.84 0.85 0.88 0.89];
resMean = [0.5 0.68 0.73 0.83 0.86 0.88 0.89];

synNums = 2:1:8;

figure
hold on
scatter(synNums, resRes, 'c', 'MarkerFaceColor','c')
scatter(synNums, resWhole, 'm', 'MarkerFaceColor', 'm')
scatter(synNums, resMean, 'b', 'MarkerFaceColor', 'b')

legend('Residual -> Residual', 'Residual -> Whole', 'Residual -> Mean')
legend boxoff

axis square
set(gca,'TickDir','out'); box off

%% subspace diff - J8

%single subject numbers - J8
n1 = 21.74;
n2 = [27.45, 34.98];
n3 = [3.24, 21.06, 28.17];
n4 = [3.71, 20.44, 56.33, 4.76];
n5 = [4.58, 18.52, 27.87, 49.08, 39.43];
n6 = [4.40, 4.60, 18.80, 26.70, 48.5, 65.06];

%scrambled synergies - only J8
n1_s = 76.36;
n2_s = [64.22, 80];
n3_s = [57.77, 71.33, 80.03];
n4_s = [51.58, 66.15, 69.01, 78.74];
n5_s = [61.24, 61.88, 73.88, 75.13, 78.25];
n6_s = [46.73, 56.17, 61.17, 73.41, 76.95, 79.96];

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

errorbar(synNums, avg, stdDev, 'LineStyle', 'none', 'Color', [.31 .45 .51])
errorbar(synNums, avg_s, stdDev_s, 'LineStyle', 'none', 'Color', [.2, .2, .2])

%plot scatter numbers


%scatter(synNums, avg.res, 'c', 'MarkerFaceColor', 'c')
set(gca, 'XTick', 1:6)
set(gca, 'YTick', 0:15:90)
set(gca, 'FontSize', 16)
set(gca, 'Color', 'none')
set(gca,'TickDir','out'); box off
ylim([0 90])
axis square


xlabel('Number of Synergies')
ylabel('Angle between basis vectors (degrees)')
title('J8')

%% Plot scatter for J8 synNums; just whole -> whole and residual -> whole,
% with grey background and new blue dot color

wholeToWhole = [0.36 0.55 0.67 0.77 0.84 0.85];
resToWhole = [0.28 0.51 0.65 0.75 0.81 0.83];
%resToRes = [0.29 0.47 0.57 0.67 0.74 0.76];
stepScrambleWhole = [0.27 0.37 0.44	0.51 0.57 0.62];

synNums = 1:6;

figure
hold on
scatter(synNums, wholeToWhole, 120, 'k', 'filled')
scatter(synNums, resToWhole, 120, [.31 .45 .51], 'filled')
%scatter(synNums, resToRes, 120, 'c', 'filled')
scatter(synNums, stepScrambleWhole, 120, [.6 .6 .6], 'filled')
ylim([0 1])
yticks(0:0.2:1)
xticks(1:6)

xlabel('Number of Synergies')
ylabel('VAF')
title('J8')

legend 'Whole from whole' 'Whole from residual' 'Step scramble control (whole)'
legend boxoff

set(gca, 'TickDir', 'out')
set(gca, 'Color', 'none')
set(gca, 'FontSize', 15)
box off

%% gaussian sim
%need J8 w/ res -> res & gaussian sim nums
whole_g  = [0.4, 0.47, 0.52, 0.61, 0.63];
resToRes_g = [0.17 .24 .31 .41 .49];
resToWhole_g = [0.16, .24, .29, .37, .49];
synNums = 2:1:6;

figure
hold on
scatter(synNums, whole_g, 120, 'k', 'filled')
scatter(synNums, resToWhole_g, 120, [.31 .45 .51], 'filled')
scatter(synNums, resToRes_g, 120, 'c', 'filled')

ylim([0 1])
yticks(0:0.2:1)
xticks(2:1:6)

legend 'Whole from whole' 'Whole from residual' 'Residual from residual'
legend boxoff

set(gca, 'TickDir', 'out')
set(gca, 'Color', 'none')
set(gca, 'FontSize', 15)
box off


%% predicting mean - J8

resToWhole = [0.28 0.51 0.65 0.75 0.81 0.83];
resToMean = [0.22 0.49 0.68 0.74 0.83 0.88];
synNums = 1:6;

figure
hold on
scatter(synNums, resToWhole, 120, [.31 .45 .51], 'filled')
scatter(synNums, resToMean, 120, [0.8 0.26 0.3], 'filled')

ylim([0 1])
yticks(0:0.2:1)
xticks(1:6)

legend({'Whole from residual' 'Mean from residual'}, 'FontSize', 20)
legend boxoff

ylabel('VAF')
xlabel('Number of Synergies')
title('J8')

set(gca, 'TickDir', 'out')
set(gca, 'Color', 'none')
set(gca, 'FontSize', 15)
box off
axis square


%% decorrelated (bin-by-bin) - J8

whole  = [0.25 0.35 0.4 0.47 0.54 0.6];
resToRes = [0.08 0.17 0.25 0.33 0.41 0.5];
resToWhole = [0.05 0.13 0.2 0.25 0.34 0.4];
synNums = 1:6;

figure
hold on
scatter(synNums, whole, 120, 'k', 'filled')
scatter(synNums, resToWhole, 120, [.31 .45 .51], 'filled')
scatter(synNums, resToRes, 120, 'c', 'filled')

ylim([0 1])
yticks(0:0.2:1)
xticks(1:6)

legend 'Whole from whole' 'Whole from residual' 'Residual from residual'
legend boxoff

title('Decorrelated; bin-by-bin; J8')
ylabel('VAF')
xlabel('Number of Synergies')

set(gca, 'TickDir', 'out')
set(gca, 'Color', 'none')
set(gca, 'FontSize', 15)
box off
axis square


%% stepScramble - J8

whole  = [0.27 0.37 0.44 0.51 0.57 0.62];
resToRes = [0.08 0.16 0.25 0.33 0.41 0.5];
resToWhole = [0.08 0.16 0.25 0.32 0.37 0.47];
synNums = 1:6;

figure
hold on
scatter(synNums, whole, 120, 'k', 'filled')
scatter(synNums, resToWhole, 120, [.31 .45 .51], 'filled')
scatter(synNums, resToRes, 120, 'c', 'filled')

ylim([0 1])
yticks(0:0.2:1)
xticks(1:6)

legend 'Whole from whole' 'Whole from residual' 'Residual from residual'
legend boxoff

title('Step Scramble - J8')
ylabel('VAF')
xlabel('Number of Synergies')

set(gca, 'TickDir', 'out')
set(gca, 'Color', 'none')
set(gca, 'FontSize', 15)
box off
axis square









