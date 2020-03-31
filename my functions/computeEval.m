function [avgR, rAll, builtData] = computeEval(modelData, testData, alg)
   
    avgR = struct; rAll = struct;
    if strcmp(alg, 'fastica')
        for i = 1:8

            [builtData.reg{i}, builtData.res{i}, builtData.com{i}, builtData.regRes{i}, builtData.resReg{i}] ...
                = buildData(modelData, testData, i+1, alg);
            
            avgR = updateAvgR(avgR, rAll, builtData, testData, i);

        end
    elseif strcmp(alg, 'pca')
        
        [~, scores_whole] = pca(modelData.whole, 'Centered', false);
        [~, scores_residual] = pca(modelData.residual, 'Centered', false);
        [~, scores_combo] = pca(modelData.combo, 'Centered', false);
        
        for i = 1:8
            
            numPC = i + 1;
            
            builtData.reg{i} = scores_whole(:, 1:numPC) * mldivide(scores_whole(:, 1:numPC), testData.whole);
            builtData.res{i} = scores_residual(:, 1:numPC) * mldivide(scores_residual(:, 1:numPC), testData.residual);
            builtData.com{i} = scores_combo(:, 1:numPC) * mldivide(scores_combo(:, 1:numPC), testData.combo);
            builtData.regRes{i} = scores_whole(:, 1:numPC) * mldivide(scores_whole(:, 1:numPC), testData.residual);
            builtData.resReg{i} = scores_residual(:, 1:numPC) * mldivide(scores_residual(:, 1:numPC), testData.whole);
            
            avgR = updateAvgR(avgR, rAll, builtData, testData, i);
              
        end
    elseif strcmp(alg, 'icapca')
        for i = 1:size(modelData.whole,1) - 2
             
            %numPC = i+1;
            numPC = i;
            
            [weights_whole, sphere_whole, ~] = runica(modelData.whole, 'pca', numPC);
            [weights_residual, sphere_residual, ~] = runica(modelData.residual, 'pca', numPC);
            [weights_combo, sphere_combo, ~] = runica(modelData.combo, 'pca', numPC);

%           %scramble synergies - only use for computing "chance" values;            
%             weights_whole = shuffle(weights_whole, 2);
%             weights_residual = shuffle(weights_residual, 2);            
            
            basis_whole = weights_whole * sphere_whole;
            basis_residual = weights_residual * sphere_residual;
            basis_combo = weights_combo * sphere_combo;
            
%             %zero any negative values - sanity check for synergy scrambling
%             %control
%             basis_whole(basis_whole < 0) = 0;
%             basis_residual(basis_residual < 0) = 0;
%             
%             %scramble synergies - only use for computing "chance" values;
%             basis_whole = shuffle(basis_whole, 2);
%             basis_residual = shuffle(basis_residual, 2);
            
            builtData.reg{i} = basis_whole.' * mldivide(basis_whole.', testData.whole);
            builtData.res{i} = basis_residual.' * mldivide(basis_residual.', testData.residual);
            builtData.com{i} = basis_combo.' * mldivide(basis_combo.', testData.combo);
            builtData.regRes{i} = basis_whole.' * mldivide(basis_whole.', testData.residual);
            builtData.resReg{i} = basis_residual.' * mldivide(basis_residual.', testData.whole);
            builtData.comReg{i} = basis_combo.' * mldivide(basis_combo.', testData.combo);
            builtData.comRes{i} = basis_combo.' * mldivide(basis_combo.', testData.combo);
            
            avgR = updateAvgR(avgR, rAll, builtData, testData, i);
        end
    elseif strcmp(alg, 'fa')
        for i = 1:size(modelData.whole,1) - 5
            
            numPC = i;
            
            modelData.whole = modelData.whole;
            modelData.residual = modelData.residual;
            modelData.combo = modelData.combo;
            
            [lambda_whole, ~, ~] = factoran(modelData.whole.', numPC, 'rotate', 'varimax');
            [lambda_residual, ~, ~] = factoran(modelData.residual.', numPC, 'rotate', 'varimax');
            [lambda_combo, ~, ~] = factoran(modelData.combo.', numPC, 'rotate', 'varimax');
            
            builtData.reg{i} = lambda_whole * mldivide(lambda_whole, testData.whole);
            builtData.res{i} = lambda_residual * mldivide(lambda_residual, testData.residual) ;
            builtData.com{i} = lambda_combo * mldivide(lambda_combo, testData.combo);
            builtData.regRes{i} = lambda_whole * mldivide(lambda_whole, testData.residual);
            builtData.resReg{i} = lambda_residual * mldivide(lambda_residual, testData.whole);
            builtData.comReg{i} = lambda_combo * mldivide(lambda_combo, testData.combo);
            builtData.comRes{i} = lambda_combo * mldivide(lambda_combo, testData.combo);
            
            avgR = updateAvgR(avgR, rAll, builtData, testData, i);
        end
        
    else
        error('Algorithm has not been configured')
    end
end



function [bdReg, bdRes, bdCom, bdRegRes, bdResReg] = buildData(modelData, testData, numPC, alg)
    if strcmp(alg, 'fastica')
        [icasig_w, A_w, W_w] = fastica(modelData.whole, 'numOfIC', numPC);
        [icasig_r, A_r, W_r] = fastica(modelData.residual, 'numOfIC', numPC);
        [icasig_c, A_c, W_c] = fastica(modelData.combo, 'numOfIC', numPC);

        bdReg = W_w.' * mldivide(W_w.', testData.whole);
        bdRes = W_r.' * mldivide(W_r.', testData.residual);
        bdCom = W_c.' * mldivide(W_c.', testData.combo);
        bdRegRes = W_w.' * mldivide(W_w.', testData.residual);
        bdResReg = W_r.' * mldivide(W_r.', testData.whole);     
    else
        error('Algorithm has not been configured');
    end
    
