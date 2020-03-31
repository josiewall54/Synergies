%% Figure 6b - Subspace Comparison - J8 - Factor Analysis

%% Plot synergies for n = 4

%re-arranging synergy comparison plot for J8, 5 syns.
%grouping muscles anatomically, and flipping negatively correlated
%synergies
clear
%load('/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/paperFigures/figureData/J8_fa.mat')
load('/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/paperFigures/figureData/J8_fa_varimax.mat')
basis = basis_4syns;

%resColor = 'b';
resColor = [.31 .45 .51];

%anatomically order synergies
newOrdering = [1 2 8 9 4 6 10 5 12 11 3 7];
newBasis.whole = basis.whole(newOrdering, :);
newBasis.residual = basis.residual(newOrdering, :);
labels = labels(newOrdering);



f = figure;
synNum = size(basis.whole, 2);

for i = 1:synNum
    h = subplot(2,synNum, i);
    if(i == 5)
        bar(newBasis.whole(:,i).*-1, 'FaceColor', 'k', 'EdgeColor', 'k')
    else
        bar(newBasis.whole(:,i), 'FaceColor','k','EdgeColor', 'k')
    end
    set(h, 'XTickLabel', labels)
    set(h, 'XTickLabelRotation', 45)
    box off
    set(gca, 'Color', 'none', 'XColor', 'none', 'YColor', 'none')

    g = subplot(2,synNum, i + synNum);
    if(i == 5)
        bar(newBasis.residual(:,i).*-1, 'FaceColor', resColor, 'EdgeColor', resColor)
    else
        bar(newBasis.residual(:,i), 'FaceColor',resColor,'EdgeColor', resColor)
    end
    
    angle = subspace(basis.whole(:,i), basis.residual(:,i));
    %xlabel(['Angle: ' num2str(round(rad2deg(angle))) 'deg'])
    xlabel(num2str(round(rad2deg(angle))))
    
    set(g, 'XTickLabel', labels)
    set(g, 'XTickLabelRotation', 45)
    box off
    set(gca, 'Color', 'none', 'YColor', 'none')
end

set(f, 'PaperOrientation', 'landscape')


%% Subspace compare scatter plot - J8 - FA

%single subject numbers - J8
n1 = 52.06;
n2 = [30.98 45.57];
n3 = [31.69 22.73 48.63];
n4 = [32.53 47.91 57.05 78.66];
n5 = [27.18 32.88 74.34 53.24 57.94];
n6 = [21.63	29.35 45.99	61.27 58.73	71.14];

%scrambled synergies - only J8
n1_s = 76.44;
n2_s = [69.39 78.01];
n3_s = [70.03 74.23	74.46];
n4_s = [61.03 67.80	70.68 79.69];
n5_s = [54.04 68.60	70.34 71.78	83.13];
n6_s = [55.82 61.68	63.12 66.96 75.37 80.34];

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
set(gca, 'XTick', 1:6)
set(gca, 'YTick', 0:15:90)
set(gca, 'FontSize', 16)
set(gca, 'Color', 'none')
set(gca,'TickDir','out'); box off
ylim([0 90])
axis square


xlabel('Number of Synergies')
ylabel('Angle between basis vectors (degrees)')
title('Subspace Compare - J8 - FA')