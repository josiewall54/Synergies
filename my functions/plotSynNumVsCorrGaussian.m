function [] = plotSynNumVsCorrGaussian(icapcaStruct, saveDir)
    xStart = 2;
    xEnd = length(icapcaStruct.avgR.reg) - 2;

    figure
    scatter(xStart:xEnd, icapcaStruct.avgR.reg(xStart - 1: xEnd - 1), 'k', 'MarkerFaceColor', 'k')
    hold on
    scatter(xStart:xEnd, icapcaStruct.avgR.res(xStart - 1: xEnd - 1), 'c', 'MarkerFaceColor', 'c')
    scatter(xStart:xEnd, icapcaStruct.avgR.com(xStart - 1: xEnd - 1), 'r', 'MarkerFaceColor', 'r')
    scatter(xStart:xEnd, icapcaStruct.avgR.regRes(xStart - 1: xEnd - 1), 'b', 'MarkerFaceColor', 'b')
    scatter(xStart:xEnd, icapcaStruct.avgR.resReg(xStart - 1: xEnd - 1), 'm', 'MarkerFaceColor', 'm')
    title('ICAPCA')
    ylabel('VAF')
    xlabel('Number of Synergies')
    set(gca, 'TickDir', 'out')
    lgd = legend('whole', 'residual', 'combo', 'whole-residual', 'residual-whole');
    set(lgd, 'FontSize', 16)
    set(lgd, 'Location', 'Southeast')
    legend boxoff
    
    cd(saveDir)
    print('synNumVsCorr', '-dpdf')
    
end