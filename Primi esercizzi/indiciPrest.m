function [X,R]=indiciPrest(VisitVector,tServ,nStaz,ClientMax,StazType)
    G=appo(VisitVector,tServ,nStaz,ClientMax,StazType);
    x=G(1:ClientMax,1)./G(2:ClientMax+1,1);
    X=x*VisitVector;
    for k=1:nStaz
        for i=1:ClientMax
            r0(i)=(i/X(i,k))-tServ(1);
        end
        R(:,k)=r0;
    end
end