function [] = analysisVariance(file, saveDir)
    
    % Load Data
    directory = '/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/Josie/data';
    fullFile = [directory '/' file];
    load(fullFile) %#ok<LOAD>
    
    % Set Parameters
    SAMP_FREQ = 5000;
    NORM_STEP_BIN_NUM = 100;
    if size(emg_goodCh, 2) == 1, emg_goodCh = emg_goodCh.'; end %#ok<NODEF>
    temp = 1:length(emg_goodCh);
    GOOD_MUSCLES = temp(temp.*emg_goodCh > 0);
    BUILD_PROP = 0.8; %proportion of data used to find synergies
    
    labels = emgPref(GOOD_MUSCLES);
    filteredEmg = filterEmg(emg_full_raw, SAMP_FREQ);
    
  
    [stepsConcat, steps] = getStepsConcat(filteredEmg, GOOD_MUSCLES, gait, NORM_STEP_BIN_NUM);
    
    [lowVarIdx, highVarIdx] = findVarExtremes(steps, [25 75]);
    stepAverages = mean(steps, 3).'; %compute step averages on entire datasets
    
    [stepsConcatLowVar, stepResidualsConcatLowVar]  = concatSelectSteps(steps, lowVarIdx, stepAverages);
    [stepsConcatHighVar, stepResidualsConcatHighVar]  = concatSelectSteps(steps, highVarIdx, stepAverages);

    % Generate synNum vs. corr scatter
    
    %This is the realy analysis
    [icapcaStruct.avgR, icapcaStruct.avgRFolds, icapcaStruct.rAll, icapcaStruct.builtData] = ...
        computeEvalWrapper(stepsConcatLowVar, stepResidualsConcatLowVar, BUILD_PROP, 'icapca');   
    plotSynNumVsCorr(icapcaStruct, [saveDir '/lowVar'])
    
    [icapcaStruct.avgR, icapcaStruct.avgRFolds, icapcaStruct.rAll, icapcaStruct.builtData] = ...
        computeEvalWrapper(stepsConcatHighVar, stepResidualsConcatHighVar, BUILD_PROP, 'icapca');   
    plotSynNumVsCorr(icapcaStruct, [saveDir '/highVar'])

    %plotSubspaces(stepsConcat, stepResidualsConcat, 2:4, labels, saveDir)

end

function [stepsConcat, stepResidualsConcat] = concatSelectSteps(steps, idx, stepAverages)
    %concatenate steps
    [stepsConcat, stepResidualsConcat] = deal(zeros(size(steps,2), 100 * length(idx)));
    for i = 1:length(idx)
        startIdx = (i-1) * 100 + 1;
        stopIdx = i * 100;
        stepsConcat(:,startIdx : stopIdx) = steps(:,:,idx(i)).';
        stepResidualsConcat(:, startIdx : stopIdx) = steps(:,:,idx(i)).' - stepAverages;
    end
end

function [lowIdx, highIdx] = findVarExtremes(steps, percentiles)
    vars = zeros(size(steps, 2), size(steps, 3));
    %loop through muscles
    for i = 1:size(steps, 2)
        %loop through steps
        for j = 1:size(steps, 3)
            vars(i,j) = var(steps(:,i,j));
        end
    end   
    avgVars = mean(vars, 1);
    cutoffs = prctile(avgVars, percentiles);
    lowIdx = find(avgVars <= cutoffs(1));
    highIdx = find(avgVars >= cutoffs(2));
end


function [filteredEmg] = filterEmg(rawEmg, SAMP_FREQ)

    %filter - LPF/HPF
    [B,A] = butter(2, 50/SAMP_FREQ*2, 'high');
    [D,C] = butter(2, 20/SAMP_FREQ*2, 'low');
    filteredEmg = zeros(size(rawEmg));
    
    for i = 1:size(rawEmg,2)    
        sig = double(rawEmg(:,i));
        sig(sig > mean(sig) + 15 * std(sig) | sig < mean(sig) - 15 * std(sig)) = mean(sig); %artifact removal
        filteredEmg(:,i) = filtfilt(D, C, abs(filtfilt(B,A,sig)));
    end
    
end


function [stepsConcat, steps] = getStepsConcat(filteredEmg, GOOD_MUSCLES, gait, NORM_STEP_BIN_NUM)
    %split into steps
    stepStarts = gait.fStrike_emgIdx;
    stepStops = gait.fOff_emgIdx;
    stepNum = min(length(stepStarts), length(stepStops));

    %split each step into 100 bins
    steps = zeros(NORM_STEP_BIN_NUM, length(GOOD_MUSCLES), stepNum);
    for i = 1:stepNum
        rawStepStart = stepStarts(i);
        rawStepStop = stepStops(i);

        filteredStep = filteredEmg(rawStepStart:rawStepStop, GOOD_MUSCLES);
        binSize = length(filteredStep) / NORM_STEP_BIN_NUM;

        for j = 1:NORM_STEP_BIN_NUM       
            start = ceil(max((j-1) * binSize,1));
            stop = min(ceil(j * binSize), length(filteredStep));
            steps(j, :, i) = rms(filteredStep(start:stop, :),1);
        end
    end   
    
    %concatenate steps
    stepsConcat = zeros(size(steps,2),size(steps,1)*size(steps,3));
    for i = 1:size(steps,3)
        startIdx = (i-1) * 100 + 1;
        stopIdx = i * 100;
        stepsConcat(:,startIdx : stopIdx) = steps(:,:,i).';
    end
