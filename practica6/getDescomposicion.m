function Xhat = getDescomposicion(U,S,V,k)
    S2 = S(k,k);
    U2 = U(:,k);
    V2 = V(k,:);
    Xhat = U2*S2*V2;
end