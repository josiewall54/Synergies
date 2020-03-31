%% Figure 6a - Subspace Comparison - J8 - ICAPCA

%% Plot synergies for n = 4

%re-arranging synergy comparison plot for J8, 5 syns.
%grouping muscles anatomically, and flipping negatively correlated
%synergies
clear
load('/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/paperFigures/figureData/J8_icapca.mat')
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
    if(i == 1)
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
    xlabel(num2str(round(rad2deg(angle))))
    
    set(g, 'XTickLabel', labels)
    set(g, 'XTickLabelRotation', 45)
    box off
    %set(gca, 'Color', 'none', 'XColor', 'none', 'YColor', 'none')
    set(gca, 'Color', 'none', 'YColor', 'none')
    
end

set(f, 'PaperOrientation', 'landscape')

%% Subspace compare scatter

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
title('Subspace Compare - J8 - ICAPCA')