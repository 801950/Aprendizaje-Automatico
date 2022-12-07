close all;
%% Regresión monovariable para predecir el precio de los pisos en función 
% de su superficie utilizando la ecuación normal
datos = load('PisosTrain.txt');
y = datos(:,3);  % Precio en Euros
x1 = datos(:,1); % m^2
N = length(y);


X = [ones(N,1) x1];

theta = ecuacionNormal(X,y);
ypred  = X * theta;

figure;
plot(x1, y, 'bx');
title('Precio de los Pisos')
ylabel('Euros'); xlabel('Superficie (m^2)');
grid on; hold on; 

Xextr = [1 min(x1)  % Predicción para los valores extremos
         1 max(x1)];
yextr = Xextr * theta;  
plot(Xextr(:,2), yextr, 'r-'); % Dibujo la recta de predicción
legend('Datos Entrenamiento', 'Prediccion')

r = X * theta - y;

RMSEtrain = sqrt(r'*r./N)


datos_test = load('PisosTest.txt');
y_test = datos_test(:,3);  % Precio en Euros
x1_test = datos_test(:,1); % m^2
N_test = length(y_test);

X_test = [ones(N_test,1) x1_test];
y_pred_test = X_test * theta;

r_test = X_test * theta - y_test;

RMSEtest = sqrt(r_test'*r_test./N_test)

%% Regresión multivariable para predecir el precio de los pisos en función 
% de la superficie y del número de habitaciones.
% Utilizando la ecuación normal.

datos = load('PisosTrain.txt');
y = datos(:,3);  % Precio en Euros
x1 = datos(:,1); % m^2
x2 = datos(:,2);
N = length(y);

X = [ones(N,1) x1 x2];

[Xp, mu, sig] = normalizar(X);
theta_multi = ecuacionNormal(Xp,y);
theta_multi = desnormalizar(theta_multi,mu,sig);

ypred  = X * theta_multi;

r = X * theta_multi - y;

RMSEtrain = sqrt(r'*r./N)

figure;  
plot3(x1, x2, y, '.r', 'markersize', 20);
axis vis3d; hold on;
plot3([x1 x1]' , [x2 x2]' , [y ypred]', '-b');

% Generar una retícula de np x np puntos para dibujar la superficie
np = 20;
ejex1 = linspace(min(x1), max(x1), np)';
ejex2 = linspace(min(x2), max(x2), np)';
[x1g,x2g] = meshgrid(ejex1, ejex2);
x1g = x1g(:); %Los pasa a vectores verticales
x2g = x2g(:);

% Calcula la salida estimada para cada punto de la retícula
Xg = [ones(size(x1g)), x1g, x2g];
yg = Xg * theta_multi;

% Dibujar la superficie estimada
surf(ejex1, ejex2, reshape(yg,np,np)); grid on; 
title('Precio de los Pisos')
zlabel('Euros'); xlabel('Superficie (m^2)'); ylabel('Habitaciones');


datos_test = load('PisosTest.txt');
y_test = datos_test(:,3);  % Precio en Euros
x1_test = datos_test(:,1); % m^2
x2_test = datos_test(:,2);
N_test = length(y_test);

X_test = [ones(N_test,1) x1_test x2_test];

ypred_test  = X_test * theta_multi;

r_test = X_test * theta_multi - y_test;

RMSEtest = sqrt(r_test'*r_test./N_test)

disp("Precio de las habitaciones de 100m^2. Regresión monovariable.")
X1 = [1 100];
y1_pred = X1 * theta % el número de habitaciones en este modelo no se tiene en cuenta

disp("Precio de las habitaciones de 100m^2 con 2, 3, 4 y 5 habitaciones. Regresión multivariable.")
X2 = [1 100 2; 1 100 3; 1 100 4; 1 100 5];
y2_pred = X2 * theta_multi

%% Regresión monovariable utilizando descenso de gradiente.
datos = load('PisosTrain.txt');
y = datos(:,3);  % Precio en Euros
x1 = datos(:,1); % m^2
N = length(y);

X = [ones(N,1) x1];

theta_grad = [5000 1000]';
[Xp, mu, sig] = normalizar(X);
[theta_grad, J] = descensoDeGradiente(Xp,theta_grad, y, 0.0001);

theta_grad = desnormalizar(theta_grad,mu,sig);

figure;
plot(x1, y, 'bx');
title('Precio de los Pisos')
ylabel('Euros'); xlabel('Superficie (m^2)');
grid on; hold on; 

Xextr = [1 min(x1)  % Predicción para los valores extremos
         1 max(x1)];
yextr = Xextr * theta_grad;  
plot(Xextr(:,2), yextr, 'r-'); % Dibujo la recta de predicción
legend('Datos Entrenamiento', 'Prediccion')

figure;
xn = 1:size(J,2);
plot(xn, J, 'bx');
title('Coste')
ylabel('Coste'); xlabel('Iteración');
grid on; hold on; 

theta_grad

r = X * theta_grad - y;

RMSEtrain = sqrt(r'*r./N)

datos_test = load('PisosTest.txt');
y_test = datos_test(:,3);  % Precio en Euros
x1_test = datos_test(:,1); % m^2
N_test = length(y_test);

X_test = [ones(N_test,1) x1_test];


r_test = X_test * theta_grad - y_test;

RMSEtest = sqrt(r_test'*r_test./N_test)

%% Regresión multivariable utilizando descenso de gradiente.
datos = load('PisosTrain.txt');
y = datos(:,3);  % Precio en Euros
x1 = datos(:,1); % m^2
x2 = datos(:,2); % nº habitaciones
N = length(y);

X = [ones(N,1) x1 x2];

theta_grad_multi = [5000 1000 50000]';
[Xp, mu, sig] = normalizar(X);
[theta_grad_multi, J] = descensoDeGradiente(Xp,theta_grad_multi, y, 0.001);

theta_grad_multi = desnormalizar(theta_grad_multi,mu,sig);

ypred = X * theta_grad_multi;

figure;  
plot3(x1, x2, y, '.r', 'markersize', 20);
axis vis3d; hold on;
plot3([x1 x1]' , [x2 x2]' , [y ypred]', '-b');

% Generar una retícula de np x np puntos para dibujar la superficie
np = 20;
ejex1 = linspace(min(x1), max(x1), np)';
ejex2 = linspace(min(x2), max(x2), np)';
[x1g,x2g] = meshgrid(ejex1, ejex2);
x1g = x1g(:); %Los pasa a vectores verticales
x2g = x2g(:);

% Calcula la salida estimada para cada punto de la retícula
Xg = [ones(size(x1g)), x1g, x2g];
yg = Xg * theta_grad_multi;

% Dibujar la superficie estimada
surf(ejex1, ejex2, reshape(yg,np,np)); grid on; 
title('Precio de los Pisos')
zlabel('Euros'); xlabel('Superficie (m^2)'); ylabel('Habitaciones');

figure;
xn = 1:size(J,2);
plot(xn, J, 'bx');
title('Coste')
ylabel('Coste'); xlabel('Iteración');
grid on; hold on; 

theta_grad

r = X * theta_grad_multi - y;

RMSEtrain = sqrt(r'*r./N)

datos_test = load('PisosTest.txt');
y_test = datos_test(:,3);  % Precio en Euros
x1_test = datos_test(:,1); % m^2
N_test = length(y_test);

X_test = [ones(N_test,1) x1_test x2_test];


r_test = X_test * theta_grad_multi - y_test;

RMSEtest = sqrt(r_test'*r_test./N_test)

%% Regresión robusta con el coste de Huber
datos = load('PisosTrain.txt');
y = datos(:,3);  % Precio en Euros
x1 = datos(:,1); % m^2
x2 = datos(:,2); % nº habitaciones
N = length(y);

X = [ones(N,1) x1 x2];

theta_robusta = [5000 1000 50000]';
[Xp, mu, sig] = normalizar(X);
[theta_robusta, J] = CosteHuber(Xp, y, theta_robusta, 0.001, 1.5*10^5);

theta_robusta = desnormalizar(theta_robusta,mu,sig);

ypred = X * theta_robusta;

figure;  
plot3(x1, x2, y, '.r', 'markersize', 20);
axis vis3d; hold on;
plot3([x1 x1]' , [x2 x2]' , [y ypred]', '-b');

np = 20;
ejex1 = linspace(min(x1), max(x1), np)';
ejex2 = linspace(min(x2), max(x2), np)';
[x1g,x2g] = meshgrid(ejex1, ejex2);
x1g = x1g(:); %Los pasa a vectores verticales
x2g = x2g(:);

Xg = [ones(size(x1g)), x1g, x2g];
yg = Xg * theta_robusta;

surf(ejex1, ejex2, reshape(yg,np,np)); grid on; 
title('Precio de los Pisos')
zlabel('Euros'); xlabel('Superficie (m^2)'); ylabel('Habitaciones');

figure;
xn = 1:size(J,2);
plot(xn, J, 'bx');
title('Coste')
ylabel('Coste'); xlabel('Iteración');
grid on; hold on; 

r = X * theta_robusta - y;

RMSEtrain = sqrt(r'*r./N)

datos_test = load('PisosTest.txt');
y_test = datos_test(:,3);  % Precio en Euros
x1_test = datos_test(:,1); % m^2
x2_test = datos_test(:,2); % nº habitaciones
N_test = length(y_test);

X_test = [ones(N_test,1) x1_test x2_test];


r_test = X_test * theta_robusta - y_test;

RMSEtest = sqrt(r_test'*r_test./N_test)