function Mat=TotalState(N,S)
    %si uniscono S e b per formare una matrice che ha per righe le tuple di
    %interesse
    warning('off','all');
    Mat=double.empty(size(S,2),0);
    for i=1:size(S,1)
        for j=1:size(N,1)
            if isempty(find(S(i,:).*N(j,:)==0))
                %vuol dire che non ci sono zeri
                appo=fusion(N(j,:),S(i,:));
                Mat=[Mat;appo];
            else
                Index=find(S(i,:).*N(j,:)==0);
                if sum(S(i,Index)+N(j,Index))==0
                   %ok, vuol dire che gli zeri ci sono dove ci sono entrambi zeri 
                   appo=fusion(N(j,:),S(i,:));
                   Mat=[Mat;appo];
                end
            end
        end
    end
    warning('on','all');
end