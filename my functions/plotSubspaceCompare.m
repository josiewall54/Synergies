function [] = plotSubspaceCompare(basis, alg, labels, saveDir)

    figure
    synNum = size(basis.whole, 2);
    
    
    for i = 1:synNum
        h = subplot(2,synNum, i);
        bar(basis.whole(:,i), 'FaceColor','k','EdgeColor', 'k')
        %bar(basis.whole(:,i).*-1, 'FaceColor', 'k', 'EdgeColor', 'k')
        set(h, 'XTickLabel', labels)
        set(h, 'XTickLabelRotation', 45)
        box off
        set(gca, 'Color', 'none', 'XColor', 'none', 'YColor', 'none')
     
        g = subplot(2,synNum, i + synNum);
        bar(basis.residual(:,i), 'FaceColor','b','EdgeColor', 'b')
        set(g, 'XTickLabel', labels)
        set(g, 'XTickLabelRotation', 45)
        box off
        set(gca, 'Color', 'none', 'XColor', 'none', 'YColor', 'none')
    end
    
    angleSum = 0;
    for i = 1:synNum
        subplot(2, synNum, synNum + i)
        corr = corrcoef(basis.whole(:,i), basis.residual(:,i));
        angle = subspace(basis.whole(:,i), basis.residual(:,i));
        angleSum = angleSum + angle;
        allAngles(i) = angle;
        xlabel(['Corr: ' num2str(corr(2)) newline 'Angle: ' num2str(rad2deg(angle)) ' deg'], 'FontSize', 14)
    end
    angleAvg = angleSum / synNum;
    
    subplot(2,synNum,ceil(synNum/2)); title([alg '    Avg Angle: ' num2str(angleAvg)])
    box off
    set(gca, 'Color', 'none', 'XColor', 'none', 'YColor', 'none')
    
    if length(alg) > 6      
         if strcmpi(alg(length(alg) - 6:end), 'control')
            subplot(2,synNum,1); ylabel('whole data - first half', 'FontSize', 20)
            subplot(2,synNum,1 + synNum); ylabel('whole data - second half', 'FontSize', 20)
        else
            subplot(2,synNum,1); ylabel('whole', 'FontSize', 20)
            subplot(2,synNum,1 + synNum); ylabel('residual', 'FontSize', 20)
         end
    else
        subplot(2,synNum,1); ylabel('whole', 'FontSize', 20)
        subplot(2,synNum,1 + synNum); ylabel('residual', 'FontSize', 20)
    end
    
    %scramble synergies and compute subspace angles, for negative control
    scrambledAngles = zeros(synNum,20);
    for k = 1:20
        scrambledSynergies = scramble(basis);
        scrambledSynergies = sortW(scrambledSynergies);
        for i = 1:synNum
            scrambledAngles(i, k) = rad2deg(subspace(scrambledSynergies.whole(:,i), scrambledSynergies.residual(:,i)));
        end
    end
    
    angleDeg = rad2deg(allAngles);
    disp(angleDeg)
    disp(num2str(mean(scrambledAngles, 2)))
        
    cd(saveDir)
    %print(['subspaceCompare' num2str(synNum)], '-dpdf')
          
end

function scrambled = scramble(unscrambled)
    scrambled = struct('whole', zeros(size(unscrambled.whole)), 'residual', zeros(size(unscrambled.whole)));

    %iterate through each synergy
    for i = 1:size(unscrambled.whole, 2)
        
            scrambled.whole = shuffle(unscrambled.whole, 1);
            scrambled.residual = shuffle(unscrambled.residual, 1);
        
        %synLen = size(unscrambled.whole, 1);
        %loop through each weight in this synergy
        %for j = 1:size(unscrambled.whole(:,1))

            
            
%             
%             otherIdx = setdiff(1:size(unscrambled.whole,1), j);
%             
%             %scramble whole synergies
%             swapIdx = randperm(synLen - 1, 1);
%             scrambled.whole(j,i) = unscrambled.whole(otherIdx(swapIdx),i);
%           
%             
%             %scramble residual synergies
%             swapIdx = randperm(synLen - 1, 1);
%             scrambled.residual(j,i) = unscrambled.residual(otherIdx(swapIdx),i);
%             
        %end
    
    end
    
    

end