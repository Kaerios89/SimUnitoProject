function [wMean,X,U,nMean,p]=Convol(VisitVector,tServ,nStaz,clientMax,StazType)
        %da qui in avanti a(x,y) x=stazione y=numClient.
        %NOTA: forse va potata la prima riga...(è tutta uno) pure la
        %colonna
    G=zeros(clientMax+1,nStaz+1);
    G(1,1)=1;
    p=zeros(clientMax+1,nStaz+1);
    for i=2:nStaz+1
        if StazType(i-1)==2
            %stazioni load Indipendent
            appo=VisitVector(i-1)*tServ(i-1);
            for k=2:clientMax+1
                G(k,i)=G(k,i)+(appo*G(k-1,i-1));
                p(k,i)=appo*G(clientMax+1-k+1,i-1)/G(clientMax+1,i);
            end
        else
            %stazioni load Dipendent
            f(1)=1;
            for k=2:clientMax+1
                f(k)=f(k-1)*VisitVector(i-1)*(tServ(i-1)/k);
            end
            for n=clientMax+1:-1:2
                appo1=G(n,i-1);
                for k=2:n-1
                    appo1=appo1+f(k)*G(n-k,i-1);
                    %p(k,i)=f(k)*G(n-k,i-1)/G(clientMax+1,nStaz+1)
                end
                G(n,i)=appo1;
            end
            for k=2:clientMax+1
                p(k,i)=f(k)*G(clientMax+1-k+1,i-1)/G(clientMax+1,nStaz+1);
            end
        end
    end
    
    %ora che abbiamo G vanno calcolati i vari indici di prestazione
    for m=2:nStaz+1
        X(m-1)=VisitVector(m-1)*(G(clientMax,nStaz+1)/G(clientMax+1,nStaz+1));
        U(m-1)=1-(G(clientMax+1,nStaz)/G(clientMax+1,nStaz+1));
        nMean(m-1)=0;
        for k=2:clientMax+1
            nMean(m-1)=nMean(m-1)+(k-1)*p(k,m);
        end
        wMean(m-1)= nMean(m-1)/X(m-1);
    end    
end
%qualcosa non va l'utilizzazione va sopra a 1
%TROVATO!! la stazione di riposo è dipendente dal carico ergo ha un tempo
%di servizio pari a s(4)*k dove k sono i clientei che gli arrivano
%usare quindi MVA2 o convolutivo