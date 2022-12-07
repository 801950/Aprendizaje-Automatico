%figure(1)
im = imread('smallparrot.jpg');
%imshow(im)
%% datos
D = double(reshape(im,size(im,1)*size(im,2),3));

%% dimensiones
m = size(D,1);
n = size(D,2);

%% Kmeans 

min = Inf;
mu0 = inicializarCentroides(D,3);
[mu, c] = kmeans(D, mu0);
costeAnt = funcionCoste(D,mu,c);
costes = [costeAnt];
codo = false;
%% Inicializar centroides
for K = 4:20
    
    
    mu0 = inicializarCentroides(D,K);

    [mu, c] = kmeans(D, mu0);
    coste = funcionCoste(D,mu,c);
    costes = [costes coste];
    (costeAnt - coste)/costeAnt;
    if (costeAnt - coste)/costeAnt > 0.09 && codo == false
        min = coste;
        muMin = mu;
        cMin = c;
        kmin = K;
    else
        codo = true;
    end
    costeAnt = coste;
end
K = 7;
mu0 = inicializarCentroides(D,K);

[mu, c] = kmeans(D, mu0);
figure;
hold on
plot((3:20), costes,'b-','LineWidth', 1);
legend('Error obtenido')
hold off

title('Errores obtenidos con los distintos valores de k')
ylabel('Error'); xlabel('Valor de k');

 qIM=zeros(length(c),3);
 for h=1:K,
     ind=find(c==h);
     qIM(ind,:)=repmat(mu(h,:),length(ind),1);
 end
 qIM=reshape(qIM,size(im,1),size(im,2),size(im,3));
 figure(2)
 imshow(uint8(qIM));

 %% Segunda imagen
im = imread('una-imagen-con-muchos-colores.jpg');
figure;
imshow(im)
%% datos
D = double(reshape(im,size(im,1)*size(im,2),3));

%% dimensiones
m = size(D,1);
n = size(D,2);

%% Kmeans 

min = Inf;
mu0 = inicializarCentroides(D,3);
[mu, c] = kmeans(D, mu0);
costeAnt = funcionCoste(D,mu,c);
costes = [costeAnt];
codo = false;
%% Inicializar centroides
for K = 4:20
    
    
    mu0 = inicializarCentroides(D,K);

    [mu, c] = kmeans(D, mu0);
    coste = funcionCoste(D,mu,c);
    costes = [costes coste];
    (costeAnt - coste)/costeAnt;
    if (costeAnt - coste)/costeAnt > 0.09 && codo == false
        min = coste;
        muMin = mu;
        cMin = c;
        kmin = K;
    else
        codo = true;
    end
    costeAnt = coste;
end
K = 7;
mu0 = inicializarCentroides(D,K);

[mu, c] = kmeans(D, mu0);
figure;
hold on
plot((3:20), costes,'b-','LineWidth', 1);
legend('Error obtenido')
hold off

title('Errores obtenidos con los distintos valores de k')
ylabel('Error'); xlabel('Valor de k');

 qIM=zeros(length(c),3);
 for h=1:K,
     ind=find(c==h);
     qIM(ind,:)=repmat(mu(h,:),length(ind),1);
 end
 qIM=reshape(qIM,size(im,1),size(im,2),size(im,3));
 figure(5);
 imshow(uint8(qIM));