function t = entrenaRegularizacion(lambda,X,y)
    options = [];
    options.display = 'final'; %otros: 'iter' , 'none‘
    options.method = 'newton'; %por defecto: 'lbfgs'
    theta_ini = zeros(size(X,2),1);
    t = minFunc(@CosteLogReg, theta_ini, options,X, y, lambda);
end