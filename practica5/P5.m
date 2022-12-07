clear ; close all;
rand('state',0);
load('MNISTdata2.mat');
[Xtr, Ytr, Xv, Yv] = separar([X y],0.8,[(1:400)],[401]);
Xtr = [ones(size(Xtr,1),1) Xtr];
Xv = [ones(size(Xv,1),1) Xv];

%% Bayes ingenuo

lambda = logspace(-6,1,30)';

bestModel = 0;
bestErrV = inf;
errT = [];
errV = [];
naiveBayes = 1;
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

X = [ones(size(X,1),1) X];
Xtest = [ones(size(Xtest,1),1) Xtest];
th = entrenarGaussianas(X,y,10,naiveBayes,lambda(bestModel));
ypred = clasificacionBayesiana(th,Xtest);
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

%% Covarianzas completas
lambda = logspace(-6,1,30)';

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
sprintf("El mejor error obtenido es = %s",errV(bestModel))

th = entrenarGaussianas(X,y,10,naiveBayes,lambda(bestModel));
ypred = clasificacionBayesiana(th,Xtest);
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
