function G=ConvCol(S,V,Type,N)
    g(1)=1;
    for k=2:N+1
        g(k)=0;
    end
    if Type==2
        y=V*S;
        for k=2:N+1
            g(k)=g(k)+(y*g(k-1));
        end
    else
        f(1)=1;
        for k=2:N+1
            f(k)=f(k-1)*V*S/(k-1);
        end
        for n=N+1:-1:2
            sum=g(n);
            for k=2:n
                sum=sum+f(k)*g(n-k+1);
            end
            g(n)=sum;
        end
    end
    G=g
end