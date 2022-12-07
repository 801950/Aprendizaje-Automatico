clear all;
%% Regularización 

datos = load('CochesTrain.txt');
ydatos = datos(:, 1);   % Precio en Euros
Xdatos = datos(:, 2:4); % Años, Km, CV
x1dibu = linspace(min(Xdatos(:,1)), max(Xdatos(:,1)), 100)'; %para dibujar
X = expandir(Xdatos,[10 10 10]);
lambda = [];

i = 1
while i <= 100000
    lambda = [lambda i];
    i = i .* 10;
end
%i = i .* 10
%i = i .* 10
[h, errTrain, errTest] = k_fold_cross_validation(10,@entrenaRegularizacion,Xdatos,ydatos,lambda',@errorRegularizacion);
disp("El grado ideal para el factor de regularización es: ")
h
lambda(h)

figure;
grid on; hold on;
plot(lambda, errTrain,'b-');
plot(lambda, errTest,'r-');
plot(lambda(h),errTest(h),'go')
title('Curva del error')
ylabel('Error'); xlabel('Grado del atributo potencia');
legend('Error de entrenamiento','Error de test','Factor ideal')
