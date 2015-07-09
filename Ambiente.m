%coerente con funzioni
classdef Ambiente < handle
    properties
        nStaz %numero di stazioni del sistema
        pTrans %probabilità di tranzizione
        tServ %tempo di servizio delle stazioni
        StazType %tipologia di stazione 1=IS 2=SS
        StazDescr %contiene il tipo di funzione da usare
        
        Time
        GoOn
        
        RanGen
        
        EventList=EventListNode.empty;
        
%         TimeListener
        StazArr %Array contenente tutte le stazioni del sistema
        
        Result=Risultati.empty; %struttura per lo stoccaggio dei risultati
        IDRun
        
        AvVector=AvElement.empty; %struttura usata per il calcolo della stima
        
        PlotPoint=ConfPoint.empty; %struttura per lo stoccaggio di valore e intervallo
        
        Upper
        Lower
        Flood
    end
    
    methods
        function env=Ambiente(nStaz,pTrans,tServ,StazType,StazDescr,Seed)
            env.RanGen=RandGenerator(Seed);
            env.nStaz=nStaz;
            env.pTrans=pTrans;
            env.tServ=tServ;
            env.StazType=StazType;
            env.StazDescr=StazDescr;
            env.Time=0;
            env.GoOn=true;
            env.AvVector=[];
            env.PlotPoint=[];
            env.StazArr={};
            env.Upper=0;
            env.Lower=0;
            %per far funzionare il listener è necessario creare tutta la
            %struttura del simulatore, cosa che mi appreso a fare con i
            %dati che ho a disposizione.
            for i=1:nStaz
                switch StazType(i)
                    case 1
                        %caso di Infinite Server
                        env.StazArr{i}=InfiniteServer(i,1/tServ(i),env);
                    case 2
                        %caso di Single Server
                        switch StazDescr{i}
                            case 'exp_neg'
                                %crea una stazione di tipo M/M/1
                                env.StazArr{i}=SingleServer(i,1/tServ(i),env);
                            case 'erlang'
                                %crea una stazione a servitore singolo di
                                %tipo Erlang-k
                                env.StazArr{i}=CustomStation(i,1/tServ(i),env,@Erlang3Gen);
                            case 'composite'
                                %crea una stazione a servitore singolo con
                                %distribuzione composita Uni+Uni+Norm
                                env.StazArr{i}=CustomStation(i,1/tServ(i),env,@UniUniNormGen);
                        end
%                         if(strcmp(StazDescr(i),'exp_neg'))
%                             %esegui la creazione di una stazione SS del
%                             %tipo MM1
%                             env.StazArr{i}=SingleServer(i,1/tServ(i),env);
%                         elseif(strcmp(StazDescr(i),'custom'))
%                             %esegui la creazione della stazione custom
%                             funcString=inputdlg('Inserire la distribuzione custom','Distr_input');
%                             env.StazArr{i}=CustomStation(i,1/tServ(i),env,str2func(funcString));
%                         end
                end
            end
%             env.EventList la inizializzo appena creo il primo evento.
%             for i=1:size(env.StazArr,2)
%                 env.TimeListener{i}=addlistener(env.StazArr{i},'SetTime',@(sorg,data)env.AggiornaTempo(sorg,data,env));
%            end
            env.IDRun=1; 
            env.Flood=Floodchk(env);
        end
        function Env_out=StartEngine(Env,NoClient)
            %inizializza gli eventi, e scandisce la simulazione
            %% Inizializzo la simulazione schedulando un numero X di arrivi nella prima stazione (IS)
