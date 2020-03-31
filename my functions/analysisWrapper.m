cd('/Users/josephinewallner/Desktop/LabWork/Muscle Synergies')
load('fileList.mat')

addpath('/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/FastICA_25')
addpath('/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/eeglab2019_0')
addpath('/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/my functions')
addpath('/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/eeglab2019_0/functions/sigprocfunc')


for i = [4 6 8 9 11 12 13 14 15]
%for i = [4 6 8 9]
%for i = 8
    fileName = meta{i};
    nameParts = strsplit(fileName, '_');
    rat = nameParts{1};
    
    %saveDir = ['/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/Josie/processed_decorrelatedResiduals/' rat];
    %saveDir = ['/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/Josie/processed_stepScramble/' rat];
    %saveDir = ['/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/Josie/processed_meanPredictions/' rat];
    %saveDir = ['/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/Josie/processed/subspaceDiff' rat];
    %saveDir = ['/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/Josie/processed/' rat];
    %saveDir = ['/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/Josie/processed_FA_20200207/' rat];
    saveDir = ['/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/Josie/processed_FA_varimax/' rat];
    %saveDir = ['/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/Josie/processed_stepScramble_FA/' rat];
    %saveDir = ['/Users/josephinewallner/Desktop/LabWork/Muscle Synergies/Josie/processed_meanPredictions_FA/' rat];

    mkdir(saveDir)
    
    %analysisDecorrelated(fileName, saveDir)
    %analysisVariance(fileName, saveDir)
    analysis(fileName, saveDir);
    %analysisStepScramble(fileName, saveDir)
    
    close all
end