function [StazBN,IndexBN]=bottleneck(VisitVector,tServ,StazDescr,StazType)
    for i=1:size(VisitVector,2)
        if StazType(i)==2
            appo(i)=VisitVector(i)*tServ(i);
        else
            appo(i)=NaN;
        end
    end
    [val,index]=max(appo);
    StazBN=['L''attuale stazione di bottleneck è la numero ',num2str(index),' stazione di tipo ',StazDescr(index)];
    IndexBN=index;
end