function [g]=appo(VisitVector,tServ,nStaz,ClientMax,StazType)
    g(1)=1;
    for k=2:ClientMax+1
        g(k)=0;
    end
    for i=1:nStaz
        if StazType(i)==2
            y=VisitVector(i)*tServ(i);
            for k=2:ClientMax+1
                g(k)=g(k)+(y*g(k-1));
            end
        else
            f(1)=1;
            for k=2:ClientMax+1
                f(k)=f(k-1)*VisitVector(i)*(tServ(i)/(k-1));
            end
            for n=ClientMax+1:-1:2
                sum=g(n);
                for k=2:n
                    sum=sum+f(k)*g(n-k+1);
                end
                g(n)=sum;
            end
        end
    end
    g=g';
end