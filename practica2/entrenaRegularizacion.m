function theta = entrenaRegularizacion(lambda, X, y)
    [Xp,mu,sigma] = normalizar(X);
    H = Xp'*Xp + lambda*diag([0 ones(1,size(Xp,2)-1)]);
    theta = H \ (Xp'*y);
    theta = desnormalizar(theta,mu,sigma);
end