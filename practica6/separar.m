% Dado el conjunto de datos completo, el porcentaje de datos que se quieren
% usar como datos de entrenamiento, las columnas de los atributos y las
% columnas de las salidas esperadas, devuelve el conjunto de datos de
% entrenamiento con sus salidas esperadas y el conjunto de datos de
% validación con sus salidas esperadas.
function [Xtr, Ytr, Xtst, Ytst] = separar(data, porc, col_x, col_y)
    % Realiza una permutación de los datos para que se escojan de manera 
    % aleatoria.
    randOrd = randperm(size(data,1)); 
    perm = data( randOrd,:);
    % Establece el límite entre los datos de entrenamiento y los de
    % validación.
    lim = int32(size(data,1)*porc);
    Xtr = perm((1:lim),col_x);
    Ytr = perm(1:lim,col_y);
    Xtst = perm(lim+1:end,col_x);
    Ytst = perm(lim+1:end, col_y);
end