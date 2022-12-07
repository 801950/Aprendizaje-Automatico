function [Xtr, Ytr, Xtst, Ytst] = separar(data,porc)
    randOrd = randperm(size(data,1));
    perm = data( randOrd,:);
    lim = int32(size(data,1)*porc);
    Xtr = perm((1:lim),[1,2]);
    Ytr = perm(1:lim,3);
    Xtst = perm(lim+1:end,[1,2]);
    Ytst = perm(lim+1:end,3);
end