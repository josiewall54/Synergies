function [] = plotSubspacesGaussian(stepsConcat, stepResidualsConcat, synNums, labels, saveDir)
    for synNum = synNums
        [weights_whole, sphere_whole] = runica(stepsConcat, 'pca', synNum);
        basisICAPCA.whole = (weights_whole * sphere_whole).';

        [weights_residual, sphere_residual] = runica(stepResidualsConcat, 'pca', synNum);
        basisICAPCA.residual = (weights_residual * sphere_residual).';

        basisICAPCA = sortW(basisICAPCA);

        plotSubspaceCompare(basisICAPCA, '', labels, saveDir);
    end
end