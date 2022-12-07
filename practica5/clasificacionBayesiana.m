% Dado el modelo y los datos de entrada, devuelve la clase predicha para
% cada muestra.
function yhat = clasificacionBayesiana(modelo, X)
% Con los modelos entrenados, predice la clase para cada muestra X
    y = [];
    for i=1:10
        % Calcula la verosimilitud de las muestras para una clase.
        y = [y gaussLog(modelo(i).mu, modelo(i).Sigma,X)];
        % Probabilidad a posteriori
        y(:,i) = y(:,i).*(modelo(i).N/size(X,1));
    end
    % Clase predicha
    [~,yhat] = max(y,[],2);
end