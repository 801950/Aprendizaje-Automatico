
%% Lab 6.1: PCA 

clear all
close all
rand('state',0);
% load images 
% images size is 20x20. 

load('MNISTdata2.mat'); 

nrows=20;
ncols=20;

nimages = size(X,1);
%% Perform PCA following the instructions of the lab
Xp = normalize(X,'center','mean'); % normalizar los datos respecto de la media

% obtener la matriz de covarianza
sig = cov(Xp);
% obtener los valores y vectores propios
[U,A] = eig(sig);
% ordenar los vectores propios según los valores propios
[A,I] = sort(diag(A),'descend')
U = U(:,I);
lambda = logspace(-6,1,20)';
elegido = 0;
k = 1;
err = 3.5*10^(-2)
elegido = 0
errK = []
while k <= size(X,2) && elegido == 0
    bestModel = 0;
    bestErrV = inf;
    errT = [];
    errV = [];
    naiveBayes = 0;
    Uk = U(:,1:k);
    Z = Xp * Uk;
    [Xtr, Ytr, Xv, Yv] = separar([Z y],0.8,[(1:k)],[k+1]);
    for model = 1:size(lambda,1)
        err_T = 0;
        err_V = 0;
        % se calcula la matriz de pesos
        
        th = entrenarGaussianas(Xtr, Ytr, 10, naiveBayes, lambda(model));
        % se calculan los valores de error
        err_T = errorRegularizacionMulticlase(Xtr,Ytr,th);
        err_V = errorRegularizacionMulticlase(Xv,Yv,th);
        % se guardan los valores de error obtenidos para posteriormente
        % imprimir una gráfica
        errT = [errT err_T];
        errV = [errV err_V];
        % si el modelo es mejor que el anterior, se guarda
        if err_V < bestErrV 
            bestModel = model;
            bestErrV = err_V;
        end
    end
    % si mejor error del modelo obtenido tan solo un 1% mayor que el error
    % que se obtuvo en la practica anterior, ya se ha obtenido el numero de
    % componentes con las que te puedes quedar sin alterar el resultado
    errK = [errK bestErrV];
    if(bestErrV<=err*1.01)
       elegido = 1;
   end
    k = k +1 
end
k = k - 1
figure;
hold on
plot((1:k), errK,'b-','LineWidth', 1);
plot((1:k),ones(k)*err*1.01,'r-','LineWidth',1)
legend('Error obtenido','Error admitido')
hold off

title('Errores obtenidos con los distintos valoes de k')
ylabel('Error'); xlabel('Valor de k');

sprintf("El valor de componentes con el que te puedes quedar si alterar resultados es = %d",k)

Xtest2 = normalize(Xtest,'center','mean');
Ztest = Xtest2*Uk;
th = entrenarGaussianas(Z,y,10,naiveBayes,lambda(bestModel));
ypred = clasificacionBayesiana(th,Ztest);
matrizConf = matrizConfusion(ypred,ytest,10)

verConfusiones(Xtest,ytest,ypred)
%% Use the classifier from previous labs on the projected space
k=1;
while k <= size(X,2) && sum(A(1:k))/sum(A) < 0.99
    k = k + 1;
end
Uk = U(:,1:k);
Z = Xp * Uk;
[Xtr, Ytr, Xv, Yv] = separar([Z y],0.8,[(1:k)],[k+1]);

lambda = logspace(-6,1,50)';

bestModel = 0;
bestErrV = inf;
errT = [];
errV = [];
naiveBayes = 0;
for model = 1:size(lambda,1)
    err_T = 0;
    err_V = 0;
    % se calcula la matriz de pesos
   
    th = entrenarGaussianas(Xtr, Ytr, 10, naiveBayes, lambda(model));
    % se calculan los valores de error
    err_T = errorRegularizacionMulticlase(Xtr,Ytr,th);
    err_V = errorRegularizacionMulticlase(Xv,Yv,th);
    % se guardan los valores de error obtenidos para posteriormente
    % imprimir una gráfica
    errT = [errT err_T];
    errV = [errV err_V];
    % si el modelo es mejor que el anterior, se guarda
    if err_V < bestErrV 
        bestModel = model;
        bestErrV = err_V;
    end
end

figure;
plot(log10(lambda(bestModel)),errV(bestModel),'go');
hold on
plot(log10(lambda), errT,'b-','LineWidth', 1);
plot(log10(lambda), errV, 'r-','LineWidth', 1);
legend('Parámetro de regularización ideal','Error de entrenamiento','Error de validacion')
hold off

title('Curva del error')
ylabel('Error'); xlabel('Grado de lambda');

sprintf("El mejor modelo obtenido es con lambda = %s",lambda(bestModel))
sprintf("El menor error de validación obtenido es = %s", errV(bestModel))

Xtest2 = normalize(Xtest,'center','mean');
Ztest = Xtest2*Uk;
th = entrenarGaussianas(Z,y,10,naiveBayes,lambda(bestModel));
ypred = clasificacionBayesiana(th,Ztest);
matrizConf = matrizConfusion(ypred,ytest,10)

TP = [];
TN = [];
FP = [];
FN = [];
for i = 1:10
    TP = [TP sum(ytest == i & ypred == i)];
    TN = [TN sum(ytest ~= i & ypred ~= i)];
    FP = [FP sum(ypred == i & ytest ~= i)];
    FN = [FN sum(ypred ~= i & ytest == i)];
end
TP
FP
FN
Precision = TP ./ (TP + FP)
Recall = TP ./ (TP + FN)

verConfusiones(Xtest,ytest,ypred)


