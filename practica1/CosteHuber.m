function [T, J] = CosteHuber(X, y, theta, alpha, d)
    [J, grad] = CosteHuber2(theta,X,y,d);
    theta2 = theta - alpha .* grad;
    while (mean(abs(theta-theta2))>0.001)
        theta = theta2;
        [J2, grad] = CosteHuber2(theta,X,y,d);
        J = [J J2];
        theta2 = theta - alpha .* grad;
    end
    T = theta2;
end