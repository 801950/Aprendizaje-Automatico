function err = errorRegularizacion(theta, X, y, model)
    Ypred =  1./(1+exp(-(X*theta))) >= 0.5 ;
    err = sum(Ypred ~= y) / size(y,1);
end