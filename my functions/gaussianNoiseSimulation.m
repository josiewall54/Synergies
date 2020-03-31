%% Synthesize signals with gaussian noise

% 1. Take the average emg step
%
% 2. Concatenate emg steps to create signal of same length
%
% 3. For each timestamp, draw randomely from guassian distribution and add to sig
%       a. take distribution stats from real noise
%
% 4. Run new signal through synergy analysis (hopefully we don't see anything..)

%% Synthesize steps and residuals

cd('/Users/josephinewallner/Desktop/LabWork/Muscle Synergies')
load('stepAvgsJ8.mat')
%load('residualVariance.mat')
load('timeStepVarJ8.mat')

%% create stepsConcat
stepCount = 338;

stepsConcat = stepAverage;
for i = 1:stepCount - 1
    stepsConcat = horzcat(stepsConcat, stepAverage);
end

avgOnly = stepsConcat;

%% add gaussian white noise
% for i = 1:size(stepsConcat, 1)
%     sigma = resVarJ8(i); %variance of the real residuals
%     noise = randn(length(stepsConcat), 1) * sqrt(sigma);
%     stepsConcat(i,:) = stepsConcat(i,:) + noise.';
% end

%% add signal-dependent noise
for i = 1:12 %loop through muscles
    noiseVar = timeStepVar{i};
    for j = 1:100 %get indices for the same noise distribution
       noise = randn(338, 1) * sqrt(noiseVar(j));
       for k = 1:338
           stepsConcat(i, (k - 1) * 100 + j) = stepsConcat(i, (k - 1) * 100 + j) + noise(k);
       end
    end
end

% chop off negatives
stepsConcat(stepsConcat < 0) = 0;

%% create stepsResiduals
stepResidualsConcat = getStepResidualsConcatGaussian(stepsConcat);

BUILD_PROP = 0.8;
saveDir = '/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/gaussianSimJ8/meanPredictions';
[icapcaStruct.avgR, icapcaStruct.avgRFolds, icapcaStruct.rAll, icapcaStruct.builtData] = ...
    computeEvalWrapper(avgOnly, stepResidualsConcat, BUILD_PROP, 'icapca');   
plotSynNumVsCorrGaussian(icapcaStruct, saveDir)

labels = {'GA', 'TA', 'GS', 'VI', 'BFpc', 'VL', 'IL', 'RF', 'VM', 'GRr', 'SM', 'ST'};

%plotSubspacesGaussian(stepsConcat, stepResidualsConcat, 2:4, labels, saveDir)
        

