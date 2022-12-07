close all;
addpath(genpath(pwd));
%% Practica 4 
% Based on exercise 3 of Machine Learning Online Class by Andrew Ng 
%

clear ; close all;
addpath(genpath('../minfunc'));

% Carga los datos y los permuta aleatoriamente
load('MNISTdata2.mat'); % Lee los datos: X, y, Xtest, ytest
rand('state',0);
p = randperm(length(y));
X = X(p,:);
y = y(p);

% Inventa una solucion y muestra las confusiones
yhat = ceil(10*rand(size(y)));
verConfusiones(X, y, yhat);


options = [];
options.display = 'final';
options.methods = 'newton';
theta_ini = zeros(size(X,2),1);
t = []
for i = 1 : 10
    t = [t minFunc(@CosteLogReg, theta_ini,options,X,(y==i),0.0001)];
end
ypred = 1./(1+exp(-(X*t)))
[M,I] = max(ypred,[],2)
