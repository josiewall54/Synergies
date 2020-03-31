numOfSteps = 520;
numOfMuscles = 12;
timeStepVar = cell(numOfMuscles,1);
for i = 1:numOfMuscles %for each muscle
    thisMuscle = reshape(steps(:,i,:), [100 numOfSteps]);
    
    thisMuscleVar = zeros(100,1);
    
    for j = 1:100
        thisMuscleVar(j) = var(thisMuscle(j,:));
    end
    
    timeStepVar{i} =  thisMuscleVar;
end