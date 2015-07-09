function [X,R]=Step2(tServ,pTrans,IndexCPU,nClientMax,StazType)
    Label1='Avanzamento generale';
    Label2='Numero di stati eseguiti';
    Label3='Avanzamento per ogni stato';
    progressbar(Label1,Label2,Label3);

    Sol=[];
    for i=1:nClientMax
        Sol=[Sol;Erlang3(tServ,pTrans,IndexCPU,i,StazType)];
        
        frac1=i/nClientMax;
        progressbar(frac1,[],[]);
    end
    X=Sol;
    N=[];
    R=zeros(nClientMax,4);
    for i=1:nClientMax
        N(i)=i;
    end
    for i=1:4
        if StazType(i)==2
            R(:,i)=(N'./X(:,i))-tServ(i);
        elseif StazType(i)==1
            appo1=(N'./X(:,i));
            for j=1:nClientMax
                appo1(j,1)=appo1(j,1)-(tServ(i)/j);
            end
            R(:,i)=appo1;
        end
    end
end