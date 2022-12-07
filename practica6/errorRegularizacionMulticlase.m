% Dada la entrada, la salida esperada y el modelo, devuelve la
% media de casos erroneos que se obtienen.
function err = errorRegularizacionMulticlase(X,y,t)
    % Calcula la prediccion obtenida con la matriz de pesos
    ypred = clasificacionBayesiana(t,X);
    % Se suma la cantidad de filas que son distntas de las que hay en el
    % vector de salidas esperadas, y se calcula la media de error.
    err = sum(y ~= ypred) / size(y,1);
end