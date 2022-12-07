clear ; close all;
addpath(genpath('../minfunc'));
rand('state',0);
load('MNISTdata2.mat');
[Xtr, Ytr, Xv, Yv] = separar([X y],0.8,[(1:400)],[401]);
Xtr = [ones(size(Xtr,1),1) Xtr];
Xv = [ones(size(Xv,1),1) Xv];

%% Regresión logística regularizada

lambda = logspace(-6,1,20)';

bestModel = 0;
bestErrV = inf;
errT = [];
errV = [];
% para cada valor de lambda
for model = 1:size(lambda,1)
    err_T = 0;
    err_V = 0;
    % se calcula la matriz de pesos
    th = entrenaRegularizacionMulticase(Xtr,Ytr,lambda(model,:),10);
    % se calculan los valores de error
    err_T = errorRegularizacionMulticase(Xtr,Ytr,th);
    err_V = errorRegularizacionMulticase(Xv,Yv,th);
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


%% Matriz de confusión y Precisión Recall
Xtest = [ones(size(Xtest,1),1) Xtest];
X = [ones(size(X,1),1) X];
th = entrenaRegularizacionMulticase(X,y,lambda(bestModel,:),10);
ypred = prediccionMulticlase(Xtest,th);
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
Accuracy = (TP+TN) ./ (TP+TN+FP+FN)
mean(Accuracy)
verConfusiones(Xtest,ytest,ypred)