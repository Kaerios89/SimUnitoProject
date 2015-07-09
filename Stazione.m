%congrua con funzioni
classdef Stazione < handle
    properties (Access=public)
       Name %nome stazione
       Env %ambiente di simulazione
       Nsys %Numero di clienti nel sistema
       Narr %Numero di arrivi nel sistema
       Npar %numero di partenze dal sistema
       Nmax %numero massimo di clienti che sono stati contemporaneamente nel sistema
       
       BusyTime % tempo totale in cui la stazione risulta occupata
       Area %area Sottesa alla curva
       X %Troughput
       U %utilizzazione
       En %No medio di clienti nel sistema
       Ew %Tempo medio di permanenza
           
       InputQueue %coda per la stazione
       
       StartTime
       NoTime
       
       mu %velocità di servizio
       
       %% Roba presente in ENV e quindi ridondante
       %goOn %flag fine simulazione da implementare nel ENV
       %RandGen %riferimento ad un generatore casuale-- in env?
       %eventList %Forse questa è meglio se è "globale"
       %Time %orologio del simulatore predente in ENV
       
       %% roba scatata per il metodo rigenerativo
       %OK_to_Stop
       %EndTime %inutile averla qui
       
       %% Roba scartata perchè non c'è una sola stazione
       %lambda %tasso d'arrivo dei clienti
   end
   methods 
       function NewStaz=Stazione(StazName,VelServ,ambiente)
           %costruttore inizializza la stazione con i valori "stndard"
           %andrà poi esteso con un altro costruttore per creare le varie
           %versioni delle stazioni
           
           %caratteristiche della stazione
           NewStaz.Name=StazName;
           NewStaz.mu=VelServ;
           NewStaz.Env=ambiente;
           
           %parametri prestazionali
           NewStaz.Nsys=0;
           NewStaz.Narr=0;
           NewStaz.Npar=0;
           NewStaz.Nmax=0;
           NewStaz.BusyTime=0;
           NewStaz.Area=0;
           NewStaz.X=0;
           NewStaz.U=0;
           NewStaz.En=0;
           NewStaz.Ew=0;
           
           %variabili d'ambiente 
           NewStaz.InputQueue=queue(); 
           NewStaz.StartTime=0;
           NewStaz.NoTime=0;
           
           %% roba presente nell'ENV e quidni ridondante
           %NewStaz.Time=ambiente.Time;
           %NewStaz.EndTime=Etime;
           %NewStaz.goOn=true;
           
           %% roba scartata per via del metodo rigenerativo
           %NewStaz.OK_to_Stop=false;
           
           %% roba scartata per via della presenza di più stazioni
           %NewStaz.lambda=Tarr;
       end
       function engine(Staz,evento)
%            if(Staz.Nsys>0)
%                 oldTime=Staz.Env.Time;
%            else
%                oldTime=0;
%            end

           oldTime=Staz.Env.Time;
           eventType=evento.type;
           %aggiungere listener corrispondente
           Staz.Env.Time=evento.OccurTime;
%           notify(Staz.Env,'SetTime',SetNewTime(evento.OccurTime));
           interval=Staz.Env.Time-oldTime;
           %if(~Staz.OK_to_Stop) %forse si usa questo.
           %if (~(Staz.OK_to_Stop && Staz.Nsys==0 && isequal(eventType,evType.Arrivo)))
               % Forse da modificare: qui, giustamete, la condizione fa si
               % che si esca veraente non solo quando lo dice il sistema,
               % ma qunado la stazione è vuota e quindi ha fainito il suo
               % ciclo. Questa funzione però non dovrebbe più competere
               % alla stazione in quanto ce ne sono altre. dovrebbe essere
               % l'abiente che decide quando bloccare tutto e richiedere il
               % salvataggio. Questo è specialmente vero se si considera il
               % metodo rigenerativo
               if(Staz.Nsys>0)
                   Staz.BusyTime=Staz.BusyTime + interval;
                   Staz.Area=Staz.Area+(interval*Staz.Nsys);
               end
               if(Staz.Nsys>Staz.Nmax)
                   Staz.Nmax=Staz.Nsys;
               end
               switch(eventType)
                   case evType.Arrivo
                       %getisce l'arrivo di uno evento nella stazione
                       %richiamando la corrispondente funzione privata
                       Staz.Arrivo();
                   case evType.Partenza
                       %gestisce la partenza dalla stazione come sopra
                       Staz.Partenza();
%% commentato perchè con il metodo rigenerativo non c'è bisogno di stop                       
%                    case evType.Stop
%                        %gestisce la procedua di arresto del simulatore
%                        %raccogliendo i dati relativi alla stazione in
%                        %oggetto
%                        Staz.EndSim(Staz);
               end
           %end
       end
       function res=report(Staz)
           % da richiamare alla fine dei giochi, forisce un file con le
           % prestazioni della stazione
           res=Risultati;
           res.U=Staz.BusyTime/Staz.Env.Time;
           res.X=Staz.Npar/Staz.Env.Time;
           %res.Ew=Staz.Area/Staz.Narr;
           res.Ew=Staz.BusyTime/Staz.Npar;
           res.En=Staz.Area/Staz.Env.Time;
           res.mu=Staz.mu;
           res.Area=Staz.Area;
           res.BusyTime=Staz.BusyTime;
           res.Nmax=Staz.Nmax;
           res.Npar=Staz.Npar;
           res.Narr=Staz.Narr;
           res.Nsys=Staz.Nsys;
       end
   end
   methods (Abstract)
       %da implementare nelle code reali
       deltaS=OttieniTServ(Staz)
       Arrivo(Staz)
       Partenza(Staz)
   end
    events
        SetTime
    end
%% commentata perchè con il metodo rigenerativo non ci si ferma mai: si continua fino a precisione x   
%    methods (Access = protected)
%        function EndSim(Staz)
%             % va a rendere OK_To_Stop vera nell'ambiente e quindi ferma
%             % tutto
%        end
%    end
%eventi generati dalle stazioni
end