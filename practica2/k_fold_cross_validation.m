function [H, errT, errV] = k_fold_cross_validation(k, func, X, y, models, funcErr)
    bestModel = 0;
    bestErrV = inf;
    errT = [];
    errV = [];
    for model = 1:size(models,1)
        err_T = 0;
        err_V = 0;
        for fold = 1:k
            [x_tsset, y_tsset, x_trset, y_trset] = particion(fold,k,X,y);
            th = func(models(model,:),x_trset,y_trset);
            err_T = err_T + funcErr(th,x_trset,y_trset,models(model,:));
            err_V = err_V + funcErr(th, x_tsset, y_tsset,models(model,:));
        end
        err_T = err_T / k;
        err_V = err_V / k;
        errT = [errT err_T];
        errV = [errV err_V];
        if err_V < bestErrV 
            bestModel = model;
            bestErrV = err_V;
        end
    end
    H = bestModel;
end