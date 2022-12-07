% Dado el conjunto de datos de entrada, las salidas esperadas, el parametro
% de regularizacion y la cantidad de clases, devuelve la matriz de pesos
% para predecir cada una de las clases.
function t = entrenaRegularizacionMulticase(X,y,lambda,clases)
    % Establece los parámetros de la funcion minFunc
    options = [];
    options.display = 'final';
    options.methos = 'lbfgs';
    % Establece el vector inicial de pesos
    theta_ini = zeros(size(X,2),1);
    t = [];
    % para cada una de las clases, añade a la matriz de pesos, los pesos
    % obtenidos para la clase i
    for i = 1 : clases
        t = [t minFunc(@CosteLogReg, theta_ini, options, X, (y == i), lambda)];
    end
end
