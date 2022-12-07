% Devuelve en Xm los centroides principales.
% Se eligen k centroides (uno para cada cluster)
% Los centroides elegidos son muestras del conjunto de datos que estan
% separados entre sí a igual distancia
function Xm = inicializarCentroides(data, k)
    % Se ordenan los datos de forma ascendente y se quitan los datos
    % repetidos para evitar que un color tenga mas posibilidades de salir
    % en dos centroides iniciales
    X = sort(unique(data,'rows'),'ascend');
    m = size(X,1);
    % El primer centroide corresponde con el pixel que aparece primero en
    % la lista ordenada
    Xm = [X(1,:)];
    % Se eligen el resto de muestras que van a actuar de centroides
    % iniciales de manera que se encuentren a la misma distancia.
    for i = 1:(k-1)
        Xm = [Xm ; X(int32(m*i/(k-1)),:)];
    end
end