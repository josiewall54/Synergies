%% Set params

lineWidth = 2;
sigs = [9,11];
ratName = 'J8';

%% Make plot
figure

subplot(2,1,1)
hold on
y = testData.whole(sigs(1),:);
yHatWhole = builtData.reg{1,3}(sigs(1),:);
yHatRes = builtData.resReg{1,3}(sigs(1),:);
plot(y, 'k', 'LineWidth', lineWidth)
plot(yHatWhole, 'b', 'LineWidth', lineWidth)
plot(yHatRes, 'r', 'LineWidth', lineWidth)
legend(['Actual - ' num2str(sigs(1))], 'Whole Prediction', 'Residual Prediction')
legend boxoff
set(gca,'TickDir','out')
title(ratName)
xlabel(['VAF Whole: ' num2str(computeVaf(y, yHatWhole)) '; VAF Res: ' num2str(computeVaf(y, yHatRes))])
xlim([3000 4500])

subplot(2,1,2)
hold on
y = testData.whole(sigs(2),:);
yHatWhole = builtData.reg{1,3}(sigs(2),:);
yHatRes = builtData.resReg{1,3}(sigs(2),:);
plot(y, 'k', 'LineWidth', lineWidth)
plot(yHatWhole, 'b', 'LineWidth', lineWidth)
plot(yHatRes, 'r', 'LineWidth', lineWidth)
legend(['Actual - ' num2str(sigs(2))], 'Whole Prediction', 'Residual Prediction')
legend boxoff
set(gca,'TickDir','out')
xlabel(['VAF Whole: ' num2str(computeVaf(y, yHatWhole)) '; VAF Res: ' num2str(computeVaf(y, yHatRes))])
xlim([3000 4500])

%%
bdReg = builtData.reg{1,3};
bdResReg = builtData.resReg{1,3};
vafWhole = zeros(size(bdReg,1), 1);
vafRes = zeros(size(bdReg,1), 1);
for i = 1:size(bdReg, 1)
    vafWhole(i) = computeVaf(testData.whole(i,:), bdReg(i,:));
    vafRes(i) = computeVaf(testData.whole(i,:), bdResReg(i,:));
end

%% muscle vaf scatter


