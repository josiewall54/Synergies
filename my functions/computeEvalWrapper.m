% some notes
function [avgR, avgRFolds, rAll, builtData] = computeEvalWrapper(wholeData, residualData, buildProportion, alg) %#ok<STOUT,*INUSD>

    testProp = 1 - buildProportion;
    numberOfFolds = int32(floor(1 / testProp));
    foldLength = floor(testProp * length(wholeData));
    
    foldStartStop = zeros(numberOfFolds, 2);
    for i = 1:numberOfFolds       
        foldStartStop(i,1) = foldLength * (i - 1) + 1;
        foldStartStop(i,2) = foldLength * i;      
    end
    

    for i = 1:numberOfFolds
        
        testIdx = foldStartStop(i,1):foldStartStop(i,2);
        
        modelChunkIdx = [];
        for j = setdiff(1:numberOfFolds, i)
            modelIdx = horzcat(modelChunkIdx, foldStartStop(j,1):foldStartStop(j,2));
        end
        
        modelData.whole = wholeData(:, modelIdx);
        testData.whole = wholeData(:, testIdx);
        
        modelData.residual = residualData(:, modelIdx);
        testData.residual = residualData(:, testIdx);
        
        %modelData.combo = horzcat(modelData.whole, modelData.residual);
        %testData.combo = horzcat(testData.whole, testData.residual);
        
        modelData.combo = horzcat(modelData.whole - mean(modelData.whole, 2), modelData.residual - mean(modelData.whole, 2));
        testData.combo = horzcat(testData.whole - mean(testData.whole, 2), testData.residual + mean(testData.residual, 2));
        
        str = ['[avgRFolds{' num2str(i) '}, rAll{' num2str(i) '}, builtData{' num2str(i) '}] = computeEval(modelData, testData, alg);'];
        eval(str)
        
    end
    
    avgR.reg = zeros(length(avgRFolds{1}.reg), 1);
    avgR.res = zeros(length(avgRFolds{1}.reg), 1);
    avgR.com = zeros(length(avgRFolds{1}.reg), 1);
    avgR.regRes = zeros(length(avgRFolds{1}.reg), 1);
    avgR.resReg = zeros(length(avgRFolds{1}.reg), 1);
    avgR.comReg = zeros(length(avgRFolds{1}.reg), 1);
    avgR.comRes = zeros(length(avgRFolds{1}.reg), 1);
    for i = 1:length(avgR.reg)
        
        sumReg = 0;
        sumRes = 0;
        sumCom = 0;
        sumRegRes = 0;
        sumResReg = 0;
        sumComReg = 0;
        sumComRes = 0;
        
        for j = 1:size(avgRFolds, 2)
            sumReg = sumReg + avgRFolds{j}.reg(i);
            sumRes = sumRes + avgRFolds{j}.res(i);
            sumCom = sumCom + avgRFolds{j}.com(i);
            sumRegRes = sumRegRes + avgRFolds{j}.regRes(i);
            sumResReg = sumResReg + avgRFolds{j}.resReg(i);
            sumComReg = sumComReg + avgRFolds{j}.comReg(i);
            sumComRes = sumComRes + avgRFolds{j}.comRes(i);
        end
        avgR.reg(i) = sumReg / size(avgRFolds, 2);
        avgR.res(i) = sumRes / size(avgRFolds, 2);
        avgR.com(i) = sumCom / size(avgRFolds, 2);
        avgR.regRes(i) = sumRegRes / size(avgRFolds, 2);
        avgR.resReg(i) = sumResReg / size(avgRFolds, 2);
        avgR.comReg(i) = sumComReg / size(avgRFolds, 2);
        avgR.comRes(i) = sumComRes / size(avgRFolds, 2);
    end
    
end