%             input=inputdlg('Inserire Numero di clienti del sistema','Input Request');
%             N=str2num(input{1}); %#ok<ST2NM>
            N=NoClient;
            for i=1:N
                ev=evento(Env.Time,Env.StazArr{1}.NoTime,Env.Time,evType.Arrivo,Env.StazArr{1}.Name);
                Env.EventList=schedula(Env.EventList,ev);
            end
            %% Core      
            %floodchk=false;
            precision=0.1;
            for pointRun=1:1
                passed = false;
                while (~passed)
                    clear r upper lower
                    
                    [CurrEvent,Env.EventList]=getEvent(Env.EventList,1);
                    engine(Env.StazArr{CurrEvent.Station},CurrEvent);
                    floodchk=isFlooded(Env.Flood,Env);
%                     if ~floodchk
%                         floodchk=true;
%                         for fIter=1:size(Env.StazArr,2)
%                             floodchk=floodchk && (Env.StazArr{fIter}.Npar>0);
%                         end
%                     else
                        if((Env.StazArr{2}.Nsys==0)&&(Env.StazArr{2}.Npar == Env.StazArr{2}.Narr)&& floodchk) %non c'è nessuno nella stazione, e sono tutti partiti.
                            OttieniRisultati(Env);
                            %cotrollo se posso terminare quando ritorno in un punto
                            %di rigeneraizone
                            Env.Flood=updFlood(Env.Flood,Env);
                            [passed,Env.Lower,Env.Upper,r]=TestPrecision(Env,precision);
                        end
%                     end
                end
                Env.PlotPoint=cat(2,Env.PlotPoint,ConfPoint(r,Env.Lower,Env.Upper));
                Env.Lower=0;
                Env.Upper=0;
                Env.AvVector=AvElement.empty;
            end
            %Env.PlotPoint=Env.PlotPoint(2:end);
            Env_out=Env;
        end
        function OttieniRisultati(Env)
            %funzione usata per prelevare i dati dalle stazioni e salvarle
            %in un file per una successiva elaborazione.
            for i=1:Env.nStaz
                buff=report(Env.StazArr{i});
                buff.IDRun=Env.IDRun;
                buff.NoStaz=i;
                %completo la classe Risultati con dati presi dall'ambiente
                Env.Result(i,Env.IDRun)=buff;
            end
            Env.IDRun=Env.IDRun+1;
        end
        function AggiornaTempo(Env,evento)
            %funzione chiamata dall'aggiornamento di tempo di una stazione.
            Env.Time=evento.NewTime;
        end
        function IDNext=prossima(Env,Staz)
            %Qui si tira a sorte la prossima stazione a partire da una
            %stazione data. Va scritto un metodo che cofronta un random con
            %la matrice delle probabilità di transizione pTrans
            IDCurr=Staz.Name;
            NextVector=Env.pTrans(IDCurr,:);
            RandNum=rand();
            unity=1;
            for i=1:length(NextVector)
                unity=unity-max(NextVector);
                if RandNum>unity
                    IDNext=find(NextVector==max(NextVector),1);
                    break;
                end
                NextVector(find(NextVector==max(NextVector),1))=0;
            end
        end
    end
    events
        SetTime
    end
    methods (Access=protected)
        function [passed,varargout]=TestPrecision(Env,precision)
            %da verificare che 20 sia un numero adatto di run
            %if Env.IDRun<2
            if Env.IDRun<10
                %numero insufficente di run, ergo...
                passed=false;
                varargout{1}=0;
                varargout{2}=0;
                varargout{3}=0;
            else
                sum=0;
