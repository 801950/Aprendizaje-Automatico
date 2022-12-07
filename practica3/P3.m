close all;
addpath(genpath(pwd));
%% Regresión logística básica
data = load('exam_data.txt');
y = data(:,3);
N = length(y);

[Xtrain, Ytrain, Xtest, Ytest] = separar(data,0.8);
Xtrain = [ones(size(Xtrain,1),1) Xtrain]; % añade la columna de 1's

theta_ini = zeros(size(Xtrain,2),1); % inicializa el vector de pesos inicial a 0

options = [];
options.display = 'final'; %otros: 'iter' , 'none‘
options.method = 'newton'; %por defecto: 'lbfgs'

theta = minFunc(@CosteLogistico, theta_ini, options,...
Xtrain, Ytrain); % calcula el vector de pesos

% muestra el modelo calculado
plotDecisionBoundary(theta, Xtrain, Ytrain);
xlabel('Exam 1 score');
ylabel('Exam 2 score');

% predicción con los datos de entrenamiento y error obtenido
YpredTrain =  1./(1+exp(-(Xtrain*theta))) >= 0.5 ;
TasaErrorTrain = sum(YpredTrain ~= Ytrain) / size(Ytrain,1)

Xtest = [ones(size(Xtest,1),1) Xtest];

% predicción con los datos de test y error obtenido
Ypredtest =  1./(1+exp(-(Xtest*theta))) >= 0.5 ;
TasaErrorTest = sum(Ypredtest ~= Ytest) / size(Ytest,1)

% se busca una predicción para cada posible valor de la nota del segundo
% examen
ex2 = (0:0.8:100)';
ex2 = [ones(size(ex2,1),1) 45*ones(size(ex2,1),1) ex2];
ypred = 1./(1+exp(-(ex2*theta)));
figure;
plot(ex2(:,3),ypred,'m-');
xlabel('Exam 2 score');
ylabel('Probabilidad de ser admitido');


%% Regularización
data = load('mchip_data.txt');
y = data(:,3);
N = length(y);

[Xtrain, Ytrain, Xtest, Ytest] = separar(data,0.8);
Xtrain = mapFeature(Xtrain(:,1),Xtrain(:,2));
Xtest = mapFeature(Xtest(:,1), Xtest(:,2));

% se crean un vector con los parámetros de regularización que se quieren
% probar
lambda = logspace(-6,2,9)

[h, errTrain, errTest] = k_fold_cross_validation(10,@entrenaRegularizacion, ...
    Xtrain,Ytrain,lambda',@errorRegularizacion);

sprintf("El parámetro ideal para lambda es %s",lambda(h))

figure;
plot(log10(lambda(h)),errTest(h),'go');
hold on
plot(log10(lambda), errTrain,'b-','LineWidth', 1);
plot(log10(lambda), errTest, 'r-','LineWidth', 1);
legend('Parámetro de regularización ideal','Error de entrenamiento','Error de validacion')
hold off

title('Curva del error')
ylabel('Error'); xlabel('Grado de lambda');

% curva de separación con parámetro de regularización encontrado
theta = entrenaRegularizacion(lambda(h),Xtrain,Ytrain);
plotDecisionBoundary(theta,Xtrain,Ytrain);
legend('Aceptado','Rechazado','Decisión');

% curva de separación con lambda = 0
theta2 = entrenaRegularizacion(0,Xtrain,Ytrain);
plotDecisionBoundary(theta2,Xtrain,Ytrain);
legend('Aceptado','Rechazado','Decisión');

%% Precisión - recall

Ypredtest = 1./(1+exp(-(Xtest*theta))) >= 0.5;

% matriz de confusión
TP = sum(Ytest == 1 & Ypredtest == 1)
TN = sum(Ytest == 0 & Ypredtest == 0)
FP = sum(Ypredtest == 1 & Ytest == 0)
FN = sum(Ypredtest == 0 & Ytest == 1)

Precision = TP / (TP + FP)
Recall = TP / (TP + FN)

 %% Obetener que el 95% de los chips aceptados sean buenos

mejorUmbral = 0;
mejorRecall = 0;
for i=0.01:0.01:1
    Ypred =  1./(1+exp(-(Xtrain*theta))) >= i ;
    TP = sum(Ytrain == 1 & Ypred == 1);
    TN = sum(Ypred == 0 & Ypred == 0);
    FP = sum(Ypred == 1 & Ytrain == 0);
    FN = sum(Ypred == 0 & Ytrain == 1);
    Precision = TP / (TP + FP);
    Recall = TP / (TP + FN);
    if Precision >= 0.95 && Recall > mejorRecall 
        mejorRecall = Recall;
        mejorUmbral = i; 
    end
end

sprintf("El mejor umbral es %f",mejorUmbral)
