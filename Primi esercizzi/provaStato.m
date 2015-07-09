function S=provaStato()
    a=[0,0,0,0];
    b=a;
    for i=0:1
        for j=0:3
%         for j=0:1
            for l=0:1
                for k=0:1
                    appo=[i,j,l,k];
                    a=[a;appo];
                end
            end
        end
    end
    b=a(2:size(a,1),:);
    S=b;
end