end


function [stepResidualsConcat] = getStepResidualsConcat(stepsConcat, steps)
    % compute residuals - subtract step average from each step
    figure
    hold on
    
    stepAverage = mean(steps, 3).';
    stepResidualsConcat = zeros(size(stepsConcat));
    for i = 1:size(steps,3)
        startIdx = (i-1) * 100 + 1;
        stopIdx = i * 100;
        thisStep = stepsConcat(:,startIdx:stopIdx);
        thisStepRes = thisStep - stepAverage;
        plot(thisStepRes(1,:))
        stepResidualsConcat(:,startIdx:stopIdx) = thisStep - stepAverage;
    end
end


function [] = plotSynNumVsCorr(icapcaStruct, saveDir)
    xStart = 2;
    xEnd = length(icapcaStruct.avgR.reg) - 2;

    figure
    scatter(xStart:xEnd, icapcaStruct.avgR.reg(xStart - 1: xEnd - 1), 'k', 'MarkerFaceColor', 'k')
    hold on
    scatter(xStart:xEnd, icapcaStruct.avgR.res(xStart - 1: xEnd - 1), 'c', 'MarkerFaceColor', 'c')
    scatter(xStart:xEnd, icapcaStruct.avgR.com(xStart - 1: xEnd - 1), 'r', 'MarkerFaceColor', 'r')
    scatter(xStart:xEnd, icapcaStruct.avgR.regRes(xStart - 1: xEnd - 1), 'b', 'MarkerFaceColor', 'b')
    scatter(xStart:xEnd, icapcaStruct.avgR.resReg(xStart - 1: xEnd - 1), 'm', 'MarkerFaceColor', 'm')
    title('ICAPCA')
    ylabel('corrCoef')
    xlabel('# of Synergies')
    set(gca, 'TickDir', 'out')
    lgd = legend('whole', 'residual', 'combo', 'whole-residual', 'residual-whole');
    set(lgd, 'FontSize', 16)
    set(lgd, 'Location', 'Southeast')
    legend boxoff
    
    cd(saveDir)
    print('synNumVsCorr', '-dpdf')
    
end


%% Examine basis for most plausible number of syns - should we identify these automatically from slope changes?
function [] = plotSubspaces(stepsConcat, stepResidualsConcat, synNums, labels, saveDir)
    for synNum = synNums
        [weights_whole, sphere_whole] = runica(stepsConcat, 'pca', synNum);
        basisICAPCA.whole = (weights_whole * sphere_whole).';

        [weights_residual, sphere_residual] = runica(stepResidualsConcat, 'pca', synNum);
        basisICAPCA.residual = (weights_residual * sphere_residual).';

        basisICAPCA = sortW(basisICAPCA);

        plotSubspaceCompare(basisICAPCA, '', labels, saveDir);
    end
end

%% Variability & Subspace Similarity
function [] = variabilityVsSubspaceSimilarity(stepsConcat, stepResidualsConcat, t_emg)

    % split data into 30 second chunks
    stretchLength = 45;
    synNum = 4;
    numOfStretches = floor(t_emg(end) / stretchLength);
    avgVar = zeros(numOfStretches, 1); avgAng = zeros(numOfStretches, 1);
    for i = 1:numOfStretches
        startIdx = stretchLength * (i - 1) + 1;
        stopIdx = stretchLength * i;
        stretch.whole = stepsConcat(:,startIdx:stopIdx);
        stretch.residual = stepResidualsConcat(:,startIdx:stopIdx);

        [weights_whole, sphere_whole] = runica(stretch.whole, 'pca', synNum);
        basisICAPCA.whole = (weights_whole * sphere_whole).';

        [weights_residual, sphere_residual] = runica(stretch.residual, 'pca', synNum);
        basisICAPCA.residual = (weights_residual * sphere_residual).';

        basisICAPCA = sortW(basisICAPCA);

        %calculate average variance of stretch
        sumVar = 0;
        for j = 1:size(stepsConcat,1), sumVar = sumVar + var(stretch.whole(j,:)); end
        avgVar(i) = sumVar / size(stepsConcat,1);

        %calculate average angle between paired vectors
        sumAng = 0;
        for j = 1:synNum, sumAng = sumAng + subspace(basisICAPCA.whole(:,j), basisICAPCA.residual(:,j)); end
        avgAng(i) = sumAng / synNum;
        %plotSubspaceCompare(basisICAPCA, [num2str(i) '; VAR: ' num2str(avgVar)], labels);
    end
end