im = imread('smallparrot.jpg');
%imshow(im)
%% datos
D = double(reshape(im,size(im,1)*size(im,2),3));

%% dimensiones
m = size(D,1);
n = size(D,2);
mu0 = inicializarCentroides(D,16);
[mu, c] = kmeans(D, mu0);
K = 16;
qIM=zeros(length(c),3);
 for h=1:K,
     ind=find(c==h);
     qIM(ind,:)=repmat(mu(h,:),length(ind),1);
 end
 qIM=reshape(qIM,size(im,1),size(im,2),size(im,3));
 figure(6)
 imshow(uint8(qIM));