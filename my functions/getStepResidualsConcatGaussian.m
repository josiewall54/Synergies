function stepResidualsConcat = getStepResidualsConcatGaussian(stepsConcat)
    
    stepCount = length(stepsConcat) / 100;
    muscleCount = size(stepsConcat, 1);

    %convert steps into tensor
    steps = zeros(muscleCount, 100, stepCount);
    for i = 1:size(steps, 3)
        startIdx = (i - 1) * size(steps, 2) + 1;
        stopIdx = i * size(steps, 2);
        steps(:,:,i) = stepsConcat(:, startIdx:stopIdx);
    end
    stepAverages = mean(steps, 3);
    
    stepResidualsConcat = zeros(size(stepsConcat));
    for i = 1:size(steps, 3)
        startIdx = (i - 1) * size(steps, 2) + 1;
        stopIdx = i * size(steps, 2);
        thisResidual = steps(:,:,i) - stepAverages;
        stepResidualsConcat(:,startIdx:stopIdx) = thisResidual;
    end
    
end