function [Xp, mu, sigma] = normalizar(X)
    Xp = X;
    N = size(X,1);
    mu = mean(X(:,2:end));
    sigma = std(X(:,2:end));
    Xp(:,2:end) = (X(:,2:end)- repmat(mu,N,1)) ./ repmat(sigma,N,1);
end