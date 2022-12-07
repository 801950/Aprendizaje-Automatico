function Xhat = getDescomposicionAcum(U,S,V,k)
    S2 = S(1:k,:);
    Xhat = U(:,1:k)*S2(:,1:k)*V(1:k,:);
end