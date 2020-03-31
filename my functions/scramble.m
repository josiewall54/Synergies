function scrambled = scramble(unscrambled)

    scrambled = zeros(size(unscrambled));
    
    %iterate through each synergy
    for i = 1:size(scrambled, 1)      
        synLen = size(unscrambled, 2);
        
        %loop through each weight in this synergy
        for j = 1:synLen
            otherIdx = setdiff(1:synLen, j);       
            swapIdx = randperm(synLen - 1, 1);
            scrambled(i, j) = unscrambled(i, otherIdx(swapIdx));
        end
    end