%                 for i=1:size(Env.Result,2)
%                     %calcolo sum, ovvero A=sum(Y)
%                     R=Env.Result(1,i).Ew-Env.tServ(1); SBAGLIATO!!
%                     sum=sum+R;
%                 end
                
                for i=1:size(Env.Result,2)
                    Y=0;
                    for j=1:size(Env.Result,1)
                        %qui costruisco il valore di Y per un dato punto di
                        %rigenerazione
                        visua=((Env.Result(j,i).X/Env.Result(1,i).X)*Env.Result(j,i).Ew);
                        Y=Y+visua;
                    end
                    sum=sum+Y;
                end
                
                %meanR=sum/size(Env.Result,1); %valore medio di R stimato. (=r)
                if isempty(Env.AvVector)
                    %Il vettore delle coppie (A,v) è vuoto, e quindi ci
                    %metto il primo valore senza calcolare gli stimatori.
                    %avrò cura di resettare l'IDRun a zero così come i
                    %risultati.
                    %Env.AvVector=Env.AvVector.AvElement(sum,size(Env.Result,1));
                    Env.AvVector=AvElement(sum,size(Env.Result,2));
                    
                    %ATTENZIONE:possibile cambiamento alla riga 179, non
                    %devo usare la dimensione del vettore dei risultati, ma
                    %il numero di partenze dalla stazione 1
                    
                    passed=false;
                    varargout{1}=0;
                    varargout{2}=0;
                    varargout{3}=0;
                    Env.IDRun=1;
                    Env.Result=Risultati.empty;
                else
                    if(size(Env.AvVector)<2)
                        %ho già un valore di un ciclo precedente ma avrei
                        %problemi con le T di Student in qunato ho 0 gradi
                        %di libertà
                        Env.AvVector=cat(2,Env.AvVector,AvElement(sum,size(Env.Result,2)));
                        
                        %ATTENZIONE: stessa cosa della riga 179!! ma alla
                        %196
                        
                        passed=false;
                        varargout{1}=0;
                        varargout{2}=0;
                        varargout{3}=0;
                        Env.IDRun=1;
                        Env.Result=Risultati.empty;
                    else
                        % calcolo degli stimatori
%                         A=0;
%                         v=0;
%                         AA=0;
%                         vv=0;
%                         Av=0;
                        A=sum;
                        v=size(Env.Result,2);
                        
                        %ATTENZIONE: come nella riga 196, ma a 215
                        
                        AA=A*A;
                        vv=v*v;
                        Av=A*v;
                        for i=1:size(Env.AvVector,2)
                            A=A+Env.AvVector(i).A;
                            AA=AA+(Env.AvVector(i).A)^2;
                            v=v+Env.AvVector(i).v;
                            vv=vv+(Env.AvVector(i).v)^2;
                            Av=Av+(Env.AvVector(i).v*Env.AvVector(i).A);
                        end
%                         A=A+sum;
%                         v=v+size(Env.Result,1);
%                        r=A/v;
                        
                        MeanA=A/(size(Env.AvVector,2)+1);
                        MeanV=v/(size(Env.AvVector,2)+1);
                        rCap=MeanA/MeanV;
                        
                        rovp=(sqrt(size(Env.AvVector,2)/(size(Env.AvVector,2)-1)))*(sqrt(AA-2*rCap*Av+rCap^2*vv))/v;
                        %lower=r-tinv(0.025,size(Env.AvVector,2)-1)*rovp;
                        %upper=r+tinv(0.025,size(Env.AvVector,2)-1)*rovp;
                        BuffLower=rCap+tinv(0.025,size(Env.AvVector,2)-1)*rovp;
                        BuffUpper=rCap-tinv(0.025,size(Env.AvVector,2)-1)*rovp;
                        if(abs(rCap-BuffLower)<=rCap*precision)&&(abs(rCap-BuffUpper)<=rCap*precision)
                        %if(abs(Env.Lower-BuffLower)<=rCap*precision)&&(abs(Env.Upper-BuffUpper)<=rCap*precision)
                        %if (abs(lower)<=r*precision)&&(abs(upper)<=r*precision)
                            Env.AvVector=cat(2,Env.AvVector,AvElement(sum,size(Env.Result,2)));
                            passed=true;
                            varargout{1}=BuffLower;
                            varargout{2}=BuffUpper;
                            varargout{3}=rCap;
                            Env.IDRun=1;
                            Env.Result=Risultati.empty;
                        else
                            passed=false;
                            varargout{1}=BuffLower;
                            varargout{2}=BuffUpper;
                            varargout{3}=0;
                        end
                    end
                end
            end
        end
    end
end