% Helper functions for 
%
% Josephine Wallner March 27, 2019

function [r, avgCorr] = getCorrCoeff(modelData, builtData)
    
    sum = 0;
       
    rAll = cell(size(modelData, 1), 1);
    r = zeros(size(modelData, 1), 1);
    for i = 1:size(modelData,1)
        rAll{i} = corrcoef(builtData(i,:), modelData(i,:));
        sum = sum + rAll{i}(1,2);
        r(i) = rAll{i}(1,2);
    end
    
    avgCorr = sum / size(builtData, 1);
    
    
end