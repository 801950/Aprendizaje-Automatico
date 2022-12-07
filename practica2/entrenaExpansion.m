function H = entrenaExpansion(G,X,y)
    Xp = expandir(X,G);
    [Xp,mu,sigma] = normalizar(Xp);
    H = ecuacionNormal(Xp,y);
    H = desnormalizar(H,mu,sigma);
end