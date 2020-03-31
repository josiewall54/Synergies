%% residuals concat
figure
for i = 1:10
    subplot(10,1,i)
    plot(stepResidualsConcat(i,:), 'm', 'LineWidth', 3)
    xlim([0 500])
    
    set(gca, 'TickDir', 'out')
    set(gca, 'Color', 'none', 'XColor', 'none', 'YColor', 'none')
    box off
end

%% steps concat
figure
for i = 1:10
    subplot(10,1,i)
    plot(stepsConcat(i,:), 'k', 'LineWidth', 3)
    xlim([0 500])
    
    set(gca, 'TickDir', 'out')
    set(gca, 'Color', 'none', 'XColor', 'none', 'YColor', 'none')
    box off
end

%% example traces
figure
for i = 1:6
    subplot(6,1,i)
    hold on
    plot(testData.whole(i,:), 'k', 'LineWidth', 2)
    plot(builtData.reg{4}(i,:), 'Color', [0.31, 0.45, 0.51], 'LineWidth', 2)
    axis tight
    xlim([0 1500])
    box off
    set(gca, 'TickDir', 'out')
    set(gca, 'Color', 'none', 'XColor', 'none', 'YColor', 'none')
end