%sort by biggest corrcoef

function [sortedW] = sortW(unsortedW)
        
    %create correlation matrix
    synNum = size(unsortedW.whole, 2);
    corr = zeros(synNum);
    for col = 1:synNum
        wholeVec = unsortedW.whole(:,col);        
        for row = 1:synNum
            resVec = unsortedW.residual(:, row);
            tmp = corrcoef(wholeVec, resVec);
            corr(row, col) = abs(tmp(2));
        end
    end
    
    %assign sorted vectors
    for i = 1:synNum
        [a,b] = find(corr == max(max(corr)));
        sortedW.whole(:,i) =  unsortedW.whole(:,b);
        sortedW.residual(:,i) = unsortedW.residual(:,a);
        
        corr(a,:) = -1;
        corr(:,b) = -1;
    end
    
end