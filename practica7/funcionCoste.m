function J = funcionCoste(D,mu,c)
    m = size(D,1);
    J = sum(sum((D-mu(c,:)).^2,2))./m;
end