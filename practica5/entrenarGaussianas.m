% Dados los atributos de entrada, la salida esperada, la cantidad de clases
% que se quieren predecir, si se quiere usar bayes ingenuo o no y el
% parametro de regulariación que se quiere usar.
% Devuelve el modelo para realizar el entrenamiento.
function modelo = entrenarGaussianas( Xtr, ytr, nc, NaiveBayes, landa )
% Entrena una Gaussiana para cada clase y devuelve:
% modelo{i}.N     : Numero de muestras de la clase i
% modelo{i}.mu    : Media de la clase i
% modelo{i}.Sigma : Covarianza de la clase i
% Si NaiveBayes = 1, las matrices de Covarianza seran diagonales
% Se regularizaran las covarianzas mediante: Sigma = Sigma + landa*eye(D)
modelo = struct('N',{},'mu',{},'Sigma',{});
    for i = 1:nc
        % Cantidad de muestras que hay de esa clase
        modelo(i).N = sum(ytr == i);
        % Guarda las muestras de la clase i en Xp
        Xp = Xtr(ytr == i,:);
        % Media para la clase i
        modelo(i).mu = mean(Xp);
        % Matriz de covarianza
        modelo(i).Sigma = cov(Xp);
        modelo(i).Sigma = modelo(i).Sigma + landa * eye(size(Xp,2));
        % Si se quiere usar Bayes ingenuo se queda con la matriz diagonal de
        % covarianzas.
        if NaiveBayes == 1 
            modelo(i).Sigma = diag(diag(modelo(i).Sigma));
        end
    end
end

