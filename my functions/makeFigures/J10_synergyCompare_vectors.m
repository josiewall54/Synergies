%re-arranging synergy comparison plot for J8, 5 syns.
%grouping muscles anatomically, and flipping negatively correlated
%synergies

resColor = 'b';
%resColor = [.31 .45 .51];

%anatomically order synergies
%newOrdering = [1 2 8 9 4 6 10 5 12 11 3 7]; %this is from J8 - need to update for J10's muscle ordering!
%newOrdering = [3 2 4 6 9 1 10 5 8 7]; %this is for J10
%newOrdering = [7 2 8 10 1 9 4 11 5 3 6]; %J12
newOrdering = [9 2 4 6 10 1 11 5 7 3 8]; %J13

newBasis.whole = basis.whole(newOrdering, :);
newBasis.residual = basis.residual(newOrdering, :);


f = figure;
synNum = size(basis.whole, 2);

for i = 1:synNum
    h = subplot(2,synNum, i);
    %if(i == 3 || i == 4)
    if (3 == 4)
        bar(newBasis.whole(:,i).*-1, 'FaceColor', 'k', 'EdgeColor', 'k')
    else
        bar(newBasis.whole(:,i), 'FaceColor','k','EdgeColor', 'k')
    end
    set(h, 'XTickLabel', labels)
    set(h, 'XTickLabelRotation', 45)
    box off
    set(gca, 'Color', 'none', 'XColor', 'none', 'YColor', 'none')

    g = subplot(2,synNum, i + synNum);
    %if(i == 1 || i == 3)
    if (3 == 4)
        bar(newBasis.residual(:,i).*-1, 'FaceColor', resColor, 'EdgeColor', resColor)
    else
        bar(newBasis.residual(:,i), 'FaceColor',resColor,'EdgeColor', resColor)
    end
    set(g, 'XTickLabel', labels)
    set(g, 'XTickLabelRotation', 45)
    box off
    set(gca, 'Color', 'none', 'XColor', 'none', 'YColor', 'none')
end