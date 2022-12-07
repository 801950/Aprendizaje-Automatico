% Dada la entrada y la matriz de pesos, devuelve la salida predicha.
function ypred = prediccionMulticlase(X,t)
    % Calcula la matriz de predicción para cada clase mediante la funcion
    % sigmoidal.
    yp = 1./(1+exp(-(X*t)));
    % La salida predicha es aquella que ha obtenido una mayor probabilidad
    % en la salida predicha.
    % Se devuelve el indice de la columna que tiene el maximo valor.
    [M, ypred] = max(yp,[],2);
end