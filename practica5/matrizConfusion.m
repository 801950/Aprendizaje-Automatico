% Dada la salida predicha, la salida esperada y la cantidad de clases,
% devuelve la matriz de confusión de manera que contiene en las filas la
% clase real y en las columnas, la clase predicha.
function matrizConf = matrizConfusion(ypred,ytest,clases)
    matrizConf = zeros(clases,clases);
    for i = 1: clases
        for j = 1:clases
            matrizConf(i,j) = sum(ytest==i & ypred == j);
        end
    end
end