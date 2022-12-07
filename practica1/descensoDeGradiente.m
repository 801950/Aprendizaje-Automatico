function [T, J] = descensoDeGradiente(X, theta, y, alpha)
    r = X*theta - y;
    grad = X' * r;
    theta2 = theta - alpha .* grad;
    J = (1/2)*sum(r.^2);
    while (mean(abs(theta-theta2))>0.001)
        theta = theta2;
        r = X * theta - y;
        J = [J (1/2)*sum(r.^2)];
        grad = X' * r;
        theta2 = theta - alpha .* grad;
    end
    T = theta2;
end