end

function [avgR, rAll] = updateAvgR(avgR, rAll, builtData, testData, idx)
    sumRegR = 0;
    sumResR = 0;
    sumComR = 0;
    sumRegResR = 0;
    sumResRegR = 0;
    sumComRegR = 0;
    sumComResR = 0;

    for j = 1:size(builtData.reg{idx},1)
%         rAll.reg{idx,j} = corrcoef(testData.whole(j,:), builtData.reg{idx}(j,:));
%         rAll.res{idx,j} = corrcoef(testData.residual(j,:), builtData.res{idx}(j,:));
%         rAll.com{idx,j} = corrcoef(testData.combo(j,:), builtData.com{idx}(j,:));
%         rAll.regRes{idx,j} = corrcoef(testData.residual(j,:), builtData.regRes{idx}(j,:));
%         rAll.resReg{idx,j} = corrcoef(testData.whole(j,:), builtData.resReg{idx}(j,:));
%         rAll.comReg{idx,j} = corrcoef(testData.combo(j,1:length(testData.combo) / 2), builtData.com{idx}(j,1:length(testData.combo) / 2));
%         rAll.comRes{idx,j} = corrcoef(testData.combo(j,length(testData.combo) / 2 + 1:end), builtData.com{idx}(j,length(testData.combo) / 2 + 1:end));
        
%         rAll.reg{idx,j} = max(0, computeVaf(testData.whole(j,:), builtData.reg{idx}(j,:)));
%         rAll.res{idx,j} = max(0, computeVaf(testData.residual(j,:), builtData.res{idx}(j,:)));
%         rAll.com{idx,j} = max(0, computeVaf(testData.combo(j,:), builtData.com{idx}(j,:)));
%         rAll.regRes{idx,j} = max(0, computeVaf(testData.residual(j,:), builtData.regRes{idx}(j,:)));
%         rAll.resReg{idx,j} = max(0, computeVaf(testData.whole(j,:), builtData.resReg{idx}(j,:)));
%         rAll.comReg{idx,j} = max(0, computeVaf(testData.combo(j,1:length(testData.combo) / 2), builtData.com{idx}(j,1:length(testData.combo) / 2)));
%         rAll.comRes{idx,j} = max(0, computeVaf(testData.combo(j,length(testData.combo) / 2 + 1:end), builtData.com{idx}(j,length(testData.combo) / 2 + 1:end)));

        rAll.reg{idx,j} = computeVaf(testData.whole(j,:), builtData.reg{idx}(j,:));
        rAll.res{idx,j} = computeVaf(testData.residual(j,:), builtData.res{idx}(j,:));
        rAll.com{idx,j} = computeVaf(testData.combo(j,:), builtData.com{idx}(j,:));
        rAll.regRes{idx,j} = computeVaf(testData.residual(j,:), builtData.regRes{idx}(j,:));
        rAll.resReg{idx,j} = computeVaf(testData.whole(j,:), builtData.resReg{idx}(j,:));
        rAll.comReg{idx,j} = computeVaf(testData.combo(j,1:length(testData.combo) / 2), builtData.com{idx}(j,1:length(testData.combo) / 2));
        rAll.comRes{idx,j} = computeVaf(testData.combo(j,length(testData.combo) / 2 + 1:end), builtData.com{idx}(j,length(testData.combo) / 2 + 1:end));

%         sumRegR = sumRegR + rAll.reg{idx,j}(2);
%         sumResR = sumResR + rAll.res{idx,j}(2);
%         sumComR = sumComR + rAll.com{idx,j}(2);
%         sumRegResR = sumRegResR + rAll.regRes{idx,j}(2);
%         sumResRegR = sumResRegR + rAll.resReg{idx,j}(2);   
%         sumComRegR = sumComRegR + rAll.comReg{idx,j}(2);
%         sumComResR = sumComResR + rAll.comRes{idx,j}(2);
        
        sumRegR = sumRegR + rAll.reg{idx,j};
        sumResR = sumResR + rAll.res{idx,j};
        sumComR = sumComR + rAll.com{idx,j};
        sumRegResR = sumRegResR + rAll.regRes{idx,j};
        sumResRegR = sumResRegR + rAll.resReg{idx,j};   
        sumComRegR = sumComRegR + rAll.comReg{idx,j};
        sumComResR = sumComResR + rAll.comRes{idx,j};
    end

    avgR.reg(idx) = sumRegR / size(builtData.reg{idx}, 1);
    avgR.res(idx) = sumResR / size(builtData.res{idx}, 1);
    avgR.com(idx) = sumComR / size(builtData.com{idx}, 1);
    avgR.regRes(idx) = sumRegResR / size(builtData.regRes{idx}, 1);
    avgR.resReg(idx) = sumResRegR / size(builtData.resReg{idx}, 1);
    avgR.comReg(idx) = sumComRegR / size(builtData.resReg{idx}, 1);
    avgR.comRes(idx) = sumComResR / size(builtData.resReg{idx}, 1);
end