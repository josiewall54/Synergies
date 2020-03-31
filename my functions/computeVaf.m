function [vaf] = computeVaf(y, yHat)

    y = y - mean(y);
    yHat = yHat - mean(yHat);
    vaf = 1 - (sum((y - yHat).^2) / sum(y.^2));  
    
end