function [vettore]=vettorevisite(nStaz,pTrans)
    Y=sym('X',[nStaz,1]);
    %Y=Y./Y(1);
    Q=(sym(pTrans));
    for i=1:nStaz
        eq(i,1)=sum(Y.*Q(:,i));
    end
    sys=(Y==eq);
    assume(sys(1)==1);
    res=solve(sys);
    res=[res.X1 res.X2 res.X3 res.X4];
    vettore=eval(res);
end