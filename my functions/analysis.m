function [] = analysis(file, saveDir)
    
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
    stepResidualsConcat = getStepResidualsConcat(stepsConcat, steps);
   
    
%----------------------- FA ------------------------------------------------------------

%     %only use this line for mean predictions-FA
%     stepsConcat = stepsConcat - stepResidualsConcat;

    %zero-mean (only use for FA)
    zeroedStepsConcat = stepsConcat - ones(size(stepsConcat)) .* mean(stepsConcat, 2);
    zeroedStepResidualsConcat = stepResidualsConcat - ones(size(stepResidualsConcat)) .* mean(stepResidualsConcat, 2);
    
    %whiten (only use for FA)
    whiteStepsConcat = ((zeroedStepsConcat.') ./ repmat(sqrt(var(zeroedStepsConcat.')), size(zeroedStepsConcat, 2), 1)).';
    whiteStepResidualsConcat = ((zeroedStepResidualsConcat.') ./ repmat(sqrt(var(zeroedStepResidualsConcat.')), size(zeroedStepResidualsConcat, 2), 1)).';
    

    [faStruct.avgR, faStruct.avgFolds, faStruct.rAll, faStruct.builtData] = ...
       computeEvalWrapper(whiteStepsConcat, whiteStepResidualsConcat, BUILD_PROP, 'fa');
    plotSynNumVsCorr(faStruct, saveDir)
    %plotSubspacesFA(whiteStepsConcat, whiteStepResidualsConcat, 4, labels, saveDir)
    
%-------------------------------------------------------------------------------------------



%----------------------- ICAPCA ------------------------------------------------------------
    
%     % Generate synNum vs. corr scatter
%     [icapcaStruct.avgR, icapcaStruct.avgRFolds, icapcaStruct.rAll, icapcaStruct.builtData] = ...
%         computeEvalWrapper(stepsConcat, stepResidualsConcat, BUILD_PROP, 'icapca');
     
%     %Replace whole with mean to check how well the residual can predict it
%     stepAveragesConcat = stepsConcat - stepResidualsConcat;
%     [icapcaStruct.avgR, icapcaStruct.avgRFolds, icapcaStruct.rAll, icapcaStruct.builtData] = ...
%         computeEvalWrapper(stepAveragesConcat, stepResidualsConcat, BUILD_PROP, 'icapca');   
    %plotSynNumVsCorr(icapcaStruct, saveDir)
    
%     plotSubspaces(stepsConcat, stepResidualsConcat, 4:5, labels, saveDir)
    
