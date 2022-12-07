close all;
%% Selección del grado del polinomio para la antigüedad del coche
datos = load('CochesTrain.txt');
ydatos = datos(:, 1);   % Precio en Euros
Xdatos = datos(:, 2:4); % Años, Km, CV
x1dibu = linspace(min(Xdatos(:,1)), max(Xdatos(:,1)), 100)'; %para dibujar

N = length(ydatos);
grados = [(1:10)' ones(10,1) ones(10,1) ];
[h, errTrain, errTest] = k_fold_cross_validation(10,@entrenaExpansion,Xdatos,ydatos,grados,@errorExpansion);
disp("El grado ideal para el atributo antigüedad es: ")
h

figure;
grid on; hold on;
plot((1:10), errTrain,'b-');
plot((1:10), errTest, 'r-');
plot(h,errTest(h),'go');
title('Curva del error')
ylabel('Error'); xlabel('Grado del atributo antigüedad');
legend('Error de entrenamiento','Error de validacion','Grado ideal')

%% Selección del grado del polinomio para los kilometros
datos = load('CochesTrain.txt');
ydatos = datos(:, 1);   % Precio en Euros
Xdatos = datos(:, 2:4); % Años, Km, CV
x1dibu = linspace(min(Xdatos(:,1)), max(Xdatos(:,1)), 100)'; %para dibujar

N = length(ydatos);
grados = [5*ones(10,1) (1:10)' ones(10,1) ];

[h, errTrain, errTest] = k_fold_cross_validation(10,@entrenaExpansion,Xdatos,ydatos,grados,@errorExpansion);
disp("El grado ideal para el atributo kilometros es: ")
h

figure;
grid on; hold on;
plot((1:10), errTrain,'b-');
plot((1:10), errTest, 'r-');
plot(h,errTest(h),'go');
title('Curva del error')
ylabel('Error'); xlabel('Grado del atributo kilometros');

legend('Error de entrenamiento', 'Error de validacion','Grado ideal')

%% Selección del grado del polinomio para la potencia
datos = load('CochesTrain.txt');
ydatos = datos(:, 1);   % Precio en Euros
Xdatos = datos(:, 2:4); % Años, Km, CV
x1dibu = linspace(min(Xdatos(:,1)), max(Xdatos(:,1)), 100)'; %para dibujar

N = length(ydatos);
grados = [5*ones(10,1) 6*ones(10,1) (1:10)'];

[h, errTrain, errTest] = k_fold_cross_validation(10,@entrenaExpansion,Xdatos,ydatos,grados,@errorExpansion);
disp("El grado ideal para el atributo potencia es: ")
h

figure;
grid on; hold on;
plot((1:10), errTrain,'b-');
plot((1:10), errTest,'r-');
plot(h,errTest(h),'go');
title('Curva del error')
ylabel('Error'); xlabel('Grado del atributo potencia');
legend('Error de entrenamiento','Error de validacion','Grado ideal')

%% Con el mejor modelo encontrado, entrenar con todos los datos y calcular 
% el error RMSE con los datos de test

datos = load('CochesTrain.txt');
ydatos = datos(:, 1);   % Precio en Euros
Xdatos = datos(:, 2:4); % Años, Km, CV
x1dibu = linspace(min(Xdatos(:,1)), max(Xdatos(:,1)), 100)'; %para dibujar

Xp = expandir(Xdatos,[5 6 6]);
[Xp,mu,sigma] = normalizar(Xp);
theta = ecuacionNormal(Xp,ydatos);
theta = desnormalizar(theta,mu,sigma);


datos2 = load('CochesTest.txt');
ytest = datos2(:,1);  % Precio en Euros
Xtest = datos2(:,2:4); % Años, Km, CV
Ntest = length(ytest);

RMSEtest = RMSE(theta,expandir(Xtest,[5 6 6]),ytest)

%% Regularización 

datos = load('CochesTrain.txt');
ydatos = datos(:, 1);   % Precio en Euros
Xdatos = datos(:, 2:4); % Años, Km, CV
x1dibu = linspace(min(Xdatos(:,1)), max(Xdatos(:,1)), 100)'; %para dibujar
X = expandir(Xdatos,[10 10 10]);
lambda = [];

i = 0.000000001
while i <= 0.00001
    lambda = [lambda i];
    i = i .* 2;
end
[h, errTrain, errTest] = k_fold_cross_validation(10,@entrenaRegularizacion,X,ydatos,lambda',@errorRegularizacion);
disp("El grado ideal para el factor de regularización es: ")
h
lambda(h)

figure;
grid on; hold on;
plot(lambda, errTrain,'b-');
plot(lambda, errTest,'r-');
plot(lambda(h),errTest(h),'go')
title('Curva del error')
ylabel('Error'); xlabel('Parámetro landa');
legend('Error de entrenamiento','Error de validacion','Factor ideal')

%% Con el mejor modelo encontrado, entrenar con todos los datos y calcular 
% el error RMSE con los datos de test

datos = load('CochesTrain.txt');
ydatos = datos(:, 1);   % Precio en Euros
Xdatos = datos(:, 2:4); % Años, Km, CV
x1dibu = linspace(min(Xdatos(:,1)), max(Xdatos(:,1)), 100)'; %para dibujar

lambda = 2.56*10^(-7);
Xp = expandir(Xdatos,[10 10 10]);
theta = entrenaRegularizacion(lambda,Xp,ydatos);


datos2 = load('CochesTest.txt');
ytest = datos2(:,1);  % Precio en Euros
Xtest = datos2(:,2:4); % Años, Km, CV
Ntest = length(ytest);

RMSEtest = RMSE(theta,expandir(Xtest,[10 10 10]),ytest)
