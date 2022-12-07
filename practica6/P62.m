%% Lab 6.2: SVD 

clear all
close all

% use YOUR image!
I = imread('nerea_gallego.jpg');

% Convert to B&W
BW = rgb2gray(I);

% Convert data to double
X=im2double(BW);

% show image
figure(1);
colormap(gray);
imshow(X);
axis off;

% Apply SVD
[U,S,V]=svd(X);
V = V';
S2 = diag(S);
% figure(5);
% colormap(gray);
% imshow(U*S*V);
% axis off;
% Plot first 5 components

for k = 1:5
    figure();
    colormap(gray);
    Xhat = getDescomposicion(U,S,V,k);
    imshow(Xhat);
    axis off;
end

% Plot the image reconstructed with 1, 2, 5, 10, 20, and the total number
% of components
for k = [1 2 5 10 20 rank(X)],
    figure();
    colormap(gray);
    Xhat = getDescomposicionAcum(U,S,V,k);
    imshow(Xhat);
    axis off;
end

% Find the value of k that maintains 90% of variability
k = 1

while k <= rank(X) && sum(S2(1:k))/sum(S2) < 0.9
    k = k + 1
end

% Plot the image reconstructed with the first  k components
figure();
colormap(gray);
Xhat = getDescomposicionAcum(U,S,V,k);
imshow(Xhat);
axis off;
% Compute and show savings in space
U2 = U(:,1:k);
S2 = S(1:k);
V2 = V(1:k,:);
total = size(X,1)*size(X,2);
new = (size(U2,1)*size(U2,2)+size(S2,1)*size(S2,2)+size(V2,1)*size(V2,2));
(total - new)*100/total