%-------------------------------------------------------------------------------------------

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
    xStart = 1;
    xEnd = length(icapcaStruct.avgR.reg) - 2;

    figure
    hold on
    
    scatter(xStart:xEnd, icapcaStruct.avgR.reg(xStart: xEnd), 30, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
    scatter(xStart:xEnd, icapcaStruct.avgR.res(xStart: xEnd), 30, 'MarkerFaceColor', 'c', 'MarkerEdgeColor', 'c')
    %scatter(xStart:xEnd, icapcaStruct.avgR.com(xStart: xEnd - 1), 'r', 'MarkerFaceColor', 'r')
    %scatter(xStart:xEnd, icapcaStruct.avgR.regRes(xStart: xEnd - 1), 'b', 'MarkerFaceColor', 'b')
    scatter(xStart:xEnd, icapcaStruct.avgR.resReg(xStart: xEnd), 30, 'MarkerEdgeColor', [.31, .45, .51], 'MarkerFaceColor', [.31, .45, .51])
    title('ICAPCA')
    ylabel('VAF')
    xlabel('Number of Synergies')
    set(gca, 'TickDir', 'out', 'FontSize', 14)
    %ylim([0 1])
    %yticks(0:0.2:1)
    xlim([1 6])
    %lgd = legend('whole', 'residual', 'combo', 'whole-residual', 'residual-whole');
    lgd = legend('Whole -> whole', 'Residual -> residual', 'Residual -> whole');
    set(lgd, 'FontSize', 16)
    set(lgd, 'Location', 'Southeast')
    legend boxoff
    
    cd(saveDir)
    %print('synNumVsCorr', '-dpdf')
    
end


%% Examine basis for most plausible number of syns - should we identify these automatically from slope changes?
function [] = plotSubspaces(stepsConcat, stepResidualsConcat, synNums, labels, saveDir)
    for synNum = synNums
        [weights_whole, sphere_whole] = runica(stepsConcat, 'pca', synNum);
        basisICAPCA.whole = (weights_whole * sphere_whole).';

        [weights_residual, sphere_residual] = runica(stepResidualsConcat, 'pca', synNum);
        basisICAPCA.residual = (weights_residual * sphere_residual).';

        basisICAPCA = sortW(basisICAPCA);

        %plotSubspaceCompare(basisICAPCA, '', labels, saveDir);
    end
end

%% Subspace compare for FA
function [] = plotSubspacesFA(stepsConcat, stepResidualsConcat, synNums, labels, saveDir)
    for synNum = synNums
        
        [basisFA.whole, ~, ~] = factoran(stepsConcat.', synNum, 'rotate', 'varimax');
        [basisFA.residual, ~, ~] = factoran(stepResidualsConcat.', synNum, 'rotate', 'varimax');    
        
        basisFA = sortW(basisFA);
        
        %plotSubspaceCompare(basisFA, '', labels, saveDir);
        disp('break')
        for i = 1:size(basisFA.whole, 2), disp(num2str(rad2deg(subspace(basisFA.whole(:,i), basisFA.residual(:,i)))));end
 
    end
end

function [] = variabilityVsSubspaceSimilarity(stepsConcat, stepResidualsConcat, t_emg)
    %% Variability & Subspace Similarity
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

% %% Controls
% %don't just do first half and second half - in case something went wrong
% %part way through the trial
% 
% %split into 8 pieces & alternate assignment
% 
% segmentLength = floor(length(stepsConcat) / 8);
% for i = 1:4
%     halfData1 = stepsConcat(:,segmentLength * (2*i - 2) + 1 : segmentLength * (2*i - 1));
%     halfData2 = stepsConcat(:,segmentLength * (2*i - 1) + 1 : segmentLength * 2 * i);
% end
% 
% for synNum = 4
% 
%     [weights_control1, sphere_control1] = runica(halfData1, 'pca', synNum);
%     basisControl.whole = (weights_control1 * sphere_control1).';
%     
%     [weights_control2, sphere_control2] = runica(halfData2, 'pca', synNum);
%     basisControl.residual = (weights_control2 * sphere_control2).';
%     
%     basisControl = sortW(basisControl);
%     
%     plotSubspaceCompare(basisControl, 'ICAPCA - control', labels)
% end

% %% Prediction tracking plots
% goodNames = emg_names(GOOD_MUSCLES);
% 
% figure
% subplot(5,2,1); hold on
% plot(modelData(7,3000:3600), 'k')
% plot(builtDataReg(7,3000:3600), 'r')
% title(goodNames{7})
% ylabel('Best Fits')
% axis tight
% set(gca, 'TickDir', 'out')
% 
% subplot(5,2,2); hold on
% plot(modelData(8, 3000:3600), 'k')
% plot(builtDataReg(8, 3000:3600), 'r')
% title(goodNames{8})
% axis tight
% set(gca, 'TickDir', 'out')
% 
% subplot(5,2,3); hold on
% plot(modelData(3, 3000:3600), 'k')
% plot(builtDataReg(3, 3000:3600), 'r')
% title(goodNames{3})
% ylabel('Worst Fits')
% axis tight
% set(gca, 'TickDir', 'out')
% 
% subplot(5,2,4); hold on
% plot(modelData(9, 3000:3600), 'k')
% plot(builtDataReg(9, 3000:3600), 'r')
% title(goodNames{9})
% axis tight
% set(gca, 'TickDir', 'out')
% 
% 
% subplot(5,2,7); hold on
% plot(stepResidualsConcat(7,3000:3600), 'k')
% plot(builtDataRes(7,3000:3600), 'r')
% title(goodNames{7})
% ylabel('Best Fits')
% axis tight
% set(gca, 'TickDir', 'out')
% 
% subplot(5,2,8); hold on
% plot(stepResidualsConcat(8, 3000:3600), 'k')
% plot(builtDataRes(8, 3000:3600), 'r')
% title(goodNames{8})
% axis tight
% set(gca, 'TickDir', 'out')
% 
% subplot(5,2,9); hold on
% plot(stepResidualsConcat(3, 3000:3600), 'k')
% plot(builtDataRes(3, 3000:3600), 'r')
% title(goodNames{3})
% ylabel('Worst Fits')
% axis tight
% set(gca, 'TickDir', 'out')
% 
% subplot(5,2,10); hold on
% plot(stepResidualsConcat(9, 3000:3600), 'k')
% plot(builtDataRes(9, 3000:3600), 'r')
% title(goodNames{9})
% axis tight
% set(gca, 'TickDir', 'out')


%% Estimate number of synergies
%[fasticaStruct.avgR, fasticaStruct.avgRFolds, fasticaStuct.rAll, fastica.builtData] = computeEvalWrapper(stepsConcat, stepResidualsConcat, BUILD_PROP, 'fastica');

%[pcaStruct.avgR, pcaStr uct.avgRFolds, pcaStruct.rAll, pcaStruct.builtData] = computeEvalWrapper(stepsConcat, stepResidualsConcat, BUILD_PROP, 'pca');

%[fa.avgR, fa.rAll, fa.builtData] = computeEvalWrapper(stepsConcat, stepResidualsConcat, BUILD_PROP, 'fa');

%[icapcaStruct.avgR, icapcaStruct.avgRFolds, icapcaStruct.rAll, icapcaStruct.builtData] = computeEvalWrapper(stepsConcat, stepResidualsConcat, BUILD_PROP, 'icapca');