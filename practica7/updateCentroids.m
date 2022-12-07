% Devuelve en munew k filas que contienen los nuevos centroides
% Se actualizan los centroides en función de las muestras que pertenecen a
% ese cluster
% El nuevo centroide es la media de todas las muestras que pertenecen al
% cluster dado
function munew = updateCentroids(D,c,K)
% D((m,n), m datapoints, n dimensions
% c(m) assignment of each datapoint to a class
%
% munew(K,n) new centroids
    munew = [];
    % Para cada uno de los k clusters
    for i=1:K
        % Se obtienen las muestras que pertenecen a ese cluster
        x = D(c==i,:); 
        % Se añade la media de las muestras de ese cluster
        munew = [munew ; mean(x,1)];
    end
end
