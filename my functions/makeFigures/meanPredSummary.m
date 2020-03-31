%% res -> mean for all subjects

resWhole2 = [0.51 0.42 0.31 0.25 0.51 0.42 0.47	0.37 0.36];
resMean2 = [0.49 0.49 0 0.3 0.51 0.02 0.36 0.39 -0.4];

resWhole3 = [0.65 0.72 0.65 0.39 0.58 0.52 0.67	0.46 0.5];
resMean3 = [0.68 0.82 0.46 0.43	0.55 0.39 0.67 0.49	0.41];

resWhole4 = [0.75 0.78 0.72	0.48 0.7 0.71 0.76 0.65	0.7];
resMean4 = [0.74 0.85 0.62 0.49	0.69 0.61 0.77 0.69 0.61];

resWhole5 = [0.81 0.8 0.74 0.59	0.72 0.72 0.77 0.83	0.8];
resMean5 = [0.83 0.87 0.55 0.62	0.71 0.62 0.72 0.89	0.79];

resWhole6 = [0.83 0.81 0.76	0.6	0.72 0.73 0.81 0.83	0.8];
resMean6 = [0.88 0.88 0.5 0.61 0.7 0.62	0.8	0.89 0.79];

figure
hold on
scatter(resWhole2, resMean2, 100, 'c', 'filled')
scatter(resWhole3, resMean3, 100, 'm', 'filled')
scatter(resWhole4, resMean4, 100, 'k', 'filled')
scatter(resWhole5, resMean5, 100, 'g', 'filled')
scatter(resWhole6, resMean6, 100, 'b', 'filled')
plot(-.5:.1:1, -.5:.1:1, 'k-')

xlim([0 1])
ylim([0 1])

legend '2 synergies' '3 synergies' '4 synergies' '5 synergies' '6 synergies'
legend boxoff

xlabel('Residual -> Whole')
xticks([0.2 0.4 0.6 0.8 1])
ylabel('Residual -> Mean')
yticks([0.2 0.4 0.6 0.8 1])

axis square
set(gca,'TickDir','out'); box off

%% synNum - VAF averages

meanVafs = vertcat(resMean2, resMean3, resMean4, resMean5, resMean6).';
wholeVafs = vertcat(resWhole2, resWhole3, resWhole4, resWhole5, resWhole6).';

figure
hold on
scatter(2:1:6, mean(wholeVafs, 1), 150, 'k', 'filled')
%errorbar(2:1:6, mean(wholeVafs, 1), std(wholeVafs, 1), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k')

scatter(2:1:6, mean(meanVafs, 1), 150, [.31 .45 .51], 'filled')
%errorbar(2:1:6, mean(meanVafs, 1), std(meanVafs, 1), 'LineStyle', 'none', 'LineWidth', 2, 'Color', [.31 .45 .51])

ylim([0 1])
yticks(.2:.2:1)
xticks(2:1:6)

legend 'Whole from residual' 'Mean from residual'

set(gca,'TickDir','out')
set(gca, 'FontSize', 15)
box off

%% delta VAFs
deltaVafs = wholeVafs - meanVafs;
colors = [255 135 0;
          254 209 93;
          250 69 10;
          168 67 0;
          79 58 0;
          253 180 115;
          254 232 138;
          102 27 4;
          89 80 19] / 255;

figure
hold on
for i = 1:size(deltaVafs, 1)
    scatter(2:1:6, deltaVafs(i,:), 100, colors(i,:), 'filled')
end


%need to add chance to this plot. will likely be very busy

%legend 'Whole from residual' 'Mean from residual'
ylim([-0.2 1])
xticks(2:1:6)
yticks(-0.2:0.2:1)

set(gca,'TickDir','out')
set(gca, 'FontSize', 15)
box off
