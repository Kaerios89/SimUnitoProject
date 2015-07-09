function b=provavett(n)
    a=[0,0,0,0];
    b=a;
    for i=0:n
        for j=0:n
            for l=0:n
                for k=0:n
                    appo=[i,j,l,k];
                    a=[a;appo];
                end
            end
        end
    end
    appo1=sum(a,2);
    for r=1:size(appo1,1)
        if appo1(r,1)==n
            b=[b;a(r,:)];
        end
    end
    b=b(2:size(b,1),:);
end