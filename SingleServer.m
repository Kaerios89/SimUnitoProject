%congruo con funzioni
classdef SingleServer < Stazione
    methods
        function NewStaz=SingleServer(StazName,Vserv,ambiente)
            NewStaz@Stazione(StazName,Vserv,ambiente);
        end
        function deltaS=OttieniTServ(Staz)
            % fare un po' di test per validare il generatore uniforme
            deltaS=exprnd(Staz.mu^-1);
            %ho usato mu^-1 perchè per matlab l'argomento dell'exprnd è la
            %media, difatti generatempi di servizio che hanno come media il
            %valore dato in esercizio
%             v1=unifrnd(0,1);
%             v2=-log(v1);
%             deltaS=(v2/Staz.mu);
        end
        function Arrivo(Staz)
            Staz.Nsys=Staz.Nsys+1;
            Staz.Narr=Staz.Narr+1;
            deltaS=Staz.OttieniTServ();
            if Staz.Nsys==1
                %nel caso non ci sia nessuno nel sistema, si genera un
                %evento di partenza.
                part_time=Staz.Env.Time+deltaS;
                ev=evento(Staz.Env.Time,deltaS,part_time,evType.Partenza,Staz.Name);
                Staz.Env.EventList=schedula(Staz.Env.EventList,ev);
            else
                ev=evento(Staz.Env.Time,deltaS,Staz.NoTime,evType.NoType,Staz.Name);
                Staz.InputQueue=accoda(Staz.InputQueue,ev);
            end
        end
        function Partenza(Staz)
            Staz.Nsys=Staz.Nsys-1;
            Staz.Npar=Staz.Npar+1;
            if Staz.Nsys>0
                %preleva un cliente in coda e esegui il suo tempo di
                %servizio
                [ev,Staz.InputQueue]=prendi(Staz.InputQueue);
                deltaS=ev.ServTime;
                part_time=Staz.Env.Time+deltaS;
                ev.ServTime=deltaS;
                ev.OccurTime=part_time;
                ev.type=evType.Partenza;
                Staz.Env.EventList=schedula(Staz.Env.EventList,ev);
            end
            %una volta che il nuovo evento è pronto per essere eseguito
            %dalla stazione, si va a schedulare un arrivo in una delle
            %stazioni successive. La stazione prescelta ce la fornisce
            %l'Env
            NextStaz=prossima(Staz.Env,Staz);
            clear ev;
            ev=evento(Staz.Env.Time,Staz.NoTime,Staz.Env.Time,evType.Arrivo,NextStaz);
            Staz.Env.EventList=schedula(Staz.Env.EventList,ev);
        end
    end
end