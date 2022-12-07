% Acutualiza las etiquetas del cluster al que pertenece cada muestra
% Dadas las muestras de entrada y los centroides de cada cluster, devuelve
% en Z el índice del cluster al que pertenece cada muestra.
% Una muestra se asigna a un cluster si el centroide de dicho cluster es el
% que está a menor distancia.
% Se define la distancia como la norma del vector entre la muestra y el
% centroide al cuadrado.
function Z = updateClusters(D,mu)
% D(m,n), m datapoints, n dimensions
% mu(K,n) final centroids
%
% c(m) assignment of each datapoint to a class
    K = size(mu,1);
    m = size(D,1);
    % Guarda en la columna i, las distancias de cada muestra al cluster i
    distancia = [];
    for i = 1:K % dsearch
        distancia = [distancia sum((D-mu(i,:)).^2,2)];
    end
    % Devuelve los clusters que están a menor distancia
    [~, Z] = min(distancia,[],2);
end
