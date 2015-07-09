%congruo con funzioni
classdef InfiniteServer < Stazione
    %per implementare i metodi basta usare lo stesso nome del metodo in
    %Stazione.
    methods
        function NewStaz=InfiniteServer(StazName,Vserv,ambiente)
            NewStaz@Stazione(StazName,Vserv,ambiente);
        end
        function deltaS=OttieniTServ(Staz)
            % Si genera la nuova velocità di servizio
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
                %lo si genera anche se ce ne sono di più (IS)
%                 part_time=Staz.Env.Time+deltaS;
%                 ev=evento(Staz.Env.Time,deltaS,part_time,evType.Partenza,Staz.Name);
%                 Staz.Env.EventList=schedula(Staz.Env.EventList,ev);
                ev=evento(Staz.Env.Time,deltaS,Staz.NoTime,evType.NoType,Staz.Name);
                Staz.InputQueue=accoda(Staz.InputQueue,ev);
                SpeedR=CalcSpeedRatio(Staz,evType.Arrivo);
                ReSchedule(Staz.Env.EventList,SpeedR,Staz);
            end
        end
        function Partenza(Staz)
            Staz.Nsys=Staz.Nsys-1;
            Staz.Npar=Staz.Npar+1;
            if Staz.Nsys>0
                %preleva un cliente in coda e esegui il suo tempo di
                %servizio
                [ev,Staz.InputQueue]=prendi(Staz.InputQueue);
                %
                SpeedR=CalcSpeedRatio(Staz,evType.Partenza);
                deltaS=ev.ServTime*SpeedR;
                %
                part_time=Staz.Env.Time+deltaS;
                ev.ServTime=deltaS;
                ev.OccurTime=part_time;
                ev.type=evType.Partenza;
                
                Staz.Env.EventList=schedula(Staz.Env.EventList,ev);
                %si aggiusta la schedulazione
%                 SpeedR=CalcSpeedRatio(Staz,evType.Partenza);
%                 ReSchedule(Staz.Env.EventList,SpeedR,Staz);
            end
            NextStaz=prossima(Staz.Env,Staz);
            clear ev;
            ev=evento(Staz.Env.Time,Staz.NoTime,Staz.Env.Time,evType.Arrivo,NextStaz);
            Staz.Env.EventList=schedula(Staz.Env.EventList,ev);
        end
        function SpeedR=CalcSpeedRatio(Staz,eType)
            %nella forma di old_speed/new_speed
            switch eType
                case evType.Arrivo
                    old_speed=(Staz.Nsys-1);
                    new_speed=Staz.Nsys;
                case evType.Partenza
                    old_speed=(Staz.Nsys+1);
                    new_speed=Staz.Nsys;
            end
            SpeedR=old_speed/new_speed;
        end
    end
end