function h = errorExpansion(h,X,y,model)
    xp = expandir(X,model);
    h = RMSE(h,xp,y);
end