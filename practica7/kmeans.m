% Algoritmo de kmeans
% Dados los datos de entrada y los centroides iniciales, devuelve las
% etiquetas de las muestras (a qué cluster pertenecen) y los centroides de
% dichos clusters.
% Realiza iteraaciones en las que se actualizan las etiquetas y los
% centroides hasta que en dos iteraciones consecutivas no varíe la etiqueta
% de ninguna de las muestras
function [mu, c] = kmeans(D,mu0)
% D(m,n), m datapoints, n dimensions
% mu0(K,n) K initial centroids
%
% mu(K,n) final centroids
% c(m) assignment of each datapoint to a class
    c = updateClusters(D,mu0);
    mu = updateCentroids(D,c,size(mu0,1));
    c0 = c*0;
    while sum(c0 ~= c) > 0
        c0 = c;
        c = updateClusters(D,mu);
        mu = updateCentroids(D,c,size(mu0,1));
        %c0 ~= c
    end
end