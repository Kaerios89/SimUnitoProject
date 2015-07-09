%questa funzione restituisce il risultato per un dato numero di clienti,
%verosimilmente verrà richiamata un numero di volte pari al numero massimo
%di clienti.

%NOTE: se uso una rappresentazione simbolica per le variabili di ingresso,
%posso definire i legami fra loro in un secondo momento. (in questo modo
%l'unica variabile che rimane è il paramatro di ingresso della Erlang)

function Sol=Erlang3(tServ,pTrans,IndexCPU,nClient,StazType)
    t1Serv=tServ;
    t1Serv(IndexCPU)=t1Serv(IndexCPU)/3;
    S=provaStato();
    N=provavett(nClient);
    StateMat=TotalState(N,S);
    %% Calcolo del generatore infinitesimale Q
    %inizializzazione simbolica del generatore infinitesimale
    q=zeros(size(StateMat,1));
    Q=sym(q);
    
    %inizializzazione delle variabili del tempo di arrivo NOTA!!: rete
    %chiusa forse non serve!      
    %Mi appresto a riempire la matrice Q del generatore infinitesimale.
    
%     Label1='Numero di stati eseguiti';
%     Label2='Avanzamento per ogni stato';
%     progressbar(Label1,Label2);
    
    for i=1:size(StateMat,1)
        S1=StateMat(i,[2,4,6,8]);   %se non si hanno 4 stazioni è facile costruirsi un generatore di numeri pari o dispari
        N1=StateMat(i,[1,3,5,7]);
        for j=1:size(StateMat,1)
            S2=StateMat(j,[2,4,6,8]);
            N2=StateMat(j,[1,3,5,7]);
            dif=N1-N2;
            dif1=sum(dif);
            if (sum(abs(dif))>2)||(abs(dif1)==2)
                %metti zero in q in quanto non accettiamo transazioni
                %simultanee
                Q(i,j)=0;
            else
                switch dif1
                    case 1
                        Q(i,j)=0;
                    case -1
                        Q(i,j)=0;
                    case 0
                        if sum(abs(dif))==0
                            %vuol dire che siamo sulla diagonale o in uno
                            %stato di erlang (N è invariato ma cambia S)
                            SDif=S1-S2;
                            if SDif(IndexCPU)==-1
                                Q(i,j)=1/t1Serv(IndexCPU);
                            else
                                if SDif(IndexCPU)==2
                                    Q(i,j)=pTrans(2,2)*1/t1Serv(IndexCPU);
                                else
                                    Q(i,j)=0;   
                                end
                            end
                        else
                            OutIndex=find(dif==1);
                            InIndex=find(dif==-1);
                            if pTrans(OutIndex,InIndex)~=0
                                %transizione legale
                                if StazType(OutIndex)==2
                                        %vuol dire che stiamo uscendo da una
                                        %stazione SS
                                    if (OutIndex==IndexCPU)&&(InIndex~=IndexCPU)
                                        %controllo se si sta transendo
                                        %correttamente fuori dalla erlang
                                       if S1(IndexCPU)==3
                                           Q(i,j)=pTrans(OutIndex,InIndex)*1/t1Serv(OutIndex);
                                       else
                                           Q(i,j)=0;
%                                            Q(i,j)=pTrans(OutIndex,InIndex)*1/t1Serv(OutIndex);
                                       end
                                    elseif (InIndex==IndexCPU)&&(OutIndex~=IndexCPU)
                                       if (N1(IndexCPU)>0)||(S2(IndexCPU)==1 && N1(IndexCPU)==0)
                                           Q(i,j)=pTrans(OutIndex,InIndex)*1/t1Serv(OutIndex);
                                       else
                                           Q(i,j)=0;
                                       end
                                    else
                                        Q(i,j)=pTrans(OutIndex,InIndex)*1/t1Serv(OutIndex);
                                    end
                                elseif (StazType(OutIndex)==1)
                                        %vuol dire che stiamo uscendo da una
                                        %stazione LD e quindi il parametro di
                                        %uscita varia di conseguenza
                                    if (OutIndex==IndexCPU)&&(InIndex~=IndexCPU)
                                        %controllo se si sta transendo
                                        %correttamente fuori dalla erlang
                                       if S1(IndexCPU)==3
                                           Q(i,j)=pTrans(OutIndex,InIndex)*(1/t1Serv(OutIndex))*N1(OutIndex);
                                       else
                                           Q(i,j)=0;
                                       end
                                    elseif (InIndex==IndexCPU)&&(OutIndex~=IndexCPU)
                                       if (N1(IndexCPU)>0)||(S2(IndexCPU)==1 && N1(IndexCPU)==0)
                                           Q(i,j)=pTrans(OutIndex,InIndex)*(1/t1Serv(OutIndex))*N1(OutIndex);
                                       else
                                           Q(i,j)=0;
                                       end
                                    else
                                        Q(i,j)=pTrans(OutIndex,InIndex)*(1/t1Serv(OutIndex))*N1(OutIndex);
                                    end

                                end
                            else
                                Q(i,j)=0;
                            end
                        end
                end
            end
            frac3=j/size(StateMat,1);
            frac2=((i-1)+frac3)/size(StateMat,1);
            progressbar([],frac2,frac3);
        end
            Q(i,i)=0;
            Q(i,i)=-sum(Q(i,:));
    end
    %%
    % vedere se si devono pesare le uscite con pTrans
    P=sym('P',[1,size(StateMat,1)]);
    eq=P*Q;
    sys=eq==0;
    Norm=sum(P);
    assume(Norm==1);
    res=solve(sys);
    resNames=fieldnames(res);
    evaluated=double.empty(size(resNames,1),0);
    for i=1:size(resNames,1)
        evaluated(i,1)=getfield(res,resNames{i});
    end
    Sol=zeros(4,1);
    for i=1:4
        if StazType(i)==2
            if i==IndexCPU
                for j=1:size(StateMat,1)
                    if (StateMat(j,(2*i-1))~=0)&&(StateMat(j,(2*i))==3)
                        %allora prendi il valore corrispondente a tale stato in
                        %evaluated, moltiplicaci il tasso di uscita e sommalo
                        Sol(i,1)=Sol(i,1)+(evaluated(j,1)*1/t1Serv(i));
                    end
                end
            else
                for j=1:size(StateMat,1)
                    if (StateMat(j,(2*i-1))~=0)
                        %allora prendi il valore corrispondente a tale stato in
                        %evaluated, moltiplicaci il tasso di uscita e sommalo
                        Sol(i,1)=Sol(i,1)+(evaluated(j,1)*1/t1Serv(i));
                    end
                end
            end
        elseif StazType(i)==1
            if i==IndexCPU
                for j=1:size(StateMat,1)
                    if (StateMat(j,(2*i-1))~=0)&&(StateMat(j,(2*i))==3)
                        %allora prendi il valore corrispondente a tale stato in
                        %evaluated, moltiplicaci il tasso di uscita e sommalo
                        Sol(i,1)=Sol(i,1)+(evaluated(j,1)*(1/t1Serv(i))*StateMat(j,(2*i-1)));
                    end
                end
            else
                for j=1:size(StateMat,1)
                    if (StateMat(j,(2*i-1))~=0)
                        %allora prendi il valore corrispondente a tale stato in
                        %evaluated, moltiplicaci il tasso di uscita e sommalo
                        Sol(i,1)=Sol(i,1)+(evaluated(j,1)*(1/t1Serv(i))*StateMat(j,(2*i-1)));
                    end
                end
            end
        end
    end
    Sol=Sol';
end